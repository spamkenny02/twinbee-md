#include "player.h"
#include "mus.h"
#include "resources.h"

PlayerState players[2];
s16 playerCur;                      // joueur concerné par les appels PLAYER_* (0 = TwinBee, 1 = WinBee)
#define P players[playerCur]
#define V pv[playerCur]
#define TRAIL_N 24

// état privé d'un joueur (le second joueur a le sien) ; sprites créés au premier besoin
typedef struct
{
    s32 fx, fy;                     // position en virgule fixe 8.8 (s32 : 225 << 8 dépasse un s16)
    u16 prevJoy, lastJoy;
    s16 shotTimer;                  // délai avant apparition du tir normal (0 = rien en attente)
    s16 chargedTimer, chargedPending, shotPending;
    s16 pendX, pendY, pendCX, pendCY;     // position du joueur au moment de l'appui / du relâchement
    Sprite *sOrb[3], *sBarB[2], *sBarS[2];
    s16 barKind;                    // 0 aucune, 1 grande, 2 petite : les sprites de barrière n'existent que tant qu'elle dure (VRAM sprites très serrée)
    s16 trailX[TRAIL_N], trailY[TRAIL_N];     // historique de la position du joueur (une entrée par frame)
    bool trailOn;
    Sprite *sBody, *sArmL, *sArmR, *sShot, *sShot2, *sHalo;
    s16 phaseTimer, deathX, deathY;
    Sprite *sDead0, *sDead;         // explosion du vaisseau
    Sprite *sC1L, *sC1R, *sC2L, *sC2M, *sC2R, *sC2T;
} Priv;
static Priv pv[2];
static u16 lastFrame;

static Sprite* add(const SpriteDefinition* def, u16 pal, u16 depth)
{
    Sprite* s = SPR_addSprite(def, 0, -64, TILE_ATTR(pal, FALSE, FALSE, FALSE));
    if (!s) return NULL;
    SPR_setDepth(s, depth);
    SPR_setVisibility(s, HIDDEN);
    return s;
}

static void place(Sprite* s, s16 x, s16 y)
{
    SPR_setPosition(s, x + PF_XOFF, y);
}

static void createSprites(void)
{
    V.sBody = add(playerCur ? &spr_body2 : &spr_body, PAL2, 1);
    V.sArmL = add(playerCur ? &spr_arm2 : &spr_arm, PAL2, 2);
    V.sArmR = add(playerCur ? &spr_arm2 : &spr_arm, PAL2, 2);
    { s16 i; for (i = 0; i < 3; i++) V.sOrb[i] = NULL; }       // créés à la demande : le moteur de sprites est limité à 80 objets
    V.sBarB[0] = V.sBarB[1] = V.sBarS[0] = V.sBarS[1] = NULL; V.barKind = 0;
    V.sHalo = add(&spr_halo, PAL2, 0);
    V.sShot = add(&spr_shot, PAL3, 3);
    V.sShot2 = add(&spr_shot, PAL3, 3);
    V.sC1L = add(&spr_c1, PAL2, 3);
    V.sC1R = add(&spr_c1, PAL2, 3);
    V.sC2L = add(&spr_c2s, PAL2, 3);
    V.sC2M = add(&spr_c2m, PAL2, 3);
    V.sC2R = add(&spr_c2s, PAL2, 3);
    V.sC2T = add(&spr_c2t, PAL2, 3);
    V.sDead0 = add(&spr_ex0, PAL2, 0);
    V.sDead = add(&spr_ex, PAL2, 0);
    SPR_setHFlip(V.sArmR, TRUE);
    SPR_setHFlip(V.sC1R, TRUE);
    SPR_setHFlip(V.sC2R, TRUE);
    SPR_setVisibility(V.sBody, VISIBLE);
    SPR_setVisibility(V.sArmL, VISIBLE);
    SPR_setVisibility(V.sArmR, VISIBLE);
}

void PLAYER_init(void)
{
    memset(players, 0, sizeof(players));
    memset(pv, 0, sizeof(pv));
    playerCur = 0;
    createSprites();
    V.fx = (s32) PLAYER_START_X << 8;
    V.fy = (s32) PLAYER_START_Y << 8;
    P.active = TRUE;
    P.x = PLAYER_START_X;
    P.y = PLAYER_START_Y;
    P.lives = START_LIVES;
    P.speedLvl = PLAYER_SPEED_LVL0;
}

