#include "player.h"
#include "resources.h"

PlayerState player;

static s32 fx, fy;                  // position en virgule fixe 8.8 (s32 : 225 << 8 dépasse un s16)
static u16 prevJoy;
static s16 shotTimer;               // délai avant apparition du tir normal (0 = rien en attente)
static s16 chargedTimer, chargedPending, shotPending;
static s16 pendX, pendY, pendCX, pendCY;     // position du joueur au moment de l'appui / du relâchement

static Sprite *sBody, *sArmL, *sArmR, *sShot, *sShot2, *sHalo;
static s16 phaseTimer, deathX, deathY;
static u16 lastFrame;
static Sprite *sDead0, *sDead;         // explosion du vaisseau
static Sprite *sC1L, *sC1R, *sC2L, *sC2M, *sC2R, *sC2T;

static Sprite* add(const SpriteDefinition* def, u16 pal, u16 depth)
{
    Sprite* s = SPR_addSprite(def, 0, -64, TILE_ATTR(pal, FALSE, FALSE, FALSE));
    SPR_setDepth(s, depth);
    SPR_setVisibility(s, HIDDEN);
    return s;
}

static void place(Sprite* s, s16 x, s16 y)
{
    SPR_setPosition(s, x + PF_XOFF, y);
}

void PLAYER_init(void)
{
    sBody = add(&spr_body, PAL2, 1);
    sArmL = add(&spr_arm, PAL2, 2);
    sArmR = add(&spr_arm, PAL2, 2);
    sHalo = add(&spr_halo, PAL2, 0);
    sShot = add(&spr_shot, PAL3, 3);
    sShot2 = add(&spr_shot, PAL3, 3);
    sC1L = add(&spr_c1, PAL2, 3);
    sC1R = add(&spr_c1, PAL2, 3);
    sC2L = add(&spr_c2s, PAL2, 3);
    sC2M = add(&spr_c2m, PAL2, 3);
    sC2R = add(&spr_c2s, PAL2, 3);
    sC2T = add(&spr_c2t, PAL2, 3);
    sDead0 = add(&spr_ex0, PAL2, 0);
    sDead = add(&spr_ex, PAL2, 0);
    SPR_setHFlip(sArmR, TRUE);
    SPR_setHFlip(sC1R, TRUE);
    SPR_setHFlip(sC2R, TRUE);
    SPR_setVisibility(sBody, VISIBLE);
    SPR_setVisibility(sArmL, VISIBLE);
    SPR_setVisibility(sArmR, VISIBLE);

    fx = (s32) PLAYER_START_X << 8;
    fy = (s32) PLAYER_START_Y << 8;
    prevJoy = 0;
    shotTimer = 0;
    chargedTimer = 0;
    chargedPending = 0;
    shotPending = 0;
    memset(&player, 0, sizeof(player));
    player.x = PLAYER_START_X;
    player.y = PLAYER_START_Y;
    player.lives = START_LIVES;
    phaseTimer = 0;
}

static void updateShip(u16 joy)
{

    if (joy & BUTTON_RIGHT) fx += PLAYER_SPEED;
    if (joy & BUTTON_LEFT) fx -= PLAYER_SPEED;
    if (joy & BUTTON_DOWN) fy += PLAYER_SPEED;
    if (joy & BUTTON_UP) fy -= PLAYER_SPEED;
    if (fx < ((s32) PLAYER_MIN_X << 8)) fx = (s32) PLAYER_MIN_X << 8;
    if (fx > ((s32) PLAYER_MAX_X << 8)) fx = (s32) PLAYER_MAX_X << 8;
    if (fy < ((s32) PLAYER_MIN_Y << 8)) fy = (s32) PLAYER_MIN_Y << 8;
    if (fy > ((s32) PLAYER_MAX_Y << 8)) fy = (s32) PLAYER_MAX_Y << 8;
    player.x = fx >> 8;
    player.y = fy >> 8;
}

