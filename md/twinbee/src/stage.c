#include "stage.h"
#include "player.h"
#include "enemy.h"
#include "mus.h"
#include "resources.h"
#include "boss_rock.h"
#include "bossn.h"
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
static u16 rockInd;
static s16 rockRow;                 // plus petite rangée monde déjà écrite
static u8 rockOn;
static void rockUpdate(s16 rockT);
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
    const s16 f = players[0].flags | (players[1].active ? players[1].flags : 0);
    if (++bellCnt >= 30) bellCnt = 0;
    v = bellTab[bellCnt];
    if ((v == 3) && (f & PW_TWIN)) v = 0;
    else if ((v == 4) && (f & PW_OPT1)) v = 0;
    else if ((v == 5) && (f & (PW_BARRIER | PW_OPT2))) v = 0;
    else if ((v == 6) && (f & (PW_OPT2 | PW_BARRIER))) v = 0;
    return v;
}
static s16 popOn[MAX_POPUPS], popX[MAX_POPUPS], popY[MAX_POPUPS];
static s16 impTimer[4], impX[4], impY[4];
static u32 shownScore[2];
static s16 prevShot[2][2][3], prevCharged[2][3];   // tirs à la frame précédente : actif/niveau, x, y
s16 stageClearTimer;
bool debugInvincible;                   // bouton A tenu : pas de contact ennemi/joueur (sert aux comparaisons)
bool demoHud;                           // HUD de la demo d'attract
static s16 shownLives, shownLives2;
static s16 prevPlayerY[2];
static s16 prevPlayerX[2];                 // x du joueur à la frame précédente (= x de l'objet joueur vu par les ennemis)
static s16 shownCharge[2];

static Sprite *sCloud[MAX_CLOUDS], *sBell[MAX_BELLS], *sPop[MAX_POPUPS], *sImp[4];

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

static void hudDrawScore(s16 n)
{
    u32 v = n ? stage.score2 : stage.score;
    const s16 o = n ? 15 : 0;
    s16 x;
    // score cadré à droite, dernier chiffre en colonne 13 de la 2e ligne du HUD (28 pour le joueur 2, décalé de 15 colonnes)
    for (x = 13; x >= 7; x--)
    {
        if ((v == 0) && (x != 13)) hudTile(HUD_TILE_BLANK, x + o, PLAYFIELD_H / 8 + 1);
        else hudTile(hud_digit_tiles[v % 10], x + o, PLAYFIELD_H / 8 + 1);
        v /= 10;
    }
    shownScore[n] = n ? stage.score2 : stage.score;
}

static void hudDrawGauge(s16 n)
{
    // jauge de 40 px (5 tuiles, colonnes 9 à 13) : largeur remplie = charge arrondie au pair ; blanche à 40
    const s16 ch = players[n].charge;
    const s16 w = ch & ~1;
    const s16 o = n ? 15 : 0;
    s16 i;
    for (i = 0; i < 5; i++)
    {
        s16 f = w - 8 * i;
        if (f < 0) f = 0;
        if (f > 8) f = 8;
        hudTile(hud_gauge_tiles[i][(ch >= CHARGE_MAX) ? 5 : (f >> 1)], 9 + i + o, PLAYFIELD_H / 8);
    }
    shownCharge[n] = ch;
}

// le joueur 2 entre : « 2P PRESS RUN » est remplacé par « 2P ♥ n » avec jauge et score propres
void STAGE_join(void)
{
    VDP_drawImageEx(WINDOW, &hud2_image, TILE_ATTR_FULL(PAL3, TRUE, FALSE, FALSE, clearInd), 16, PLAYFIELD_H / 8, FALSE, TRUE);
    clearInd += hud2_image.tileset->numTile;
    shownLives2 = -1;
    hudDrawScore(1); hudDrawGauge(1);
}

// ---------------------------------------------------------------- init
// Remplace la table de defilement du stage par celle relevee sur la demo d'attract PCE.
void STAGE_setDemoScroll(const u8* tab, u16 frames)
{
    scrollTab = tab;
    scrollFrames = frames;
}

// Fin de demo d'attract : la carte du decor n'est plus affichee. La liberer rend au tas les
// ~12-17 Ko qu'elle occupe, sinon le tileset du logo du titre (316 tuiles) ne peut plus etre
// decompresse et l'ecran suivant se corrompt.
void STAGE_releaseMap(void)
{
    if (bg) { MAP_release(bg); bg = NULL; }
}