// le joueur 2 (WinBee) rejoint la partie : entre par le bas en (160, 255), 2 vies ; relevé sur la trace PCE (RUN sur la manette 2)
void PLAYER_join(void)
{
    if (players[1].active) return;
    playerCur = 1;
    createSprites();
    P.active = TRUE;
    P.x = PLAYER_START_X2; P.y = RESPAWN_Y;
    V.fx = (s32) P.x << 8; V.fy = (s32) P.y << 8;
    P.lives = START_LIVES2;
    P.speedLvl = PLAYER_SPEED_LVL0;
    P.phase = 2; P.inv = RESPAWN_INV;
    playerCur = 0;
}

static void updateShip(u16 joy)
{
    const s32 spd = 0x80 + P.speedLvl * 0x40;

    if (joy & BUTTON_RIGHT) V.fx += spd;
    if (joy & BUTTON_LEFT) V.fx -= spd;
    if (joy & BUTTON_DOWN) V.fy += spd;
    if (joy & BUTTON_UP) V.fy -= spd;
    if (V.fx < ((s32) PLAYER_MIN_X << 8)) V.fx = (s32) PLAYER_MIN_X << 8;
    if (V.fx > ((s32) PLAYER_MAX_X << 8)) V.fx = (s32) PLAYER_MAX_X << 8;
    if (V.fy < ((s32) PLAYER_MIN_Y << 8)) V.fy = (s32) PLAYER_MIN_Y << 8;
    if (V.fy > ((s32) PLAYER_MAX_Y << 8)) V.fy = (s32) PLAYER_MAX_Y << 8;
    P.x = V.fx >> 8;
    P.y = V.fy >> 8;
}

static bool armShown(s16 bit)
{
    if (!(P.armLost & bit)) return TRUE;
    if (P.armBlink == bit) return !(((lastFrame + ARM_BLINK_PHASE) >> 2) & 1);
    return FALSE;
}

static void drawShip(u16 joy)
{
    const s16 x = P.x, y = P.y;

    // trois sprites 16x16 : corps + deux bras ; le vaisseau s'incline à gauche et à droite
    place(V.sBody, x - 8, y - 8);
    if ((joy & BUTTON_RIGHT) && !(joy & BUTTON_LEFT))
    {
        SPR_setFrame(V.sBody, 1); SPR_setHFlip(V.sBody, FALSE);
        place(V.sArmL, x - 13, y - 10); place(V.sArmR, x - 4, y - 5);
    }
    else if ((joy & BUTTON_LEFT) && !(joy & BUTTON_RIGHT))
    {
        SPR_setFrame(V.sBody, 1); SPR_setHFlip(V.sBody, TRUE);
        place(V.sArmL, x - 12, y - 5); place(V.sArmR, x - 3, y - 10);
    }
    else
    {
        SPR_setFrame(V.sBody, 0); SPR_setHFlip(V.sBody, FALSE);
        place(V.sArmL, x - 16, y - 9); place(V.sArmR, x, y - 9);
    }
    P.armHidden = (armShown(1) ? 0 : 1) | (armShown(2) ? 0 : 2);
    SPR_setVisibility(V.sArmL, armShown(1) ? VISIBLE : HIDDEN);
    SPR_setVisibility(V.sArmR, armShown(2) ? VISIBLE : HIDDEN);
}