static bool armShown(s16 bit)
{
    if (!(player.armLost & bit)) return TRUE;
    if (player.armBlink == bit) return !(((lastFrame + ARM_BLINK_PHASE) >> 2) & 1);
    return FALSE;
}

static void drawShip(u16 joy)
{
    const s16 x = player.x, y = player.y;

    // trois sprites 16x16 : corps + deux bras ; le vaisseau s'incline à gauche et à droite
    place(sBody, x - 8, y - 8);
    if ((joy & BUTTON_RIGHT) && !(joy & BUTTON_LEFT))
    {
        SPR_setFrame(sBody, 1); SPR_setHFlip(sBody, FALSE);
        place(sArmL, x - 13, y - 10); place(sArmR, x - 4, y - 5);
    }
    else if ((joy & BUTTON_LEFT) && !(joy & BUTTON_RIGHT))
    {
        SPR_setFrame(sBody, 1); SPR_setHFlip(sBody, TRUE);
        place(sArmL, x - 12, y - 5); place(sArmR, x - 3, y - 10);
    }
    else
    {
        SPR_setFrame(sBody, 0); SPR_setHFlip(sBody, FALSE);
        place(sArmL, x - 16, y - 9); place(sArmR, x, y - 9);
    }
    player.armHidden = (armShown(1) ? 0 : 1) | (armShown(2) ? 0 : 2);
    SPR_setVisibility(sArmL, armShown(1) ? VISIBLE : HIDDEN);
    SPR_setVisibility(sArmR, armShown(2) ? VISIBLE : HIDDEN);
}

static void updateShots(u16 joy, u16 frame)
{
    const u16 pressed = joy & ~prevJoy & BUTTON_B;
    // --- tirs normaux en vol (deux emplacements)
    if (player.shotActive)
    {
        player.shotY -= SHOT_SPEED;
        if (player.shotY < -8) player.shotActive = FALSE;
    }
    if (player.shot2Active)
    {
        player.shot2Y -= SHOT_SPEED;
        if (player.shot2Y < -8) player.shot2Active = FALSE;
    }
    if (shotTimer && (--shotTimer == 0))
    {
        // position prise au moment de l'appui, pas à l'apparition
        if (shotPending == 1) { player.shotActive = TRUE; player.shotX = pendX; player.shotY = pendY; }
        else { player.shot2Active = TRUE; player.shot2X = pendX; player.shot2Y = pendY; }
        shotPending = 0;
    }

    // --- tir chargé en vol
    if (player.chargedLevel)
    {
        player.chargedY -= SHOT_SPEED;
        if (player.chargedY < ((player.chargedLevel == 2) ? -80 : -30)) player.chargedLevel = 0;
    }
    if (chargedTimer && (--chargedTimer == 0))
    {
        player.chargedLevel = chargedPending;
        player.chargedX = pendCX;
        player.chargedY = (chargedPending == 2) ? (pendCY - 38) : (pendCY - 6);
        chargedPending = 0;
    }

    // --- bouton de tir : même enchaînement que la routine d'origine
    if (player.charge == 0)
    {
        if (!pressed) return;                       // bouton relâché : rien, le délai de tir ne décompte pas
        player.charge = 1;
    }
    else if (joy & BUTTON_B)
    {
        // la charge ne monte pas tant qu'un tir chargé est à l'écran
        if (!player.chargedLevel && !chargedPending && (player.charge < CHARGE_MAX)) player.charge++;
    }
    else
    {
        if (player.charge >= CHARGE_LVL1)
        {
            chargedPending = (player.charge >= CHARGE_MAX) ? 2 : 1;
            chargedTimer = SHOT_DELAY;
            pendCX = player.x; pendCY = player.y;
        }
        player.charge = 0;
        return;
    }
    // tir normal : délai entre deux tirs, puis premier emplacement libre
    if (player.shotCooldown) { player.shotCooldown--; return; }
    if (!pressed) return;
    if (!player.shotActive && (shotPending != 1)) shotPending = 1;
    else if (!player.shot2Active && (shotPending != 2)) shotPending = 2;
    else return;
    shotTimer = SHOT_DELAY;
    pendX = player.x - 8; pendY = player.y - 14;
    player.shotCooldown = SHOT_COOLDOWN;
}

