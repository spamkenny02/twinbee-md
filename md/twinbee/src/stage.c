#include "stage.h"
#include "player.h"
#include "enemy.h"
#include "resources.h"
#include "stage1_pal.h"
#include "stage1_data.h"
#include "stage2_data.h"
#include "stage3_data.h"
#include "stage4_data.h"
#include "stage5_data.h"
#include "stage6_data.h"
#include "boss2.h"

StageState stage;
u8 stageNo = 1;                         // 1 ou 2 : stage en cours (choisi avant STAGE_init)

// données du stage en cours
static const PalEvent* palEv;
static u16 palEvN, mapH, scrollFrames, cloudN;
static const u8* scrollTab;
static const CloudSpawn* cloudTab;
static u16 backdropCol;
static bool boss2On;

static Map* bg;
static u16 palEventPos;
static u16 clearInd;                // première tuile VRAM libre (décor de remplacement après la mort du boss)
static u16 hudBase;                 // première tuile VRAM des tuiles du HUD (chiffres, jauge)
static u16 nextCloud;
static s32 cloudFy[MAX_CLOUDS], bellFy[MAX_BELLS];      // positions verticales 8.8
static s16 cloudSpeed[MAX_CLOUDS], cloudAge[MAX_CLOUDS];
static s16 bellV[MAX_BELLS], bellAge[MAX_BELLS];
static u8 bellCol[MAX_BELLS];           // couleur de la cloche (octet $35EC de l'objet) : 0 jaune, 1 bleue, 2 noire, 3 blanche, 4 verte, 5 rouge, 6 violette
static u8 bellCnt;                      // compteur global ($C4) : avance à chaque apparition et à chaque tir reçu par une cloche
// table de la routine $17:$AB96 : une cloche colorée tous les 5 tirs, dans l'ordre noire, blanche, bleue, verte, rouge, violette
static const u8 bellTab[30] = { 2,0,0,0,0, 3,0,0,0,0, 1,0,0,0,0, 4,0,0,0,0, 5,0,0,0,0, 6,0,0,0,0 };

// nouvelle couleur de cloche ; une couleur dont le bonus est déjà acquis redevient jaune (règles lues en $17:$ABC2-$AC2E, un seul joueur)
static u8 bellRoll(void)
{
    u8 v;
    const s16 f = player.flags;
    if (++bellCnt >= 30) bellCnt = 0;
    v = bellTab[bellCnt];
    if ((v == 3) && (f & PW_TWIN)) v = 0;
    else if ((v == 4) && (f & PW_OPT1)) v = 0;
    else if ((v == 5) && (f & (PW_BARRIER | PW_OPT2))) v = 0;
    else if ((v == 6) && (f & (PW_OPT2 | PW_BARRIER))) v = 0;
    return v;
}
static s16 popOn[MAX_POPUPS], popX[MAX_POPUPS], popY[MAX_POPUPS];
static s16 impTimer[2], impX[2], impY[2];
static u32 shownScore;
static s16 prevShot[2][3], prevCharged[3];   // tirs à la frame précédente : actif/niveau, x, y
s16 stageClearTimer;
bool debugInvincible;                   // bouton A tenu : pas de contact ennemi/joueur (sert aux comparaisons)
static s16 shownLives;
static s16 prevPlayerY;
static s16 prevPlayerX;                 // x du joueur à la frame précédente (= x de l'objet joueur vu par les ennemis)
static s16 shownCharge;

static Sprite *sCloud[MAX_CLOUDS], *sBell[MAX_BELLS], *sPop[MAX_POPUPS], *sImp[2];

static s16 camY(void) { return (mapH - PLAYFIELD_H) - stage.scroll; }

static void applyPaletteEvents(s16 row)
{
    while ((palEventPos < palEvN) && ((s16) palEv[palEventPos].row >= row))
    {
        PAL_setColor(palEv[palEventPos].index, palEv[palEventPos].color);
        palEventPos++;
    }
}

static Sprite* add(const SpriteDefinition* def, u16 pal, u16 depth)
{
    Sprite* s = SPR_addSprite(def, 0, -64, TILE_ATTR(pal, FALSE, FALSE, FALSE));
    SPR_setDepth(s, depth);
    SPR_setVisibility(s, HIDDEN);
    return s;
}