void STAGE_init(void)
{
    MUS_stop();
    u16 ind = TILE_USER_INDEX;
    s16 i;

    VDP_clearPlane(BG_A, TRUE); rockOn = 0; VDP_setVerticalScroll(BG_A, 0);
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
        // liberer l'ancienne carte AVANT de decompresser le nouveau decor : sinon le tampon
        // temporaire du tileset (23 Ko) ne tient plus dans le tas avec l'ancienne carte
        if (bg) { MAP_release(bg); bg = NULL; }
        VDP_loadTileSet(ts, ind, DMA);
        bg = MAP_create(md, BG_B, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, ind));
        ind += ts->numTile;
    }

    // HUD sur le plan fenêtre (2 lignes du bas), palette 3
    {
        const Image* hi = demoHud ? &hud_demo : &hud_image;
        VDP_setWindowVPos(TRUE, PLAYFIELD_H / 8);
        VDP_drawImageEx(WINDOW, hi, TILE_ATTR_FULL(PAL3, TRUE, FALSE, FALSE, ind), 0, PLAYFIELD_H / 8, FALSE, TRUE);
        ind += hi->tileset->numTile;
    }
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
    sImp[2] = add(&spr_imp, PAL3, 3);
    sImp[3] = add(&spr_imp, PAL3, 3);
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
    prevPlayerX[0] = PLAYER_START_X; prevPlayerY[0] = PLAYER_START_Y; prevPlayerX[1] = PLAYER_START_X2; prevPlayerY[1] = RESPAWN_Y;
    shownLives = START_LIVES; shownLives2 = -1;
    memset(prevShot, 0, sizeof(prevShot)); memset(prevCharged, 0, sizeof(prevCharged));
    memset(impTimer, 0, sizeof(impTimer));
    palEventPos = 0; boss2On = FALSE;
    applyPaletteEvents((camY() >> 3) - 2);
    MAP_scrollToEx(bg, 0, camY(), TRUE);
    hudDrawScore(0);
    hudDrawGauge(0);
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
static void addScore(s16 pn, u32 v) { if (pn) stage.score2 += v; else stage.score += v; }

static void shotVsEnemies(s16 pn, s16* active, s16 sx, s16 sy, s16 n)
{
    if (!*active) return;
    {
        const bool tw = n ? players[pn].shot2Tw : players[pn].shotTw;
        enemyShotHW = tw ? 12 : 8; enemyShotHH = tw ? 12 : 16;
    }
    if (!ENEMY_hitByShot(sx, sy)) return;
    *active = FALSE;
    impTimer[pn * 2 + n] = 2; impX[pn * 2 + n] = sx; impY[pn * 2 + n] = sy;
    addScore(pn, ENEMY_SCORE);
}