static void drawShots(u16 frame)
{
    const u16 flash = (!(frame & 1) && (((frame + 10) & 15) < 8)) ? 1 : 0;   // alternance des 2 palettes PCE

    SPR_setVisibility(sShot, player.shotActive ? VISIBLE : HIDDEN);
    if (player.shotActive) place(sShot, player.shotX, player.shotY);
    SPR_setVisibility(sShot2, player.shot2Active ? VISIBLE : HIDDEN);
    if (player.shot2Active) place(sShot2, player.shot2X, player.shot2Y);

    {
        // halo : table de l'original indexée par (compteur global >> 3) & 3 ; la phase 0 n'affiche rien
        const u16 phase = ((frame + 84) >> 3) & 3;
        if ((player.charge >= CHARGE_HALO) && phase)
        {
            SPR_setVisibility(sHalo, VISIBLE);
            SPR_setFrame(sHalo, phase - 1);
            place(sHalo, player.x - 8, player.y - 24);
        }
        else SPR_setVisibility(sHalo, HIDDEN);
    }

    SPR_setVisibility(sC1L, (player.chargedLevel == 1) ? VISIBLE : HIDDEN);
    SPR_setVisibility(sC1R, (player.chargedLevel == 1) ? VISIBLE : HIDDEN);
    if (player.chargedLevel == 1)
    {
        SPR_setFrame(sC1L, flash); SPR_setFrame(sC1R, flash);
        place(sC1L, player.chargedX - 16, player.chargedY);
        place(sC1R, player.chargedX, player.chargedY);
    }
    if (player.chargedLevel == 2)
    {
        const s16 y = player.chargedY;
        // les trois colonnes de 64 px sortent à y < -62, la traîne à y+64 < -16 (comme sur PCE)
        SPR_setVisibility(sC2L, (y >= -62) ? VISIBLE : HIDDEN);
        SPR_setVisibility(sC2M, (y >= -62) ? VISIBLE : HIDDEN);
        SPR_setVisibility(sC2R, (y >= -62) ? VISIBLE : HIDDEN);
        SPR_setVisibility(sC2T, VISIBLE);
        SPR_setFrame(sC2L, flash); SPR_setFrame(sC2M, flash); SPR_setFrame(sC2R, flash); SPR_setFrame(sC2T, flash);
        place(sC2L, player.chargedX - 24, y);
        place(sC2M, player.chargedX - 8, y);
        place(sC2R, player.chargedX + 8, y);
        place(sC2T, player.chargedX - 8, y + 64);
    }
    else
    {
        SPR_setVisibility(sC2L, HIDDEN); SPR_setVisibility(sC2M, HIDDEN);
        SPR_setVisibility(sC2R, HIDDEN); SPR_setVisibility(sC2T, HIDDEN);
    }
}

static u16 lastJoy;

s16 PLAYER_contact(bool armZone, bool enemyLeft)
{
    if (player.phase || player.inv) return CONTACT_NONE;
    if (!armZone) { PLAYER_kill(); return CONTACT_BODY; }
    // zone de bras : AF67 teste le bras gauche (ennemi à gauche), sinon AF84 le bras droit
    {
        bool left;
        if (player.armBlink == 1) left = TRUE;
        else if (player.armLost & 1) left = FALSE;
        else left = enemyLeft;
        if (left)
        {
            if (player.armBlink != 1) { player.armBlink = 1; player.armLost |= 1; player.armTimer = ARM_BLINK_FRAMES; }
            return CONTACT_ARM;
        }
        else
        {
            bool right;
            if (player.armBlink == 2) right = TRUE;
            else if (player.armLost & 2) right = FALSE;
            else right = !enemyLeft;
            if (!right) return CONTACT_NONE;
            if (player.armBlink != 2) { player.armBlink = 2; player.armLost |= 2; player.armTimer = ARM_BLINK_FRAMES; }
            return CONTACT_ARM;
        }
    }
}