// ---------------------------------------------------------------- HUD
static void hudTile(u16 tile, u16 x, u16 y)
{
    VDP_setTileMapXY(WINDOW, TILE_ATTR_FULL(PAL3, TRUE, FALSE, FALSE, hudBase + tile), x, y);
}

static void hudDrawScore(void)
{
    u32 v = stage.score;
    s16 x;
    // score cadré à droite, dernier chiffre en colonne 13 de la 2e ligne du HUD
    for (x = 13; x >= 7; x--)
    {
        if ((v == 0) && (x != 13)) hudTile(HUD_TILE_BLANK, x, PLAYFIELD_H / 8 + 1);
        else hudTile(hud_digit_tiles[v % 10], x, PLAYFIELD_H / 8 + 1);
        v /= 10;
    }
    shownScore = stage.score;
}

static void hudDrawGauge(void)
{
    // jauge de 40 px (5 tuiles, colonnes 9 à 13) : largeur remplie = charge arrondie au pair ; blanche à 40
    const s16 w = player.charge & ~1;
    s16 i;
    for (i = 0; i < 5; i++)
    {
        s16 f = w - 8 * i;
        if (f < 0) f = 0;
        if (f > 8) f = 8;
        hudTile(hud_gauge_tiles[i][(player.charge >= CHARGE_MAX) ? 5 : (f >> 1)], 9 + i, PLAYFIELD_H / 8);
    }
    shownCharge = player.charge;
}