static void updateShots(u16 joy, u16 frame)
{
    const u16 pressed = joy & ~V.prevJoy & BUTTON_B;
    // --- tirs normaux en vol (deux emplacements)
    if (P.shotActive)
    {
        P.shotY -= SHOT_SPEED;
        if (P.shotY < -8) P.shotActive = FALSE;
    }
    if (P.shot2Active)
    {
        P.shot2Y -= SHOT_SPEED;
        if (P.shot2Y < -8) P.shot2Active = FALSE;
    }
    if (V.shotTimer && (--V.shotTimer == 0))
    {
        // position prise au moment de l'appui, pas à l'apparition
        SFX_play(SFX_SHOT);
        if (V.shotPending == 1) { P.shotActive = TRUE; P.shotX = V.pendX; P.shotY = V.pendY; P.shotTw = (P.flags & PW_TWIN) ? 1 : 0; }
        else { P.shot2Active = TRUE; P.shot2X = V.pendX; P.shot2Y = V.pendY; P.shot2Tw = (P.flags & PW_TWIN) ? 1 : 0; }
        V.shotPending = 0;
    }

    // --- tir chargé en vol
    if (P.chargedLevel)
    {
        P.chargedY -= SHOT_SPEED;
        if (P.chargedY < ((P.chargedLevel == 2) ? -80 : -30)) P.chargedLevel = 0;
    }
    if (V.chargedTimer && (--V.chargedTimer == 0))
    {
        P.chargedLevel = V.chargedPending;
        P.chargedX = V.pendCX;
        P.chargedY = (V.chargedPending == 2) ? (V.pendCY - 38) : (V.pendCY - 6);
        V.chargedPending = 0;
    }

    // --- bouton de tir : même enchaînement que la routine d'origine
    if (P.charge == 0)
    {
        if (!pressed) return;                       // bouton relâché : rien, le délai de tir ne décompte pas
        P.charge = 1;
    }
    else if (joy & BUTTON_B)
    {
        // la charge ne monte pas tant qu'un tir chargé est à l'écran
        if (!P.chargedLevel && !V.chargedPending && (P.charge < CHARGE_MAX)) P.charge++;
    }
    else
    {
        if (P.charge >= CHARGE_LVL1)
        {
            V.chargedPending = (P.charge >= CHARGE_MAX) ? 2 : 1;
            V.chargedTimer = SHOT_DELAY;
            V.pendCX = P.x; V.pendCY = P.y;
        }
        P.charge = 0;
        return;
    }
    // tir normal : délai entre deux tirs, puis premier emplacement libre
    if (P.shotCooldown) { P.shotCooldown--; return; }
    if (!pressed) return;
    if (!P.shotActive && (V.shotPending != 1)) V.shotPending = 1;
    else if (!P.shot2Active && (V.shotPending != 2)) V.shotPending = 2;
    else return;
    V.shotTimer = SHOT_DELAY;
    V.pendX = P.x - 8; V.pendY = P.y - 14;
    P.shotCooldown = SHOT_COOLDOWN;
}

static void drawShots(u16 frame)
{
    const u16 flash = (!(frame & 1) && (((frame + 10) & 15) < 8)) ? 1 : 0;   // alternance des 2 palettes PCE

    SPR_setVisibility(V.sShot, P.shotActive ? VISIBLE : HIDDEN);
    if (P.shotActive) { SPR_setFrame(V.sShot, P.shotTw); place(V.sShot, P.shotX, P.shotY); }
    SPR_setVisibility(V.sShot2, P.shot2Active ? VISIBLE : HIDDEN);
    if (P.shot2Active) { SPR_setFrame(V.sShot2, P.shot2Tw); place(V.sShot2, P.shot2X, P.shot2Y); }

    {
        // halo : table de l'original indexée par (compteur global >> 3) & 3 ; la phase 0 n'affiche rien
        const u16 phase = ((frame + 84) >> 3) & 3;
        if ((P.charge >= CHARGE_HALO) && phase)
        {
            SPR_setVisibility(V.sHalo, VISIBLE);
            SPR_setFrame(V.sHalo, phase - 1);
            place(V.sHalo, P.x - 8, P.y - 24);
        }
        else SPR_setVisibility(V.sHalo, HIDDEN);
    }

    SPR_setVisibility(V.sC1L, (P.chargedLevel == 1) ? VISIBLE : HIDDEN);
    SPR_setVisibility(V.sC1R, (P.chargedLevel == 1) ? VISIBLE : HIDDEN);
    if (P.chargedLevel == 1)
    {
        SPR_setFrame(V.sC1L, flash); SPR_setFrame(V.sC1R, flash);
        place(V.sC1L, P.chargedX - 16, P.chargedY);
        place(V.sC1R, P.chargedX, P.chargedY);
    }
    if (P.chargedLevel == 2)
    {
        const s16 y = P.chargedY;
        // les trois colonnes de 64 px sortent à y < -62, la traîne à y+64 < -16 (comme sur PCE)
        SPR_setVisibility(V.sC2L, (y >= -62) ? VISIBLE : HIDDEN);
        SPR_setVisibility(V.sC2M, (y >= -62) ? VISIBLE : HIDDEN);
        SPR_setVisibility(V.sC2R, (y >= -62) ? VISIBLE : HIDDEN);
        SPR_setVisibility(V.sC2T, VISIBLE);
        SPR_setFrame(V.sC2L, flash); SPR_setFrame(V.sC2M, flash); SPR_setFrame(V.sC2R, flash); SPR_setFrame(V.sC2T, flash);
        place(V.sC2L, P.chargedX - 24, y);
        place(V.sC2M, P.chargedX - 8, y);
        place(V.sC2R, P.chargedX + 8, y);
        place(V.sC2T, P.chargedX - 8, y + 64);
    }
    else
    {
        SPR_setVisibility(V.sC2L, HIDDEN); SPR_setVisibility(V.sC2M, HIDDEN);
        SPR_setVisibility(V.sC2R, HIDDEN); SPR_setVisibility(V.sC2T, HIDDEN);
    }
}