// Collisions d'un tir normal avec les nuages et les cloches.
// Comme dans l'original, chaque cible n'est testée qu'une frame sur deux, selon la parité de son numéro d'objet :
// nuages = objets 90 et suivants, cloches = objets 89 en descendant.
#define CLOUD_OBJ_INDEX 90
#define BELL_OBJ_INDEX  89
static void shotCollisions(s16 pn, s16* active, s16 sx, s16 sy, s16 n)
{
    const bool isNew = !prevShot[pn][n][0];     // à sa frame d'apparition, le tir teste tous les nuages
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
            if (bellV[j] > BELL_V_NOHIT) { bellV[j] = BELL_V_HIT; bellCol[j] = bellRoll(); SFX_play(SFX_BELLHIT); }     // la cloche repart vers le haut ; nouvelle couleur
            *active = FALSE;                        // le tir est consommé
            impTimer[pn * 2 + n] = 2; impX[pn * 2 + n] = sx; impY[pn * 2 + n] = sy;
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
        s16 dx, dy, pn;
        if (!stage.bellOn[i]) continue;
        for (pn = 0; pn < 2; pn++)
        {
            PlayerState* pl = &players[pn];
            if (!pl->active || (pl->phase == 1) || (pl->phase == 3)) continue;
            dx = stage.bellX[i] + 8 - pl->x;
            dy = stage.bellY[i] + 8 - pl->y;
            if ((dx >= -13) && (dx <= 13) && (dy >= -13) && (dy <= 13)) break;
        }
        if (pn < 2)
        {
            PlayerState* pl = &players[pn];
            stage.bellOn[i] = FALSE;
            addScore(pn, BELL_SCORE);
            SFX_play(SFX_BELLGET);
            switch (bellCol[i])     // effets lus en $17:$AFE2 et suivants
            {
                case 1: if (pl->speedLvl < 0x12) pl->speedLvl += 2; break;
                case 2: if (pl->speedLvl > 0) pl->speedLvl -= 2; break;
                case 3: pl->flags = (pl->flags & ~0x08) | PW_TWIN; break;
                case 4: pl->flags |= PW_OPT1; break;
                case 5: pl->flags |= PW_BARRIER; pl->barrier = 10; SFX_play(SFX_POWER); break;
                case 6: pl->flags |= PW_OPT2; break;
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
    {
        s16 pn;
        for (pn = 0; pn < 2; pn++)
        {
            PlayerState* pl = &players[pn];
            if (!pl->active) continue;
            if (prevShot[pn][0][0]) shotVsEnemies(pn, &pl->shotActive, prevShot[pn][0][1], prevShot[pn][0][2], 0);
            if (prevShot[pn][1][0]) shotVsEnemies(pn, &pl->shot2Active, prevShot[pn][1][1], prevShot[pn][1][2], 1);
            {
                s16 k;
                enemyShotHW = 8; enemyShotHH = 16;
                for (k = 0; k < 2; k++)
                    if (pl->sideOn[k] && ENEMY_hitByShot(pl->sideX[k], pl->sideY[k])) { pl->sideOn[k] = FALSE; addScore(pn, ENEMY_SCORE); }
            }
            if (prevCharged[pn][0] == 1) addScore(pn, ENEMY_SCORE * ENEMY_hitByCharged(prevCharged[pn][1], prevCharged[pn][2] + 16, 15, 20));
            else if (prevCharged[pn][0] == 2) addScore(pn, ENEMY_SCORE * ENEMY_hitByCharged(prevCharged[pn][1], prevCharged[pn][2] + 48, 27, 52));
        }
    }
    {
        u16 bonus;
        s16 pn;
        // l'objet joueur vu par les ennemis a une frame de retard sur la position commandée
        for (pn = 0; pn < 2; pn++)
        {
            static u16 prevBombJoy[2];
            const u16 j = demoHud ? 0 : JOY_readJoypad(pn ? JOY_2 : JOY_1);
            if (players[pn].active && (players[pn].phase != 3) && (j & BUTTON_C) && !(prevBombJoy[pn] & BUTTON_C)) ENEMY_bombPress(prevPlayerX[pn], prevPlayerY[pn], pn);
            prevBombJoy[pn] = j;
            enemyPlayer[pn].x = prevPlayerX[pn]; enemyPlayer[pn].y = prevPlayerY[pn]; enemyPlayer[pn].on = players[pn].active && (players[pn].phase != 3);
        }
        enemyBonus2 = 0;
        ENEMY_update(stage.frame, prevPlayerX[0], prevPlayerY[0], delta, &bonus, !debugInvincible);
        stage.score += bonus;
        stage.score2 += enemyBonus2;
        if (enemies.bossDead && !stageClearTimer) { stage.score += 10000; stageClearTimer = 1; }
    }
    prevPlayerX[0] = players[0].x; prevPlayerY[0] = players[0].y;
    prevPlayerX[1] = players[1].x; prevPlayerY[1] = players[1].y;

    // --- tirs normaux : libèrent la cloche des nuages traversés, puis rebondissent sur une cloche
    {
        s16 pn;
        for (pn = 0; pn < 2; pn++)
        {
            PlayerState* pl = &players[pn];
            if (!pl->active) continue;
            shotCollisions(pn, &pl->shotActive, pl->shotX, pl->shotY, 0);
            shotCollisions(pn, &pl->shot2Active, pl->shot2X, pl->shot2Y, 1);
            prevShot[pn][0][0] = pl->shotActive; prevShot[pn][0][1] = pl->shotX; prevShot[pn][0][2] = pl->shotY;
            prevShot[pn][1][0] = pl->shot2Active; prevShot[pn][1][1] = pl->shot2X; prevShot[pn][1][2] = pl->shot2Y;
            prevCharged[pn][0] = pl->chargedLevel; prevCharged[pn][1] = pl->chargedX; prevCharged[pn][2] = pl->chargedY;
        }
    }
    // boss 2 : la carte du stage n'est plus utilisee (le boss ecrit son propre BAT), et son
    // tileset (640 tuiles = 20,5 Ko) a besoin du tas libre : on libere la carte avant l'unpack.
    if ((stageNo == 2) && (stage.frame >= BOSS2_START) && !boss2On)
    {
        if (bg) { MAP_release(bg); bg = NULL; }
        BOSS2_start(); boss2On = TRUE;
    }
    if ((stageNo == 2) && (stage.frame == BOSS2_START + BOSS2_FRAMES) && (stageClearTimer == 0)) stageClearTimer = 1;
    else if ((stageNo >= 3) && !BOSSN_available(stageNo) && (stage.frame == scrollFrames + 300) && (stageClearTimer == 0)) stageClearTimer = 1;     // provisoire : pas encore de boss
    MUS_stageUpdate(stage.frame);
    rockUpdate(stage.frame - ROCK_START);
    stage.frame++;
}

// débris de roche des parois (stage 1, du début du défilement final au boss) : tuiles sur le plan A, défilement vertical identique à celui
// des sprites PCE (32x64, un nouveau 128 px plus haut tous les 128 px). Anneau de 32 rangées : la rangée « monde » r est écrite à la rangée r & 31.
static void rockWriteRow(s16 r)
{
    const s16 m = r & 31, t = r & 15;
    s16 c;
    for (c = 0; c < 4; c++)
    {
        VDP_setTileMapXY(BG_A, (t < 8 && r <= 7) ? TILE_ATTR_FULL(ROCK_PALETTE_LINE, FALSE, FALSE, FALSE, rockInd + t * 4 + c) : 0, 1 + c, m);
        VDP_setTileMapXY(BG_A, (t < 8 && r <= 7) ? TILE_ATTR_FULL(ROCK_PALETTE_LINE, FALSE, FALSE, TRUE, rockInd + t * 4 + (3 - c)) : 0, 27 + c, m);
    }
}

static void rockUpdate(s16 rockT)
{
    s16 y0, rtop;
    if ((stageNo != 1) || (rockT < 0)) return;
    if (!rockOn)
    {
        rockOn = 1; rockInd = TILE_SPRITE_INDEX - 32;
        VDP_loadTileSet(&boss_rock_tiles, rockInd, DMA);
        VDP_clearPlane(BG_A, TRUE);
        rockRow = 8;                // à l'origine, y0 = -64 : le monde visible commence à la rangée 8 (vide)
    }
    y0 = rock_y[(rockT < ROCK_NUM) ? rockT : (ROCK_NUM - 1)];
    rtop = (-y0 - 8) >> 3;          // rangée monde juste au-dessus du haut de l'écran
    while (rockRow > rtop) { rockRow--; rockWriteRow(rockRow); }
    VDP_setVerticalScroll(BG_A, (-y0) & 255);
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
    for (i = 0; i < 4; i++)
    {
        SPR_setVisibility(sImp[i], impTimer[i] ? VISIBLE : HIDDEN);
        if (!impTimer[i]) continue;
        SPR_setFrame(sImp[i], 2 - impTimer[i]);
        SPR_setPosition(sImp[i], impX[i] + PF_XOFF, impY[i]);
        impTimer[i]--;
    }

    ENEMY_draw();
    if (stage.score != shownScore[0]) hudDrawScore(0);
    if (player.lives != shownLives)
    {
        shownLives = player.lives;
        hudTile(hud_digit_tiles[(shownLives > 0) ? shownLives : 0], 7, PLAYFIELD_H / 8);
    }
    if (player.charge != shownCharge[0]) hudDrawGauge(0);
    if (players[1].active)
    {
        if (stage.score2 != shownScore[1]) hudDrawScore(1);
        if (players[1].lives != shownLives2)
        {
            shownLives2 = players[1].lives;
            hudTile(hud_digit_tiles[(shownLives2 > 0) ? shownLives2 : 0], 22, PLAYFIELD_H / 8);
        }
        if (players[1].charge != shownCharge[1]) hudDrawGauge(1);
    }
    if (boss2On) BOSS2_update(stage.frame - BOSS2_START); else MAP_scrollTo(bg, 0, camY());
}

void STAGE_afterVBlank(void)
{
    if (boss2On) return;
    applyPaletteEvents((camY() >> 3) - 2);
}