// ---------------------------------------------------------------- init
void STAGE_init(void)
{
    u16 ind = TILE_USER_INDEX;
    s16 i;

    VDP_clearPlane(BG_A, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_setBackgroundColor(0);

    // décor sur le plan B (palettes 0 et 1, glissantes)
    {
        const TileSet* ts = (stageNo == 6) ? &stage6_tileset : (stageNo == 5) ? &stage5_tileset : (stageNo == 4) ? &stage4_tileset : (stageNo == 3) ? &stage3_tileset : (stageNo == 2) ? &stage2_tileset : &stage1_tileset;
        const MapDefinition* md = (stageNo == 6) ? &stage6_map : (stageNo == 5) ? &stage5_map : (stageNo == 4) ? &stage4_map : (stageNo == 3) ? &stage3_map : (stageNo == 2) ? &stage2_map : &stage1_map;
        if (stageNo == 6)
        {
            palEv = stage6_pal_events; palEvN = STAGE6_NUM_PAL_EVENTS; mapH = STAGE6_MAP_H; scrollTab = stage6_scroll; scrollFrames = STAGE6_SCROLL_FRAMES;
            cloudTab = stage6_clouds; cloudN = STAGE6_NUM_CLOUDS; backdropCol = STAGE6_BACKDROP;
        }
        else if (stageNo == 5)
        {
            palEv = stage5_pal_events; palEvN = STAGE5_NUM_PAL_EVENTS; mapH = STAGE5_MAP_H; scrollTab = stage5_scroll; scrollFrames = STAGE5_SCROLL_FRAMES;
            cloudTab = stage5_clouds; cloudN = STAGE5_NUM_CLOUDS; backdropCol = STAGE5_BACKDROP;
        }
        else if (stageNo == 4)
        {
            palEv = stage4_pal_events; palEvN = STAGE4_NUM_PAL_EVENTS; mapH = STAGE4_MAP_H; scrollTab = stage4_scroll; scrollFrames = STAGE4_SCROLL_FRAMES;
            cloudTab = stage4_clouds; cloudN = STAGE4_NUM_CLOUDS; backdropCol = STAGE4_BACKDROP;
        }
        else if (stageNo == 3)
        {
            palEv = stage3_pal_events; palEvN = STAGE3_NUM_PAL_EVENTS; mapH = STAGE3_MAP_H; scrollTab = stage3_scroll; scrollFrames = STAGE3_SCROLL_FRAMES;
            cloudTab = stage3_clouds; cloudN = STAGE3_NUM_CLOUDS; backdropCol = STAGE3_BACKDROP;
        }
        else if (stageNo == 2)
        {
            palEv = stage2_pal_events; palEvN = STAGE2_NUM_PAL_EVENTS; mapH = STAGE2_MAP_H; scrollTab = stage2_scroll; scrollFrames = STAGE2_SCROLL_FRAMES;
            cloudTab = stage2_clouds; cloudN = STAGE2_NUM_CLOUDS; backdropCol = STAGE2_BACKDROP;
        }
        else
        {
            palEv = stage1_pal_events; palEvN = STAGE1_NUM_PAL_EVENTS; mapH = STAGE1_MAP_H; scrollTab = stage1_scroll; scrollFrames = STAGE1_SCROLL_FRAMES;
            cloudTab = stage1_clouds; cloudN = STAGE1_NUM_CLOUDS; backdropCol = STAGE1_BACKDROP;
        }
        VDP_loadTileSet(ts, ind, DMA);
        if (bg) MAP_release(bg);
        bg = MAP_create(md, BG_B, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, ind));
        ind += ts->numTile;
    }

    // HUD sur le plan fenêtre (2 lignes du bas), palette 3
    VDP_setWindowVPos(TRUE, PLAYFIELD_H / 8);
    VDP_drawImageEx(WINDOW, &hud_image, TILE_ATTR_FULL(PAL3, TRUE, FALSE, FALSE, ind), 0, PLAYFIELD_H / 8, FALSE, TRUE);
    ind += hud_image.tileset->numTile;
    hudBase = ind;
    VDP_loadTileSet(&hud_tiles, ind, DMA);
    ind += hud_tiles.numTile;
    clearInd = ind;
   

    // palette 2 : vaisseau, cloches, flammes ; palette 3 : HUD, nuages, tir normal
    PAL_setColors(32, spr_body.palette->data, 16, CPU);
    PAL_setColors(48, hud_image.palette->data, 16, CPU);

    for (i = 0; i < MAX_CLOUDS; i++) sCloud[i] = add(&spr_cloud, PAL3, 6);
    for (i = 0; i < MAX_BELLS; i++) sBell[i] = add(&spr_bell, PAL2, 4);
    for (i = 0; i < MAX_POPUPS; i++) sPop[i] = add(&spr_pop500, PAL2, 3);
    sImp[0] = add(&spr_imp, PAL3, 3);
    sImp[1] = add(&spr_imp, PAL3, 3);
    ENEMY_init();

    stageClearTimer = 0;
    memset(&stage, 0, sizeof(stage));
#ifdef TEST_SKIP
    stage.frame = (stageNo == 2) ? (BOSS2_START) : (scrollFrames - 50);
#endif
    memset(popOn, 0, sizeof(popOn));
    nextCloud = 0;
#ifndef DBG_BELLCNT
#define DBG_BELLCNT 0
#endif
    bellCnt = DBG_BELLCNT;
    prevPlayerX = PLAYER_START_X; prevPlayerY = PLAYER_START_Y;
    shownLives = START_LIVES;
    memset(prevShot, 0, sizeof(prevShot)); memset(prevCharged, 0, sizeof(prevCharged));
    impTimer[0] = impTimer[1] = 0;
    palEventPos = 0; boss2On = FALSE;
    applyPaletteEvents((camY() >> 3) - 2);
    MAP_scrollToEx(bg, 0, camY(), TRUE);
    hudDrawScore();
    hudDrawGauge();
    PAL_setColor(0, backdropCol);
}

// ---------------------------------------------------------------- logique
static void spawnBell(s16 x, s16 y)
{
    s16 i;
    for (i = 0; i < MAX_BELLS; i++)
    {
        if (stage.bellOn[i]) continue;
        stage.bellOn[i] = TRUE; stage.bellX[i] = x; stage.bellY[i] = y;
        bellFy[i] = (s32) y << 8; bellV[i] = BELL_V0; bellAge[i] = 0; bellCol[i] = bellRoll();
        return;
    }
}