s16 PLAYER_contact(bool armZone, bool enemyLeft)
{
    if (P.phase || P.inv) return CONTACT_NONE;
    if (P.barrier > 0)         // la barrière absorbe le coup (10 coups, boîte réduite à partir de 4)
    {
        if (--P.barrier == 0) P.flags &= ~PW_BARRIER;
        SFX_play(SFX_BELLHIT);
        return CONTACT_ARM;
    }
    if (!armZone) { PLAYER_kill(); return CONTACT_BODY; }
    // zone de bras : AF67 teste le bras gauche (ennemi à gauche), sinon AF84 le bras droit
    {
        bool left;
        if (P.armBlink == 1) left = TRUE;
        else if (P.armLost & 1) left = FALSE;
        else left = enemyLeft;
        if (left)
        {
            if (P.armBlink != 1) { P.armBlink = 1; P.armLost |= 1; P.armTimer = ARM_BLINK_FRAMES; }
            return CONTACT_ARM;
        }
        else
        {
            bool right;
            if (P.armBlink == 2) right = TRUE;
            else if (P.armLost & 2) right = FALSE;
            else right = !enemyLeft;
            if (!right) return CONTACT_NONE;
            if (P.armBlink != 2) { P.armBlink = 2; P.armLost |= 2; P.armTimer = ARM_BLINK_FRAMES; }
            return CONTACT_ARM;
        }
    }
}

void PLAYER_kill(void)
{
    if (P.phase || P.inv) return;
    P.phase = 1;
    V.phaseTimer = 0;
    V.deathX = P.x; V.deathY = P.y;
    P.charge = 0;
}

void PLAYER_update(s16 n, u16 joy, u16 frame)
{
    playerCur = n;
    lastFrame = frame;
    if (P.phase == 3) { updateShots(0, frame); return; }        // plus de vie, l'autre joueur continue
    if (P.armTimer && (--P.armTimer == 0)) P.armBlink = 0;
    if (P.phase == 1)
    {
        // touché : explosion sur place, puis le vaisseau tombe
        V.phaseTimer++;
        if (V.phaseTimer > DEATH_EXPLODE)
        {
            // la chute ne démarre vraiment que 2 frames plus tard
            if ((V.phaseTimer > (DEATH_EXPLODE + 2)) && (P.y < 246)) { P.y += 3; if (P.y > 246) P.y = 246; }
            if ((P.y >= 246) && (V.phaseTimer > (DEATH_EXPLODE + DEATH_FALL_MIN)))
            {
                if (--P.lives <= 0) { P.gameOver = TRUE; if (players[0].active && players[1].active) { P.phase = 3; V.phaseTimer = 0; P.inv = 0; P.armLost = 0; P.armBlink = 0; P.armTimer = 0; P.flags = 0; P.barrier = 0; V.trailOn = FALSE; updateShots(0, frame); V.prevJoy = 0; V.lastJoy = 0; return; } }
                P.phase = 2; V.phaseTimer = 0;
                P.armLost = 0; P.armBlink = 0; P.armTimer = 0;
                P.speedLvl = PLAYER_SPEED_LVL0; P.flags = 0; P.barrier = 0; V.trailOn = FALSE;      // les bonus sont perdus à la mort (mesuré : $3954 et $3438 remis à zéro)
                P.x = playerCur ? PLAYER_START_X2 : PLAYER_START_X; P.y = RESPAWN_Y;
                P.inv = RESPAWN_INV;
            }
        }
        updateShots(0, frame);
        V.prevJoy = 0; V.lastJoy = 0;
        return;
    }
    if (P.phase == 2)
    {
        // réapparition : montée depuis le bas de l'écran, sans commandes
        P.y -= 2;
        if (P.inv) P.inv--;
        if (++V.phaseTimer >= 48)
        {
            P.phase = 0;
            P.y = PLAYER_START_Y;
            V.fx = (s32) P.x << 8; V.fy = (s32) P.y << 8;
        }
        updateShots(0, frame);
        V.prevJoy = 0; V.lastJoy = 0;
        return;
    }
    if (P.inv) P.inv--;
    updateShip(joy);
    {   // historique de position pour les options (trois mini-abeilles, retard de 7, 15 et 23 frames)
        s16 i;
        const bool opt = (P.flags & (PW_OPT1 | PW_OPT2)) != 0;
        if (opt && !V.trailOn) for (i = 0; i < TRAIL_N; i++) { V.trailX[i] = P.x; V.trailY[i] = P.y; }
        V.trailOn = opt;
        if (opt)
        {
            for (i = TRAIL_N - 1; i > 0; i--) { V.trailX[i] = V.trailX[i - 1]; V.trailY[i] = V.trailY[i - 1]; }
            V.trailX[0] = P.x; V.trailY[0] = P.y;
        }
    }
    updateShots(joy, frame);
    V.prevJoy = joy;
    V.lastJoy = joy;
}