void PLAYER_kill(void)
{
    if (player.phase || player.inv) return;
    player.phase = 1;
    phaseTimer = 0;
    deathX = player.x; deathY = player.y;
    player.charge = 0;
}

void PLAYER_update(u16 joy, u16 frame)
{
    lastFrame = frame;
    if (player.armTimer && (--player.armTimer == 0)) player.armBlink = 0;
    if (player.phase == 1)
    {
        // touché : explosion sur place, puis le vaisseau tombe
        phaseTimer++;
        if (phaseTimer > DEATH_EXPLODE)
        {
            // la chute ne démarre vraiment que 2 frames plus tard
            if ((phaseTimer > (DEATH_EXPLODE + 2)) && (player.y < 246)) { player.y += 3; if (player.y > 246) player.y = 246; }
            if ((player.y >= 246) && (phaseTimer > (DEATH_EXPLODE + DEATH_FALL_MIN)))
            {
                if (--player.lives <= 0) player.gameOver = TRUE;
                player.phase = 2; phaseTimer = 0;
                player.armLost = 0; player.armBlink = 0; player.armTimer = 0;
                player.x = PLAYER_START_X; player.y = RESPAWN_Y;
                player.inv = RESPAWN_INV;
            }
        }
        updateShots(0, frame);
        prevJoy = 0; lastJoy = 0;
        return;
    }
    if (player.phase == 2)
    {
        // réapparition : montée depuis le bas de l'écran, sans commandes
        player.y -= 2;
        if (player.inv) player.inv--;
        if (++phaseTimer >= 48)
        {
            player.phase = 0;
            player.y = PLAYER_START_Y;
            fx = (s32) player.x << 8; fy = (s32) player.y << 8;
        }
        updateShots(0, frame);
        prevJoy = 0; lastJoy = 0;
        return;
    }
    if (player.inv) player.inv--;
    updateShip(joy);
    updateShots(joy, frame);
    prevJoy = joy;
    lastJoy = joy;
}

void PLAYER_draw(void)
{
    // clignotement tant que l'invincibilité court : 4 frames visible, 4 frames caché
    const bool blink = player.inv && ((player.inv >> 2) & 1);
    const s16 t = phaseTimer;

    SPR_setVisibility(sDead0, HIDDEN); SPR_setVisibility(sDead, HIDDEN);
    if (player.phase == 1)
    {
        const bool falling = t > DEATH_EXPLODE;
        // le vaisseau reste 2 frames, disparaît dans l'explosion, puis retombe en tournoyant (corps seul)
        SPR_setVisibility(sArmL, (t <= 2) ? VISIBLE : HIDDEN); SPR_setVisibility(sArmR, (t <= 2) ? VISIBLE : HIDDEN);
        SPR_setVisibility(sBody, ((t <= 2) || falling) ? VISIBLE : HIDDEN);
        if (falling)
        {
            SPR_setFrame(sBody, 1); SPR_setHFlip(sBody, (t >> 2) & 1);
            place(sBody, player.x - 8, player.y - 14);
        }
        if ((t > 2) && (t <= 9)) { SPR_setVisibility(sDead0, VISIBLE); place(sDead0, deathX - 8, deathY - 8); }
        else if ((t > 9) && (t <= 33)) { SPR_setVisibility(sDead, VISIBLE); SPR_setFrame(sDead, (t - 10) >> 3); place(sDead, deathX - 16, deathY - 16); }
    }
    else
    {
        SPR_setVisibility(sBody, blink ? HIDDEN : VISIBLE); SPR_setVisibility(sArmL, blink ? HIDDEN : VISIBLE); SPR_setVisibility(sArmR, blink ? HIDDEN : VISIBLE);
        drawShip(lastJoy);
    }
    drawShots(lastFrame);
}