static void spawnPopup(s16 x, s16 y)
{
    s16 i;
    for (i = 0; i < MAX_POPUPS; i++)
    {
        if (popOn[i]) continue;
        popOn[i] = POPUP_FRAMES; popX[i] = x; popY[i] = y;
        return;
    }
}

// un tir normal détruit le premier ennemi qu'il touche (100 points)
static void shotVsEnemies(s16* active, s16 sx, s16 sy, s16 n)
{
    if (!*active) return;
    {
        const bool tw = n ? player.shot2Tw : player.shotTw;
        enemyShotHW = tw ? 12 : 8; enemyShotHH = tw ? 12 : 16;
    }
    if (!ENEMY_hitByShot(sx, sy)) return;
    *active = FALSE;
    impTimer[n] = 2; impX[n] = sx; impY[n] = sy;
    stage.score += ENEMY_SCORE;
}

// Collisions d'un tir normal avec les nuages et les cloches.
// Comme dans l'original, chaque cible n'est testée qu'une frame sur deux, selon la parité de son numéro d'objet :
// nuages = objets 90 et suivants, cloches = objets 89 en descendant.
#define CLOUD_OBJ_INDEX 90
#define BELL_OBJ_INDEX  89
static void shotCollisions(s16* active, s16 sx, s16 sy, s16 n)
{
    const bool isNew = !prevShot[n][0];     // à sa frame d'apparition, le tir teste tous les nuages
    s16 i, j;

    if (!*active) return;
    for (i = 0; i < MAX_CLOUDS; i++)
    {
        const s16 dx = sx - stage.cloudX[i];
        const s16 dy = sy - stage.cloudY[i];
        if (!stage.cloudOn[i] || !stage.cloudBell[i]) continue;
        if (!isNew && !((stage.frame + CLOUD_OBJ_INDEX + i) & 1)) continue;
        if ((dx >= 0) && (dx <= 18) && (dy >= -16) && (dy <= 30))
        {
            stage.cloudBell[i] = FALSE;
            spawnBell(stage.cloudX[i] + 8, stage.cloudY[i] + 6);
        }
    }
    for (j = 0; j < MAX_BELLS; j++)
    {
        const s16 dx = sx - stage.bellX[j];
        const s16 dy = sy - stage.bellY[j];
        if (!stage.bellOn[j] || !bellAge[j]) continue;
        if (!((stage.frame + BELL_OBJ_INDEX - j) & 1)) continue;
        if (stage.bellY[j] < 0) continue;           // cloche sortie par le haut : pas touchée (observé à y = -12)
        // zone en losange : |dx| + dy <= 24 (mesuré : dx=0 touche à dy=23, pas à 25 ; dx=8 ne touche pas à dy=22)
        if ((dx >= -14) && (dx <= 14) && (dy >= -8) && ((abs(dx) + dy) <= 24))
        {
            if (bellV[j] > BELL_V_NOHIT) { bellV[j] = BELL_V_HIT; bellCol[j] = bellRoll(); }     // la cloche repart vers le haut ; nouvelle couleur
            *active = FALSE;                        // le tir est consommé
            impTimer[n] = 2; impX[n] = sx; impY[n] = sy;
            break;
        }
    }
}