void PLAYER_draw(s16 n)
{
    playerCur = n;
    // clignotement tant que l'invincibilité court : 4 frames visible, 4 frames caché
    const bool blink = P.inv && ((P.inv >> 2) & 1);
    const s16 t = V.phaseTimer;

    SPR_setVisibility(V.sDead0, HIDDEN); SPR_setVisibility(V.sDead, HIDDEN);
    if (P.phase == 3)
    {
        SPR_setVisibility(V.sBody, HIDDEN); SPR_setVisibility(V.sArmL, HIDDEN); SPR_setVisibility(V.sArmR, HIDDEN);
    }
    else if (P.phase == 1)
    {
        const bool falling = t > DEATH_EXPLODE;
        // le vaisseau reste 2 frames, disparaît dans l'explosion, puis retombe en tournoyant (corps seul)
        SPR_setVisibility(V.sArmL, (t <= 2) ? VISIBLE : HIDDEN); SPR_setVisibility(V.sArmR, (t <= 2) ? VISIBLE : HIDDEN);
        SPR_setVisibility(V.sBody, ((t <= 2) || falling) ? VISIBLE : HIDDEN);
        if (falling)
        {
            SPR_setFrame(V.sBody, 1); SPR_setHFlip(V.sBody, (t >> 2) & 1);
            place(V.sBody, P.x - 8, P.y - 14);
        }
        if ((t > 2) && (t <= 9)) { SPR_setVisibility(V.sDead0, VISIBLE); place(V.sDead0, V.deathX - 8, V.deathY - 8); }
        else if ((t > 9) && (t <= 33)) { SPR_setVisibility(V.sDead, VISIBLE); SPR_setFrame(V.sDead, (t - 10) >> 3); place(V.sDead, V.deathX - 16, V.deathY - 16); }
    }
    else
    {
        SPR_setVisibility(V.sBody, blink ? HIDDEN : VISIBLE); SPR_setVisibility(V.sArmL, blink ? HIDDEN : VISIBLE); SPR_setVisibility(V.sArmR, blink ? HIDDEN : VISIBLE);
        drawShip(V.lastJoy);
    }
    {
        s16 i;
        const bool show = V.trailOn && (P.phase == 0) && !blink;
        const bool have = V.trailOn;
        for (i = 0; i < 3; i++)
        {
            if (have && !V.sOrb[i]) V.sOrb[i] = add(playerCur ? &spr_orb2 : &spr_orb, PAL2, 2);
            if (!have && V.sOrb[i]) { SPR_releaseSprite(V.sOrb[i]); V.sOrb[i] = NULL; }
            if (!V.sOrb[i]) continue;
            SPR_setVisibility(V.sOrb[i], show ? VISIBLE : HIDDEN);
            if (show) place(V.sOrb[i], V.trailX[7 + 8 * i] - 8, V.trailY[7 + 8 * i] - 12);
        }
    }
    {   // barrière : deux quarts de dôme en diagonale, une diagonale sur deux (scintillement de 1 frame comme sur PCE)
        const bool on = (P.barrier > 0) && (P.phase == 0);
        const s16 want = (P.barrier <= 0) ? 0 : ((P.barrier >= 4) ? 1 : 2);
        const s16 d = (want == 1) ? 32 : 16;
        const bool alt = lastFrame & 1;
        s16 i;
        if (want != V.barKind)
        {
            for (i = 0; i < 2; i++)
            {
                if (V.sBarB[i]) { SPR_releaseSprite(V.sBarB[i]); V.sBarB[i] = NULL; }
                if (V.sBarS[i]) { SPR_releaseSprite(V.sBarS[i]); V.sBarS[i] = NULL; }
            }
            if (want)
            {   // le second sprite partage les tuiles du premier (même image, seul le retournement change)
                const SpriteDefinition* def = (want == 1) ? &spr_bar_big : &spr_bar_small;
                Sprite* a = SPR_addSpriteSafe(def, 0, -64, TILE_ATTR(PAL3, FALSE, FALSE, FALSE));
                Sprite* b = NULL;
                if (a)
                {
                    b = SPR_addSpriteEx(def, 0, -64, TILE_ATTR_FULL(PAL3, FALSE, FALSE, FALSE, a->attribut & TILE_INDEX_MASK), SPR_FLAG_AUTO_VISIBILITY);
                    if (b) { SPR_setDepth(a, 1); SPR_setDepth(b, 1); }
                }
                if (want == 1) { V.sBarB[0] = a; V.sBarB[1] = b; } else { V.sBarS[0] = a; V.sBarS[1] = b; }
            }
            V.barKind = want;
        }
        for (i = 0; i < 2; i++)
        {
            Sprite* sp = (want == 1) ? V.sBarB[i] : V.sBarS[i];
            const bool right = (i == 0) ? alt : !alt;       // diagonale haut-gauche / bas-droit, puis haut-droit / bas-gauche
            const bool low = (i == 1);
            if (!sp) continue;
            SPR_setVisibility(sp, on ? VISIBLE : HIDDEN);
            SPR_setHFlip(sp, right); SPR_setVFlip(sp, low);
            place(sp, P.x + (right ? 0 : -d), P.y + (low ? 0 : -d));
        }
    }
    drawShots(lastFrame);
}

// Les deux vaisseaux ne peuvent pas se superposer : relevé sur la trace PCE (P1 pousse P2 vers la droite à demi-vitesse, puis P2 est chassé en y
// quand P1 monte), distance minimale 16 px sur au moins un axe. Résolution symétrique le long de l'axe le moins pénétré.
void PLAYER_collide(void)
{
    s32 dx, dy, ax, ay;
    Priv* a = &pv[0];
    Priv* b = &pv[1];
    if (!players[0].active || !players[1].active || players[0].phase || players[1].phase) return;
    dx = b->fx - a->fx; dy = b->fy - a->fy;
    ax = (dx < 0) ? -dx : dx; ay = (dy < 0) ? -dy : dy;
    if ((ax >= (16L << 8)) || (ay >= (16L << 8))) return;
    if ((16L << 8) - ax <= (16L << 8) - ay)
    {
        const s32 h = ((16L << 8) - ax) / 2 + 1;
        const s32 s = (dx < 0) ? -1 : 1;           // sens de b par rapport à a
        a->fx -= s * h; b->fx += s * h;
    }
    else
    {
        const s32 h = ((16L << 8) - ay) / 2 + 1;
        const s32 s = (dy < 0) ? -1 : 1;
        a->fy -= s * h; b->fy += s * h;
    }
    {
        s16 i;
        for (i = 0; i < 2; i++)
        {
            Priv* v = &pv[i];
            if (v->fx < ((s32) PLAYER_MIN_X << 8)) v->fx = (s32) PLAYER_MIN_X << 8;
            if (v->fx > ((s32) PLAYER_MAX_X << 8)) v->fx = (s32) PLAYER_MAX_X << 8;
            if (v->fy < ((s32) PLAYER_MIN_Y << 8)) v->fy = (s32) PLAYER_MIN_Y << 8;
            if (v->fy > ((s32) PLAYER_MAX_Y << 8)) v->fy = (s32) PLAYER_MAX_Y << 8;
            players[i].x = v->fx >> 8; players[i].y = v->fy >> 8;
        }
    }
}