void STAGE_update(void)
{
    s16 i, delta = 0;

    // --- défilement : déplacement de la frame lu dans la table (4 bits par frame)
    if (stage.frame < scrollFrames)
    {
        const u8 b = scrollTab[stage.frame >> 1];
        delta = (stage.frame & 1) ? (b >> 4) : (b & 15);
        stage.scroll += delta;
    }

    // --- cloches déjà présentes : ramassage par le joueur, puis déplacement
    for (i = 0; i < MAX_BELLS; i++)
    {
        s16 dx, dy;
        if (!stage.bellOn[i]) continue;
        dx = stage.bellX[i] + 8 - player.x;
        dy = stage.bellY[i] + 8 - player.y;
        if ((player.phase != 1) && (dx >= -13) && (dx <= 13) && (dy >= -13) && (dy <= 13))
        {
            stage.bellOn[i] = FALSE;
            stage.score += BELL_SCORE;
            switch (bellCol[i])     // effets lus en $17:$AFE2 et suivants
            {
                case 1: if (player.speedLvl < 0x12) player.speedLvl += 2; break;
                case 2: if (player.speedLvl > 0) player.speedLvl -= 2; break;
                case 3: player.flags = (player.flags & ~0x08) | PW_TWIN; break;
                case 4: player.flags |= PW_OPT1; break;
                case 5: player.flags |= PW_BARRIER; break;
                case 6: player.flags |= PW_OPT2; break;
            }
            spawnPopup(stage.bellX[i] - 8, stage.bellY[i] - 2);
            continue;
        }
        bellFy[i] += bellV[i];
        bellV[i] += BELL_GRAVITY;
        if (bellV[i] > BELL_VMAX) bellV[i] = BELL_VMAX;
        stage.bellY[i] = bellFy[i] >> 8;
        bellAge[i]++;
        if (stage.bellY[i] >= BELL_EXIT_Y) stage.bellOn[i] = FALSE;
    }

    // --- pastilles de score : elles suivent le sol
    for (i = 0; i < MAX_POPUPS; i++)
    {
        if (!popOn[i]) continue;
        popY[i] += delta;
        popOn[i]--;
    }

    // --- nuages : déplacement, apparition selon la table du stage
    for (i = 0; i < MAX_CLOUDS; i++)
    {
        if (!stage.cloudOn[i]) continue;
        cloudFy[i] += cloudSpeed[i];
        stage.cloudY[i] = cloudFy[i] >> 8;
        cloudAge[i]++;
        if (stage.cloudY[i] >= CLOUD_EXIT_Y) stage.cloudOn[i] = FALSE;
    }
    while ((nextCloud < cloudN) && (cloudTab[nextCloud].frame <= stage.frame))
    {
        const CloudSpawn* c = &cloudTab[nextCloud++];
        for (i = 0; i < MAX_CLOUDS; i++)
        {
            if (stage.cloudOn[i]) continue;
            stage.cloudOn[i] = TRUE; stage.cloudBell[i] = TRUE;
            stage.cloudX[i] = c->x;
            cloudFy[i] = ((s32) c->y << 8) + ((c->frame >= 0) ? c->speed : 0);     // frame -1 : nuage déjà présent au début
            stage.cloudY[i] = cloudFy[i] >> 8;
            cloudSpeed[i] = c->speed; cloudAge[i] = 0;
            break;
        }
    }

    // --- ennemis : collisions avec les positions de la frame précédente (comme l'original, qui teste avant
    //     de déplacer : l'ennemi touché reste figé), puis déplacement
    if (prevShot[0][0]) shotVsEnemies(&player.shotActive, prevShot[0][1], prevShot[0][2], 0);
    if (prevShot[1][0]) shotVsEnemies(&player.shot2Active, prevShot[1][1], prevShot[1][2], 1);
    if (prevCharged[0] == 1) stage.score += ENEMY_SCORE * ENEMY_hitByCharged(prevCharged[1], prevCharged[2] + 16, 15, 20);
    else if (prevCharged[0] == 2) stage.score += ENEMY_SCORE * ENEMY_hitByCharged(prevCharged[1], prevCharged[2] + 48, 27, 52);
    {
        u16 bonus;
        // l'objet joueur vu par les ennemis a une frame de retard sur la position commandée
        {
            static u16 prevBombJoy;
            const u16 j = JOY_readJoypad(JOY_1);
            if ((j & BUTTON_C) && !(prevBombJoy & BUTTON_C)) ENEMY_bombPress(prevPlayerX, prevPlayerY);
            prevBombJoy = j;
        }
        ENEMY_update(stage.frame, prevPlayerX, prevPlayerY, delta, &bonus, !debugInvincible);
        stage.score += bonus;
        if (enemies.bossDead && !stageClearTimer) { stage.score += 10000; stageClearTimer = 1; }
    }
    prevPlayerX = player.x; prevPlayerY = player.y;

    // --- tirs normaux : libèrent la cloche des nuages traversés, puis rebondissent sur une cloche
    shotCollisions(&player.shotActive, player.shotX, player.shotY, 0);
    shotCollisions(&player.shot2Active, player.shot2X, player.shot2Y, 1);

    prevShot[0][0] = player.shotActive; prevShot[0][1] = player.shotX; prevShot[0][2] = player.shotY;
    prevShot[1][0] = player.shot2Active; prevShot[1][1] = player.shot2X; prevShot[1][2] = player.shot2Y;
    prevCharged[0] = player.chargedLevel; prevCharged[1] = player.chargedX; prevCharged[2] = player.chargedY;
    if ((stageNo == 2) && (stage.frame >= BOSS2_START) && !boss2On) { BOSS2_start(); boss2On = TRUE; }
    if ((stageNo == 2) && (stage.frame == BOSS2_START + BOSS2_FRAMES) && (stageClearTimer == 0)) stageClearTimer = 1;
    else if ((stageNo >= 3) && (stage.frame == scrollFrames + 300) && (stageClearTimer == 0)) stageClearTimer = 1;     // provisoire : pas encore de boss
    stage.frame++;
}

// mort du boss : remplace le corps du crabe (décor) par un fond vide avec piliers (image extraite de la carte sous le crabe)
void STAGE_eraseBoss(void)
{
    const u16 ind = clearInd;
    VDP_loadTileSet(boss_clear.tileset, ind, DMA);
    VDP_setTileMapEx(BG_B, boss_clear.tilemap, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, ind), 0, (camY() >> 3) & 31, 0, 0, 32, 15, DMA);
}

// libère les sprites de nuages (VRAM réutilisée par le boss)
static u8 cloudsFreed;
void STAGE_releaseClouds(void)
{
    s16 i;
    for (i = 0; i < MAX_CLOUDS; i++) { SPR_releaseSprite(sCloud[i]); stage.cloudOn[i] = 0; }
    cloudsFreed = 1;
}

// ---------------------------------------------------------------- affichage
void STAGE_draw(void)
{
    s16 i;
    if (cloudsFreed) goto bells;

    for (i = 0; i < MAX_CLOUDS; i++)
    {
        SPR_setVisibility(sCloud[i], stage.cloudOn[i] ? VISIBLE : HIDDEN);
        if (!stage.cloudOn[i]) continue;
        SPR_setFrame(sCloud[i], (cloudAge[i] >> 4) & 1);
        SPR_setPosition(sCloud[i], stage.cloudX[i] + PF_XOFF, stage.cloudY[i]);
    }
bells:
    for (i = 0; i < MAX_BELLS; i++)
    {
        SPR_setVisibility(sBell[i], stage.bellOn[i] ? VISIBLE : HIDDEN);
        if (!stage.bellOn[i]) continue;
        SPR_setFrame(sBell[i], bellCol[i] * 2 + ((bellAge[i] >> 3) & 1));
        SPR_setPosition(sBell[i], stage.bellX[i] + PF_XOFF, stage.bellY[i]);
    }
    for (i = 0; i < MAX_POPUPS; i++)
    {
        SPR_setVisibility(sPop[i], popOn[i] ? VISIBLE : HIDDEN);
        if (popOn[i]) SPR_setPosition(sPop[i], popX[i] + PF_XOFF, popY[i]);
    }
    for (i = 0; i < 2; i++)
    {
        SPR_setVisibility(sImp[i], impTimer[i] ? VISIBLE : HIDDEN);
        if (!impTimer[i]) continue;
        SPR_setFrame(sImp[i], 2 - impTimer[i]);
        SPR_setPosition(sImp[i], impX[i] + PF_XOFF, impY[i]);
        impTimer[i]--;
    }

    ENEMY_draw();
    if (stage.score != shownScore) hudDrawScore();
    if (player.lives != shownLives)
    {
        shownLives = player.lives;
        hudTile(hud_digit_tiles[(shownLives > 0) ? shownLives : 0], 7, PLAYFIELD_H / 8);
    }
    if (player.charge != shownCharge) hudDrawGauge();
    if (boss2On) BOSS2_update(stage.frame - BOSS2_START); else MAP_scrollTo(bg, 0, camY());
}

void STAGE_afterVBlank(void)
{
    if (boss2On) return;
    applyPaletteEvents((camY() >> 3) - 2);
}
