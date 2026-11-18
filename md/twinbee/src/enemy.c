#include "enemy.h"
void STAGE_releaseClouds(void);
void STAGE_eraseBoss(void);
#include "player.h"
#include "stage.h"
#include "resources.h"
#include "stage1_data.h"

EnemyState enemies;

static s32 fx[MAX_ENEMIES], fy[MAX_ENEMIES];            // positions 8.8
static s16 vx[MAX_ENEMIES], vy[MAX_ENEMIES];
static s16 state[MAX_ENEMIES], angle[MAX_ENEMIES], timer[MAX_ENEMIES], arcFrames[MAX_ENEMIES];
static u8 flags[MAX_ENEMIES], group[MAX_ENEMIES];
static u8 groupKills[STAGE1_NUM_GROUPS];
static s16 spawnedG, scrollHist[4];
#ifndef GSH
#define GSH         0           // retard (en frames) du défilement suivi par les ennemis au sol
#endif
#define NUM_BOMBS   2
#define GFR         16          // images 16-19 : ennemis au sol (types 13/14), 20 : bombe (dans la feuille spr_enemy)
// bombes (bouton I de l'original) : 2 emplacements (voies gauche / droite), viseur automatique sur l'ennemi au sol le plus proche
static s16 bombHitX[NUM_BOMBS], bombHitY[NUM_BOMBS], bombOn[NUM_BOMBS], bombX[NUM_BOMBS], bombT[NUM_BOMBS], bombTarget[NUM_BOMBS], bombLandY[NUM_BOMBS], bombKillIn[NUM_BOMBS];
static s32 bombFy[NUM_BOMBS];
static const u8 gwalkTab[5] = {0x60, 0, 0x80, 1, 0};     // marcheurs (type 15) : $4FD0 = durée, marche
static s16 spawnedE;     // indice dans la table des tirs ennemis génériques
static s16 spawned, spawnedM, spawnedP, spawnedS, spawned6, spawnedB, spawned12, spawned9, spawned10, bossSpawned;
static s16 hp[MAX_ENEMIES];
static s16 ax[MAX_ENEMIES], ay[MAX_ENEMIES], cnt[MAX_ENEMIES], svx[MAX_ENEMIES], svy[MAX_ENEMIES];   // type 7 : accélérations, compteur d'état, vitesse mémorisée
#define KIND enemies.kind                               // 5 = ennemi en arc de cercle, 3 / 4 = ennemis en ligne droite
#define NOGROUP     0xFF
#ifndef SHH6
#define SHH6 0
#endif
#ifndef SHH11
#define SHH11 5
#endif
#ifndef SHH12
#define SHH12 0
#endif
#ifndef SHH8
#define SHH8 0
#endif
// demi-tailles de collision relevées en RAM ($338E / $33FB) : type 5 : 4x5, type 3 : 5x5, type 4 : 2x11
// demi-hauteur utilisée par les tirs (type 4 : 5 et non 11, mesuré sur les kills de la partie ch)
static const s16 kindSHH[16] = {0, 0, 0, 0, 0, 5, SHH6, 0, SHH8, 0, 0, SHH11, SHH12, 0, 0, 0};
static const s16 kindHW[16] = {0, 0, 0, 5, 2, 4, 5, 2, 4, 5, 9, 10, 0, 44, 0, 0}, kindHH[16] = {0, 0, 0, 5, 11, 5, 5, 5, 5, 5, 5, 5, 1, 22, 0, 0};
#define HWK(k)  (((k) >= 32) ? (s16) E2->hw[(k) - 32] : kindHW[k])
#define HHK(k)  (((k) >= 32) ? (s16) E2->hh[(k) - 32] : kindHH[k])
#define SHHK(k) (((k) >= 32) ? (s16) E2->hh[(k) - 32] : kindSHH[k])
#define MAX_MISSILE_SPR 3       // limite du nombre de sprites (80 au total) : pool partagé des ennemis de type 4 (16x32) ; les types 3, 5 et 7 (16x16) partagent sEnemy
static Sprite *sEn4[MAX_MISSILE_SPR];
// explosions : 7 frames de petite boule puis 3 images de 8 frames, entraînées par le défilement
#define MAX_EX      6           // explosions simultanées (réserve de sprites limitée par la VRAM)
static s16 exTimer[MAX_EX], exX[MAX_EX], exY[MAX_EX];
static u8 exGroup[MAX_EX];
#define MAX_SPR16   22          // sprites 16x16 partagés par les ennemis de types 3, 5 et 7 (limite de 80 sprites au total)
#define MAX_SPR10   12          // sprites 32x16 des vaisseaux de type 10
static s16 maxSpr16 = MAX_SPR16;
static Sprite *sEnemy[MAX_SPR16], *sEx[MAX_EX], *sEn10[MAX_SPR10];

#define EX_SMALL    7
#define EX_TOTAL    (EX_SMALL + 24)

#include "boss_data.h"
#include "stage2_enemies.h"
#include "stage3_enemies.h"
#include "stage4_enemies.h"
#define E2_POOL_MAX 14
static const E2Data* E2;
static Sprite* sE2[4][E2_POOL_MAX];
static u16 rIdx[MAX_ENEMIES], rT[MAX_ENEMIES], rR[MAX_ENEMIES];
static u16 rF[MAX_ENEMIES];
static u8 rL[MAX_ENEMIES];
static s16 spawn2, spawnB2;

static void e2Draw(void)
{
    s16 i, k, c, n[4] = {0, 0, 0, 0};
    for (i = 0; i < MAX_ENEMIES; i++)
    {
        const E2Frame* fr;
        if ((KIND[i] < 32) || !enemies.on[i] || (enemies.on[i] >= 3)) continue;
        fr = &E2->frames[rF[i]];
        for (k = 0; k < fr->n; k++)
        {
            const E2Piece* pc = &fr->p[k];
            Sprite* sp;
            if (n[pc->cls] >= E2->pool[pc->cls]) continue;
            sp = sE2[pc->cls][n[pc->cls]++];
            SPR_setVisibility(sp, VISIBLE); SPR_setFrame(sp, pc->img); SPR_setHFlip(sp, pc->flip);
            SPR_setPosition(sp, enemies.x[i] + pc->dx + PF_XOFF, enemies.y[i] + pc->dy);
        }
    }
    for (c = 0; c < 4; c++) for (i = n[c]; i < E2->pool[c]; i++) SPR_setVisibility(sE2[c][i], HIDDEN);
}

static Sprite *sBossL[BOSS_MAX_BIG], *sBossS[BOSS_MAX_SMALL];
static u8 bossReady;      // 1 : sprites du crabe créés ; 2 : échec
static s16 bossDeathT;    // 0 : vivant ; >0 : frames depuis la mort du boss (explosions, ~130 frames comme sur PCE)
static s16 bossT;         // frames écoulées depuis le début du boss (frame de calcul - BOSS_START_FRAME)

static void bossStart(void)
{
    s16 i;
    for (i = 0; i < MAX_SPR10; i++) SPR_releaseSprite(sEn10[i]);
    for (i = 0; i < MAX_MISSILE_SPR; i++) SPR_releaseSprite(sEn4[i]);
    STAGE_releaseClouds();
    bossReady = 1;
    for (i = 0; i < BOSS_MAX_BIG; i++)
    {
        sBossL[i] = SPR_addSprite(&spr_boss_l, 0, -64, TILE_ATTR(BOSS_PALETTE_LINE, FALSE, FALSE, FALSE));
        if (!sBossL[i]) { bossReady = 2; break; }
        SPR_setDepth(sBossL[i], 5); SPR_setVisibility(sBossL[i], HIDDEN);
    }
    for (i = 0; i < BOSS_MAX_SMALL; i++)
    {
        sBossS[i] = SPR_addSprite(&spr_boss_s, 0, -64, TILE_ATTR(BOSS_PALETTE_LINE, FALSE, FALSE, FALSE));
        if (!sBossS[i]) { bossReady = 2; break; }
        SPR_setDepth(sBossS[i], 5); SPR_setVisibility(sBossS[i], HIDDEN);
    }
    if (bossReady == 2) VDP_drawText("NULLBOSS", 0, 1);
}

static void bossDraw(void)
{
    s16 nl = 0, ns = 0, k;
    const s16 bt = (bossT >= 0) ? (bossT % BOSS_NUM_FRAMES) : 0;        // au-delà de la trace (6500 frames), la trajectoire boucle
    const u8 po = (bossT >= 0) ? boss_pose[bt] : 255;
    if (po != 255)
    {
        const BossPose* ps = &boss_poses[po];
        for (k = 0; k < ps->n; k++)
        {
            const BossPiece* pc = &ps->p[k];
            Sprite* sp;
            if (pc->small) { if (ns >= BOSS_MAX_SMALL) continue; sp = sBossS[ns++]; }
            else { if (nl >= BOSS_MAX_BIG) continue; sp = sBossL[nl++]; }
            SPR_setVisibility(sp, VISIBLE); SPR_setHFlip(sp, pc->flip); SPR_setFrame(sp, pc->frame);
            SPR_setPosition(sp, boss_ax[bt] + pc->dx + PF_XOFF, boss_ay[bt] + pc->dy);
        }
    }
    for (k = nl; k < BOSS_MAX_BIG; k++) SPR_setVisibility(sBossL[k], HIDDEN);
    for (k = ns; k < BOSS_MAX_SMALL; k++) SPR_setVisibility(sBossS[k], HIDDEN);
}

void ENEMY_init(void)
{
    bossReady = 0; bossT = -1; bossDeathT = 0;
    s16 i;
    maxSpr16 = (stageNo == 1) ? MAX_SPR16 : 8;
    for (i = 0; i < maxSpr16; i++)
    {
        sEnemy[i] = SPR_addSprite(&spr_enemy, 0, -64, TILE_ATTR(PAL2, FALSE, FALSE, FALSE));
        if (!sEnemy[i]) { VDP_drawText("NULL16", 0, 1); sEnemy[i] = sEnemy[0]; }
        SPR_setDepth(sEnemy[i], 5);
        SPR_setVisibility(sEnemy[i], HIDDEN);
    }
    if (stageNo == 1)
    for (i = 0; i < MAX_SPR10; i++)
    {
        sEn10[i] = SPR_addSprite(&spr_en10, 0, -64, TILE_ATTR(PAL2, FALSE, FALSE, FALSE));
        SPR_setDepth(sEn10[i], 5);
        SPR_setVisibility(sEn10[i], HIDDEN);
    }
    for (i = 0; i < MAX_ENEMIES; i++) KIND[i] = 5;
    if (stageNo == 1)
    for (i = 0; i < MAX_MISSILE_SPR; i++)
    {
        sEn4[i] = SPR_addSprite(&spr_en4, 0, -64, TILE_ATTR(PAL2, FALSE, FALSE, FALSE));
        SPR_setDepth(sEn4[i], 5);
        SPR_setVisibility(sEn4[i], HIDDEN);
    }
    if (stageNo >= 2)
    {
        s16 c;
        E2 = (stageNo == 2) ? &e2data_2 : (stageNo == 3) ? &e2data_3 : &e2data_4;
        for (c = 0; c < 4; c++) for (i = 0; i < E2->pool[c]; i++)
        {
            sE2[c][i] = SPR_addSprite(E2->spr[c], 0, -64, TILE_ATTR(PAL2, FALSE, FALSE, FALSE));
            if (!sE2[c][i]) { VDP_drawText("NULLE2", 0, 2); sE2[c][i] = sE2[0][0]; continue; }
            SPR_setDepth(sE2[c][i], 5); SPR_setVisibility(sE2[c][i], HIDDEN);
        }
    }
    for (i = 0; i < MAX_EX; i++)
    {
        sEx[i] = SPR_addSprite(&spr_exm, 0, -64, TILE_ATTR(PAL2, FALSE, FALSE, FALSE));
        SPR_setDepth(sEx[i], 2);
        SPR_setVisibility(sEx[i], HIDDEN);
        exTimer[i] = 0;
    }
    memset(&enemies, 0, sizeof(enemies));
    memset(groupKills, 0, sizeof(groupKills));
    enemies.bossDead = 0;
    spawned = spawnedM = spawnedP = spawnedS = spawned6 = spawnedB = spawned12 = spawned9 = spawned10 = bossSpawned = spawnedG = spawnedE = 0;
    memset(bombOn, 0, sizeof(bombOn));
    spawn2 = spawnB2 = 0;
    if (stageNo >= 2)       // les tables du stage 1 ne servent pas : tout est considéré comme déjà apparu
    {
        spawned = STAGE1_NUM_ENEMIES; spawnedM = STAGE1_NUM_MISSILES; spawnedP = STAGE1_NUM_POD7; spawnedS = STAGE1_NUM_SHIP8; spawned6 = STAGE1_NUM_POD6;
        spawnedB = STAGE1_NUM_BOSS11; spawned12 = STAGE1_NUM_BUL12; spawned9 = STAGE1_NUM_POD9; spawned10 = STAGE1_NUM_POD10; bossSpawned = 1;
        spawnedG = STAGE1_NUM_GROUND; spawnedE = STAGE1_NUM_EBUL;
    }
}

// angle (0..31) de (ex, ey) vers (tx, ty) : transcription de la routine $4030, y compris sa retenue de trop
static s16 aim(s16 ex, s16 ey, s16 tx, s16 ty)
{
    s16 q = 0, a;
    s16 dy = ey - ty - 1;
    s16 dx = ex - tx - 1;
    if (dy < 0) { q = 1; dy = -dy; }
    q <<= 1;
    if (dx < 0) { q |= 1; dx = -dx; }
    while (((dy >= dx) ? dy : dx) >= 8) { dy >>= 1; dx >>= 1; }
    a = aim_atan[dy * 8 + dx];
    if ((q + 1) & 2) a = 8 - a;
    return (a + aim_quad[q]) & 0xFF;
}

static void kill(s16 i)
{
    enemies.on[i] = 2;
    enemies.kills++;
    if (group[i] != NOGROUP) groupKills[group[i]]++;
}

// contact ennemi -> joueur (voir enemy.h) ; renvoie rien, détruit l'ennemi et crédite les points si le contact a un effet
static void contact(s16 i, s16 f, s16 playerObjX, s16 playerObjY, u16* bonus)
{
    if (((f + ENEMY_PARITY_I * i) & 1) == ENEMY_PARITY)
    {
        const s16 dx = playerObjX - enemies.x[i];       // > 0 : ennemi à gauche du joueur
        const s16 dy = playerObjY - enemies.y[i];
        const s16 adx = (dx < 0) ? -dx : dx, ady = (dy < 0) ? -dy : dy;
        const s16 hx = HWK(KIND[i]);
        if ((adx < 10 + hx) && (ady < 7 + HHK(KIND[i])))
        {
            if (PLAYER_contact(adx >= 7 + hx, dx > 0) != CONTACT_NONE)
            {
                if (KIND[i] == 12) kill(i);
                else if (KIND[i] != 11) { kill(i); *bonus += ENEMY_SCORE; }
            }
        }
    }
}


// bouton bombe : une bombe par voie libre (38 = gauche, 43 = droite) ; point de visée = ennemi au sol le plus proche non déjà visé
// (|dx| < 32 du joueur, vu entre y = 70 et 150), sinon (x du joueur, y = 111) ; la bombe part de y du joueur, x visée -+ 12
void ENEMY_bombPress(s16 px, s16 py)
{
    s16 b, i, best = -1, bestDx = 32, cx = px, ly = 111;
    for (b = 0; b < NUM_BOMBS; b++) if (!bombOn[b]) break;
    if (b == NUM_BOMBS) return;
    for (i = 0; i < MAX_ENEMIES; i++)
    {
        s16 dx, k;
        if ((enemies.on[i] != 1) || ((KIND[i] != 14) && (KIND[i] != 15))) continue;
        if ((enemies.y[i] < 70) || (enemies.y[i] > 150)) continue;
        for (k = 0; k < NUM_BOMBS; k++) if (bombOn[k] && (bombTarget[k] == i)) break;
        if (k < NUM_BOMBS) continue;
        dx = enemies.x[i] - px; if (dx < 0) dx = -dx;
        if (dx < bestDx) { bestDx = dx; best = i; }
    }
    if (best >= 0) cx = enemies.x[best];
    bombOn[b] = 1; bombT[b] = 0; bombTarget[b] = best; bombLandY[b] = ly; bombKillIn[b] = 0;
    bombX[b] = cx + ((b == 0) ? -12 : 12);
    bombFy[b] = (s32) (py - 5) << 8;
}

static void bombsUpdate(u16* bonus)
{
    s16 b, i;
    for (b = 0; b < NUM_BOMBS; b++)
    {
        if (!bombOn[b]) continue;
        if (bombKillIn[b])
        {
            // l'ennemi touché se transforme en explosion 4 frames après la détonation de la bombe (+100 points)
            if (--bombKillIn[b] == 0)
            {
                for (i = 0; i < MAX_ENEMIES; i++)
                {
                    s16 dx = bombHitX[b] - enemies.x[i], dy = bombHitY[b] - enemies.y[i];
                    if ((enemies.on[i] != 1) || ((KIND[i] != 14) && (KIND[i] != 15))) continue;
                    if (dx < 0) dx = -dx;
                    if (dy < 0) dy = -dy;
                    if ((dx < 12) && (dy < 12)) { kill(i); *bonus += ENEMY_SCORE; }
                }
                bombOn[b] = 0;
            }
            continue;
        }
        bombT[b]++;
        if (bombT[b] <= 8) continue;
        bombFy[b] -= 0x280;
        i = bombTarget[b];
        if ((i >= 0) && (enemies.on[i] == 1)) bombLandY[b] = enemies.y[i]; else if (i >= 0) bombTarget[b] = -1;
        if ((bombFy[b] >> 8) <= bombLandY[b] + ((bombTarget[b] >= 0) ? 0 : 4))
        {
            bombHitX[b] = (bombTarget[b] >= 0) ? enemies.x[bombTarget[b]] : bombX[b] + ((b == 0) ? 12 : -12);
            bombHitY[b] = bombFy[b] >> 8;
            bombKillIn[b] = 4;
        }
    }
}

void ENEMY_update(s16 frame, s16 playerObjX, s16 playerObjY, s16 scrollDelta, u16* bonus, bool contactOn)
{
    const s16 f = frame - ENEMY_LAG;                    // frame de calcul correspondante sur PCE
    bossT = f - BOSS_START_FRAME;
    if ((stageNo == 1) && (bossT >= 0) && !bossReady) bossStart();
    if (bossDeathT)
    {
        if (bossDeathT == 1) STAGE_eraseBoss();
        // mort du boss : le crabe disparaît d'un coup, explosions réparties sur son corps pendant ~130 frames, puis fin de niveau
        if (!(bossDeathT % 6))
        {
            s16 k;
            for (k = 0; k < MAX_EX; k++) if (!exTimer[k]) break;
            if (k < MAX_EX)
            {
                const u16 r = random();
                exTimer[k] = EX_TOTAL; exGroup[k] = NOGROUP;
                exX[k] = 120 - 60 + (r & 127) - 8; exY[k] = 24 + ((r >> 7) & 63) - 8;
            }
        }
        if (++bossDeathT > 130) { enemies.bossDead = 1; bossDeathT = 0; bossReady = 3; }
    }
    s16 i;

    *bonus = 0;
    scrollHist[3] = scrollHist[2]; scrollHist[2] = scrollHist[1]; scrollHist[1] = scrollHist[0]; scrollHist[0] = scrollDelta;
    for (i = 0; i < MAX_EX; i++)
    {
        if (!exTimer[i]) continue;
        exY[i] += scrollDelta;
        // groupe entièrement détruit : 1000 points quand la dernière explosion se termine
        if ((--exTimer[i] == 0) && (exGroup[i] != NOGROUP) && (groupKills[exGroup[i]] == WAVE_SIZE))
        {
            *bonus += WAVE_BONUS;
            groupKills[exGroup[i]] = 0xFF;
        }
    }
    for (i = 0; i < MAX_ENEMIES; i++)
    {
        if (enemies.on[i] == 2)                         // touché à la frame précédente : l'explosion commence
        {
            s16 k;
            enemies.on[i] = 4; cnt[i] = EX_TOTAL;            // l'objet explosion de l'original garde son emplacement 31 frames
            for (k = 0; k < MAX_EX; k++)
            {
                if (exTimer[k]) continue;
                exTimer[k] = EX_TOTAL; exX[k] = enemies.x[i] - 8; exY[k] = enemies.y[i] - 8; exGroup[k] = group[i];
                break;
            }
            if ((k == MAX_EX) && (group[i] != NOGROUP) && (groupKills[group[i]] == WAVE_SIZE)) { *bonus += WAVE_BONUS; groupKills[group[i]] = 0xFF; }
            continue;
        }
        if (enemies.on[i] == 4) { if (--cnt[i] <= 0) enemies.on[i] = 0; continue; }
        if (enemies.on[i] == 3) { enemies.on[i] = 1; continue; }          // projectile créé après son emplacement dans la boucle : apparaît à la frame suivante
        if (!enemies.on[i]) continue;
#if ENEMY_TEST_PRE
        if (contactOn && (enemies.on[i] == 1)) contact(i, f, playerObjX, playerObjY, bonus);
        if (enemies.on[i] != 1) continue;
#endif

        if (KIND[i] >= 32)
        {
            // ennemi du stage 2 : trajectoire rejouée depuis le gabarit relevé sur PCE
            const E2Tpl* tp = &E2->tpl[E2->inst[rIdx[i]].tpl];
            if ((rT[i] + 1) >= tp->len) { enemies.on[i] = 0; continue; }
            { u8 pi = E2->pi[tp->off + rT[i]]; enemies.x[i] += E2->pdx[pi]; enemies.y[i] += E2->pdy[pi]; }
            rT[i]++;
            if (--rL[i] == 0) { rR[i]++; rF[i] = E2->rf[rR[i]]; rL[i] = E2->rl[rR[i]]; }
#if !ENEMY_TEST_PRE
            if (contactOn && (enemies.y[i] > 0)) contact(i, f, playerObjX, playerObjY, bonus);
#endif
            continue;
        }
        if (KIND[i] == 11)
        {
            // mi-boss (type 11) : descend de y = -30 à 80 (2 px/frame), reste 279 frames en place, repart vers le haut
            const s16 k = ++arcFrames[i];
            state[i] = (k < 56) ? 1 : (k < 129) ? 2 : (k < 207) ? 3 : (k < 239) ? 4 : (k < 335) ? 5 : 6;
            enemies.y[i] = (k <= 55) ? (-30 + 2 * k) : (k < 335) ? 80 : (78 - 2 * (k - 335));
            if (enemies.y[i] < -48) { enemies.on[i] = 0; continue; }
#if !ENEMY_TEST_PRE
            if (contactOn) contact(i, f, playerObjX, playerObjY, bonus);
#endif
            continue;
        }
        if (KIND[i] == 12)
        {
            // projectile du mi-boss : ligne droite ; les 12 premiers (angle[i] < 12) disparaissent après 80 frames
            fx[i] += vx[i]; fy[i] += vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            arcFrames[i]++;
            if (angle[i] < 12) { if (arcFrames[i] > 80) { enemies.on[i] = 0; continue; } }
            else if ((enemies.y[i] >= 256) || (enemies.y[i] < -48) || (enemies.x[i] < -32) || (enemies.x[i] > 271)) { enemies.on[i] = 0; continue; }
#if !ENEMY_TEST_PRE
            if (contactOn) contact(i, f, playerObjX, playerObjY, bonus);
#endif
            continue;
        }
        if (KIND[i] == 6)
        {
            // type 6 (routine $637B) : arrive du bas par un côté, spirale : 6 crans d'angle (toutes les 7 frames), 26 frames droit,
            // 62 crans de sens inverse (toutes les 5 frames), 26 frames droit, puis crans toutes les 7 frames jusqu'à la sortie par le bas
            const s16 st = state[i];
            if ((st & 1) != 0)          // états 1, 3, 5 : cran d'angle périodique
            {
                if (--timer[i] == 0)
                {
                    timer[i] = (st == 3) ? 5 : 7;
                    if (--cnt[i] == 0) { state[i] = st + 1; cnt[i] = (st == 3) ? 26 : 63; timer[i] = (st == 1) ? 0 : 1; if (st == 1) cnt[i] = 26; }
                    else
                    {
                        angle[i] = (angle[i] + (((st != 3) == ((flags[i] & 1) != 0)) ? -1 : 1)) & 31;
                        vx[i] = ship6_vel[angle[i]][0]; vy[i] = ship6_vel[angle[i]][1];
                    }
                }
            }
            else if (--cnt[i] == 0) { state[i] = st + 1; cnt[i] = 63; timer[i] = 1; }       // états 2, 4 : ligne droite
            fx[i] += vx[i]; fy[i] += vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            arcFrames[i]++;
            // clignote une image sur deux pendant les 48 premières frames
            if ((arcFrames[i] < 48) && ((((flags[i] >> 2) + arcFrames[i]) & 1) != 0)) flags[i] |= 2; else flags[i] &= ~2;
            if ((enemies.y[i] >= 256) || (enemies.x[i] < -32) || (enemies.x[i] > 271)) { enemies.on[i] = 0; continue; }
#if !ENEMY_TEST_PRE
            if (contactOn) contact(i, f, playerObjX, playerObjY, bonus);
#endif
            continue;
        }
        if (KIND[i] == 14)
        {
            // types 13 / 14 (routine $4EE0) : suit le sol ; ouvert 10 frames puis fermé 240 frames (premier cycle : 240 ou 120 selon l'indicateur)
            fy[i] += (s32) scrollHist[GSH] << 8;
            if (timer[i] == 0)
            {
                if (cnt[i] == 0) { cnt[i] = 1; timer[i] = 10; }
                else { cnt[i] = 0; timer[i] = 0xF0; }
            }
            timer[i]--;
            enemies.y[i] = fy[i] >> 8;
            if (enemies.y[i] >= 256) { enemies.on[i] = 0; continue; }
            continue;
        }
        if (KIND[i] == 15)
        {
            // type 15 (routine $4F2E) : marcheur ; 96 frames d'arrêt puis 128 frames de marche (vx = +-0,125, vy = 0,125), toujours entraîné par le sol
            fy[i] += (s32) scrollHist[GSH] << 8;
            if (cnt[i] == 0)
            {
                for (;;)
                {
                    const s16 v = gwalkTab[angle[i]];
                    if (!v) { angle[i] = 0; continue; }
                    cnt[i] = v;
                    if (gwalkTab[angle[i] + 1]) { vx[i] = (flags[i] & 1) ? 0x20 : -0x20; vy[i] = 0x20; } else vx[i] = vy[i] = 0;
                    angle[i] += 2;
                    break;
                }
            }
            if (timer[i] == 0)
            {
                arcFrames[i]++;
                if (arcFrames[i] & 1) { svx[i] = 1; timer[i] = 10; } else { svx[i] = 0; timer[i] = 0xC0; }
            }
            timer[i]--; cnt[i]--;
            fx[i] += vx[i]; fy[i] += vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            if ((enemies.y[i] >= 256) || (enemies.x[i] < -32) || (enemies.x[i] > 271)) { enemies.on[i] = 0; continue; }
            continue;
        }
        if (KIND[i] == 13)
        {
            // boss de fin : boîte de collision qui suit le corps du crabe ; salves de 3 tirs visés depuis le canon gauche (x = 73) puis droit (x = 167),
            // toutes les ~80 frames à partir de la frame de calcul 15127 (relevé sur la trace PCE : tirs en y_crabe + 63)
            const s16 bt = (bossT >= 0) ? (bossT % BOSS_NUM_FRAMES) : 0;
            const s16 by = boss_ay[bt] + 32;
            arcFrames[i]++;
            enemies.y[i] = by;
            if ((bossT >= 507) && (((bossT - 507) % 80) == 0))
            {
                const s16 ox = (((bossT - 507) / 80) & 1) ? 167 : 73, oy = boss_ay[bt] + 63;
                s16 q, a0 = aim(ox, oy, playerObjX, playerObjY) & 31;
                for (q = -2; q <= 2; q += 2)
                {
                    s16 j;
                    for (j = 0; j < MAX_AIR; j++) if (!enemies.on[j]) break;
                    if (j == MAX_AIR) break;
                    enemies.on[j] = 3; state[j] = 2; KIND[j] = 12; arcFrames[j] = 0; group[j] = NOGROUP; angle[j] = 99;
                    vx[j] = ship8_vel[(a0 + q) & 31][0]; vy[j] = ship8_vel[(a0 + q) & 31][1];
                    fx[j] = ox * 256; fy[j] = oy * 256;
                    enemies.x[j] = ox; enemies.y[j] = oy;
                }
            }
            continue;
        }
        if (KIND[i] == 9)
        {
            // type 9 (routine $65FE) : entre par le haut côté gauche (ou droit), avance vers x = 120 en ralentissant (vy -> 0), s'arrête 96 frames,
            // tourne (un cran d'angle toutes les 17 frames, vitesse $1C) jusqu'à y >= 208, puis fonce vers le joueur (vitesse $40)
            switch (state[i])
            {
            case 1:
                if ((enemies.x[i] & 0xFF) == 0x78) { state[i] = 2; ay[i] = 0; vx[i] = 0; cnt[i] = 0; }
                break;
            case 2:
                if (++cnt[i] == 0x60)
                {
                    state[i] = 3; angle[i] = (flags[i] & 1) ? 0x0E : 2;
                    vx[i] = ship9_vel28[angle[i]][0]; vy[i] = ship9_vel28[angle[i]][1]; timer[i] = 0x10;
                }
                break;
            case 3:
                if (timer[i] == 0)
                {
                    timer[i] = 0x10; angle[i] = (flags[i] & 1) ? ((angle[i] - 1) & 31) : ((angle[i] + 1) & 31);
                    vx[i] = ship9_vel28[angle[i]][0]; vy[i] = ship9_vel28[angle[i]][1];
                }
                if ((enemies.y[i] & 0xFF) >= 0xD0)
                {
                    const s16 a = aim(enemies.x[i], enemies.y[i], playerObjX, playerObjY) & 31;
                    state[i] = 4; vx[i] = ship9_vel64[a][0]; vy[i] = ship9_vel64[a][1];
                }
                timer[i]--;
                break;
            }
            vx[i] += ax[i]; vy[i] += ay[i];
            fx[i] += vx[i]; fy[i] += vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            arcFrames[i]++;
            if ((enemies.y[i] >= 256) || (enemies.y[i] < -48) || (enemies.x[i] < -32) || (enemies.x[i] > 271)) { enemies.on[i] = 0; continue; }
#if !ENEMY_TEST_PRE
            if (contactOn) contact(i, f, playerObjX, playerObjY, bonus);
#endif
            continue;
        }
        if (KIND[i] == 10)
        {
            // type 10 (routine $652D) : monte de y = 224 à 1 px/frame pendant 192 frames, puis déploie ses ailes (accélération en courbe,
            // ax = +-18 selon le côté de l'écran, ay = 8) jusqu'à vy = 512, et redescend
            switch (state[i])
            {
            case 1:
                if (++cnt[i] >= 0xC0)
                {
                    state[i] = 2; ay[i] = 8; timer[i] = 0;
                    if (((enemies.x[i] & 0xFF) - 0x78) & 0x80) { flags[i] = 0; ax[i] = 0x12; } else { flags[i] = 1; ax[i] = -0x12; }
                }
                break;
            case 2:
                timer[i]++;
                if (vy[i] == 0) ax[i] = -ax[i];
                if ((vy[i] >> 8) == 1) { ax[i] = ay[i] = 0; vy[i] = (vy[i] & 0xFF) | 0x200; state[i] = 3; }
                if (flags[i] & 1) fy[i] += 0x55;
                break;
            }
            vx[i] += ax[i]; vy[i] += ay[i];
            fx[i] += vx[i]; fy[i] += vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            arcFrames[i]++;
            if ((enemies.y[i] >= 256) || (enemies.y[i] < -48) || (enemies.x[i] < -32) || (enemies.x[i] > 271)) { enemies.on[i] = 0; continue; }
#if !ENEMY_TEST_PRE
            if (contactOn) contact(i, f, playerObjX, playerObjY, bonus);
#endif
            continue;
        }
        if (KIND[i] == 8)
        {
            // type 8 (routine $648B) : ligne droite jusqu'à passer à moins de 96 px au-dessus du joueur, puis demi-tour
            // (un cran d'angle toutes les 3 frames, 16 crans), puis ligne droite dans le sens opposé
            if (state[i] == 1)
            {
                const s16 t = (enemies.y[i] & 0xFF) + 0x60, hi = ((enemies.y[i] >> 8) + (t >> 8)) & 0xFF;
                if ((hi != 0) || ((playerObjY & 0xFF) < (t & 0xFF))) { state[i] = 2; cnt[i] = 3; }
            }
            else if (state[i] == 2)
            {
                if (cnt[i] == 0)
                {
                    cnt[i] = 3;
                    angle[i] = (flags[i] & 1) ? ((angle[i] - 1) & 31) : ((angle[i] + 1) & 31);
                    if (angle[i] == ((flags[i] & 1) ? 0x1D : 0x13)) state[i] = 3;
                    vx[i] = ship8_vel[angle[i]][0]; vy[i] = ship8_vel[angle[i]][1];
                }
                cnt[i]--;
            }
            fx[i] += vx[i]; fy[i] += vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            arcFrames[i]++;
            if ((enemies.y[i] >= 256) || (enemies.x[i] < -32) || (enemies.x[i] > 271)) { enemies.on[i] = 0; continue; }
#if !ENEMY_TEST_PRE
            if (contactOn) contact(i, f, playerObjX, playerObjY, bonus);
#endif
            continue;
        }
        if (KIND[i] == 7)
        {
            // type 7 (routine $6234) : descend jusqu'à 80 px au-dessus du joueur, accélère en courbe (24 frames),
            // s'arrête 96 frames, repart en sens inverse (24 frames d'accélération opposée) puis remonte hors de l'écran
            switch (state[i])
            {
            case 1:
                {
                    const s16 y6 = (s16) ((enemies.y[i] + 0x50) & 0xFF);
                    if ((y6 >= 0xCE) || ((playerObjY & 0xFF) < y6))
                    {
                        ay[i] = -0x10; ax[i] = (flags[i] & 1) ? -0x12 : 0x12; cnt[i] = 0x18; state[i] = 2; arcFrames[i] = 0;
                    }
                }
                break;
            case 2:
                if (--cnt[i] == 0) { svx[i] = vx[i]; svy[i] = -vy[i]; vx[i] = vy[i] = ax[i] = ay[i] = 0; cnt[i] = 0x60; state[i] = 3; arcFrames[i] = 0; }
                break;
            case 3:
                if (--cnt[i] == 0)
                {
                    vx[i] = svx[i]; vy[i] = svy[i]; cnt[i] = 0x18; ax[i] = (flags[i] & 1) ? 0x10 : -0x10; ay[i] = -0x10; state[i] = 4; arcFrames[i] = 0;
                }
                break;
            case 4:
                if (--cnt[i] == 0) { ax[i] = ay[i] = 0; vx[i] = 0; state[i] = 5; arcFrames[i] = 0; }
                break;
            }
            vx[i] += ax[i]; vy[i] += ay[i];
            fx[i] += vx[i]; fy[i] += vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            arcFrames[i]++;
            if ((state[i] == 5) && (enemies.y[i] < -48)) { enemies.on[i] = 0; continue; }
#if !ENEMY_TEST_PRE
            if (contactOn) contact(i, f, playerObjX, playerObjY, bonus);
#endif
            continue;
        }
        if (KIND[i] != 5)
        {
            // type 3 / 4 : ligne droite à vitesse constante, sortie par le bas ou par les côtés
            fx[i] += vx[i]; fy[i] += vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            arcFrames[i]++;
            if ((enemies.y[i] >= 256) || (enemies.x[i] < -32) || (enemies.x[i] > 271)) { enemies.on[i] = 0; continue; }
#if !ENEMY_TEST_PRE
            if (contactOn) contact(i, f, playerObjX, playerObjY, bonus);
#endif
            continue;
        }
        if (state[i] == 1)
        {
            // approche en ligne droite jusqu'à passer à moins de 32 px (en x) du joueur
            s16 dx = playerObjX - (s16) (fx[i] >> 8);
            if (dx < 0) dx = -dx;
            if (dx < ENEMY_TRIGGER_DX) { state[i] = 2; timer[i] = 0; arcFrames[i] = 0; }
        }
        else
        {
            // virage : un cran d'angle toutes les 12 frames, vitesse $20 ; l'ennemi suit aussi le sol
            fy[i] += 0x55;
            if (timer[i] == 0)
            {
                timer[i] = ENEMY_TURN_FRAMES;
                angle[i] = (angle[i] + ((flags[i] & 2) ? -1 : 1)) & 31;
                vx[i] = enemy_vel[angle[i]][0]; vy[i] = enemy_vel[angle[i]][1];
            }
            timer[i]--;
            arcFrames[i]++;
        }
        fx[i] += vx[i]; fy[i] += vy[i];
        enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
        if (enemies.y[i] >= 256) { enemies.on[i] = 0; continue; }       // sorti par le bas (seul test de sortie de l'original)
#if !ENEMY_TEST_PRE
        if (contactOn) contact(i, f, playerObjX, playerObjY, bonus);
#endif

    }

    bombsUpdate(bonus);
    {
        s16 b;
        for (b = 0; b < NUM_BOMBS; b++) { enemies.bombState[b] = bombOn[b] ? ((bombKillIn[b]) ? 2 : 1) : 0; enemies.bombX[b] = bombX[b]; enemies.bombY[b] = bombFy[b] >> 8; }
    }
    // ennemis au sol : apparaissent en haut (y = -31 ou -32) ; ceux de type 13/14 ont déjà fait un cycle de leur routine, ceux de type 15 une avance de 1/3 px
    while ((spawnedG < STAGE1_NUM_GROUND) && (stage1_ground[spawnedG].frame <= f))
    {
        const GroundSpawn* e = &stage1_ground[spawnedG++];
        for (i = MAX_AIR; i < MAX_ENEMIES; i++)
        {
            if (enemies.on[i]) continue;
            enemies.on[i] = 1; state[i] = 1; group[i] = NOGROUP; arcFrames[i] = 0; flags[i] = e->flags & 1;
            fx[i] = (s32) e->x * 256; fy[i] = (s32) e->y * 256;
            if (e->type == 15)
            {
                KIND[i] = 15; cnt[i] = 0; angle[i] = 0; timer[i] = 0xF0; svx[i] = 0; vx[i] = vy[i] = 0;
            }
            else
            {
                KIND[i] = 14; flags[i] |= (e->type == 14) ? 2 : 0; cnt[i] = 0; timer[i] = (e->flags & 1) ? 0x78 : 0xF0; timer[i]--;
            }
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            break;
        }
    }

    // ennemis de type 3 et 4 : apparaissent en haut (y = -32) et visent le joueur une fois pour toutes
    while ((spawnedM < STAGE1_NUM_MISSILES) && (stage1_missiles[spawnedM].frame <= f))
    {
        const MissileSpawn* e = &stage1_missiles[spawnedM++];
        for (i = 0; i < MAX_AIR; i++)
        {
            const s16 a = aim(e->x, -32, playerObjX, playerObjY) & 31;
            if (enemies.on[i]) continue;
            enemies.on[i] = 1; state[i] = 1; KIND[i] = e->kind; angle[i] = a; arcFrames[i] = 0; group[i] = NOGROUP;
            vx[i] = missile_vel[a][0]; vy[i] = missile_vel[a][1];
            fx[i] = ((s32) e->x * 256) + vx[i]; fy[i] = (-32 * 256) + vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            break;
        }
    }

    if (stageNo >= 2)
    {
        while ((spawn2 < E2->nInst) && (E2->inst[spawn2].t0 <= f))
        {
            const E2Inst* in = &E2->inst[spawn2];
            for (i = 0; i < MAX_ENEMIES; i++)
            {
                if (enemies.on[i]) continue;
                enemies.on[i] = 1; KIND[i] = 32 + in->ty; rIdx[i] = spawn2; rT[i] = 0; rR[i] = E2->tpl[in->tpl].roff; rF[i] = E2->rf[rR[i]]; rL[i] = E2->rl[rR[i]]; group[i] = NOGROUP; hp[i] = 1;
                enemies.x[i] = in->x; enemies.y[i] = in->y;
                break;
            }
            spawn2++;
        }
        while ((spawnB2 < E2->nBul) && (E2->bul[spawnB2].frame <= f))
        {
            const E2Bul* e = &E2->bul[spawnB2++];
            s16 k, j;
            for (k = 0; k < MAX_ENEMIES; k++)
            {
                if ((enemies.on[k] != 1) || (KIND[k] < 32)) continue;
                if ((abs(enemies.x[k] - e->x) > 3) || (abs(enemies.y[k] - e->y) > 3)) continue;
                if ((abs(playerObjX - enemies.x[k]) < 0x30) && (abs(playerObjY - enemies.y[k]) < 0x28)) break;
                for (j = 0; j < MAX_AIR; j++) if (!enemies.on[j]) break;
                if (j == MAX_AIR) for (j = 0; j < MAX_ENEMIES; j++) if (!enemies.on[j]) break;
                if (j == MAX_ENEMIES) break;
                {
                    const s16 a = (aim(enemies.x[k], enemies.y[k], playerObjX, playerObjY) + (random() & 3) - 1) & 31;
                    enemies.on[j] = 3; state[j] = 2; KIND[j] = 12; arcFrames[j] = 0; group[j] = NOGROUP; angle[j] = 99;
                    vx[j] = ebul_vel[a][0]; vy[j] = ebul_vel[a][1];
                    fx[j] = enemies.x[k] * 256; fy[j] = enemies.y[k] * 256;
                    enemies.x[j] = enemies.x[k]; enemies.y[j] = enemies.y[k];
                }
                break;
            }
        }
    }

    // tirs ennemis génériques : à la frame relevée, si un ennemi vivant se trouve à la position du tireur (et que le joueur n'est pas trop près :
    // routine $4507), un tir est créé vers le joueur (angle de visée + (0..3) - 1, vitesse 319/256)
    while ((spawnedE < STAGE1_NUM_EBUL) && (stage1_ebul[spawnedE].frame <= f))
    {
        const EBulSpawn* e = &stage1_ebul[spawnedE++];
        s16 k, j;
        for (k = 0; k < MAX_AIR; k++)
        {
            const s16 kd = KIND[k];
            if ((enemies.on[k] != 1) || (kd == 12) || (kd >= 11)) continue;
            if ((abs(enemies.x[k] - e->x) > 3) || (abs(enemies.y[k] - e->y) > 3)) continue;
            if ((abs(playerObjX - enemies.x[k]) < 0x30) && (abs(playerObjY - enemies.y[k]) < 0x28)) break;
            for (j = 0; j < MAX_AIR; j++) if (!enemies.on[j]) break;
            if (j == MAX_AIR) break;
            {
                const s16 a = (aim(enemies.x[k], enemies.y[k], playerObjX, playerObjY) + (random() & 3) - 1) & 31;
                enemies.on[j] = 3; state[j] = 2; KIND[j] = 12; arcFrames[j] = 0; group[j] = NOGROUP; angle[j] = 99;
                vx[j] = ebul_vel[a][0]; vy[j] = ebul_vel[a][1];
                fx[j] = enemies.x[k] * 256; fy[j] = enemies.y[k] * 256;
                enemies.x[j] = enemies.x[k]; enemies.y[j] = enemies.y[k];
            }
            break;
        }
    }

    // mi-boss (type 11) : x = 112, y = -30
    while ((spawnedB < STAGE1_NUM_BOSS11) && (stage1_boss11[spawnedB] <= f))
    {
        spawnedB++;
        for (i = 0; i < MAX_AIR; i++)
        {
            if (enemies.on[i]) continue;
            enemies.on[i] = 1; state[i] = 1; KIND[i] = 11; arcFrames[i] = 0; group[i] = NOGROUP; hp[i] = 16;
            enemies.x[i] = 112; enemies.y[i] = -30;
            break;
        }
    }
    // projectiles du mi-boss (type 12) : réessayés à la frame suivante tant qu'aucun emplacement n'est libre
    while ((spawned12 < STAGE1_NUM_BUL12) && (stage1_bul12[spawned12].frame <= f))
    {
        const Bul12Spawn* e = &stage1_bul12[spawned12];
        bool delayed;
        for (i = 0; i < MAX_AIR; i++) if (!enemies.on[i]) break;
        if (i == MAX_AIR) break;
        {
            // le projectile est créé pendant la mise à jour du mi-boss : s'il occupe un emplacement déjà traité cette frame, il n'apparaît qu'à la suivante
            s16 b = 99, q;
            for (q = 0; q < MAX_ENEMIES; q++) if (enemies.on[q] && (KIND[q] == 11)) b = q;
            delayed = (i < b);
        }
        spawned12++;
        enemies.on[i] = delayed ? 3 : 1; state[i] = (e->idx < 12) ? 1 : 2; KIND[i] = 12; arcFrames[i] = 0; group[i] = NOGROUP; angle[i] = e->idx;
        vx[i] = e->vx; vy[i] = e->vy;
        fx[i] = e->x; fy[i] = e->y;
        enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
    }

    // ennemis de type 6 : arrivent du bas par un côté (x = -8 ou 248, y = 200), vitesse $26, angle initial 0x19 (ou 0x17)
    while ((spawned6 < STAGE1_NUM_POD6) && (stage1_pod6[spawned6].frame <= f))
    {
        const Pod6Spawn* e = &stage1_pod6[spawned6++];
        for (i = 0; i < MAX_AIR; i++)
        {
            if (enemies.on[i]) continue;
            enemies.on[i] = 1; state[i] = 1; KIND[i] = 6; flags[i] = (e->flags & 1) | ((e->frame & 1) << 2); arcFrames[i] = 0; group[i] = NOGROUP;
            angle[i] = (e->flags & 1) ? 0x17 : 0x19; cnt[i] = 7; timer[i] = 1; vx[i] = vy[i] = 0;
            fx[i] = ((e->flags & 1) ? 248 : -8) * 256; fy[i] = 200 * 256;
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            break;
        }
    }

    // boss de fin : actif à partir de la frame de jeu 15160 (crabe entièrement visible)
    if (!bossSpawned && (f >= 15160))
    {
        for (i = 0; i < MAX_AIR; i++)
        {
            if (enemies.on[i]) continue;
            bossSpawned = 1; enemies.on[i] = 1; state[i] = 1; KIND[i] = 13; arcFrames[i] = 0; group[i] = NOGROUP; hp[i] = 500;
            enemies.x[i] = 120; enemies.y[i] = 50;
            break;
        }
    }
    // ennemis de type 9 : x = 24 (ou 216), y = -8, vitesse (+-1, 1,125) ; déjà déplacés une fois à l'apparition
    while ((spawned9 < STAGE1_NUM_POD9) && (stage1_pod9[spawned9].frame <= f))
    {
        const Pod9Spawn* e = &stage1_pod9[spawned9++];
        for (i = 0; i < MAX_AIR; i++)
        {
            if (enemies.on[i]) continue;
            enemies.on[i] = 1; state[i] = 1; KIND[i] = 9; flags[i] = e->flags; arcFrames[i] = 0; group[i] = NOGROUP; cnt[i] = 0;
            ax[i] = 0; ay[i] = -3; vx[i] = (e->flags & 1) ? -256 : 256; vy[i] = 0x120 - 3;
            fx[i] = (((e->flags & 1) ? 216 : 24) * 256) + vx[i]; fy[i] = (-8 * 256) + vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            break;
        }
    }
    // ennemis de type 10 : montent du bas (y = 224), x selon la table
    while ((spawned10 < STAGE1_NUM_POD10) && (stage1_pod10[spawned10].frame <= f))
    {
        const Pod10Spawn* e = &stage1_pod10[spawned10++];
        for (i = 0; i < MAX_AIR; i++)
        {
            if (enemies.on[i]) continue;
            enemies.on[i] = 1; state[i] = 1; KIND[i] = 10; flags[i] = e->idx; arcFrames[i] = 0; group[i] = NOGROUP; cnt[i] = 0; timer[i] = 0;
            ax[i] = ay[i] = 0; vx[i] = 0; vy[i] = -256;
            fx[i] = (s32) e->x * 256; fy[i] = (224 * 256) + vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            break;
        }
    }

    // ennemis de type 8 : arrivent par le côté (x = -8 ou 248), y = -32, vitesse $24 à l'angle 3 (ou 13)
    while ((spawnedS < STAGE1_NUM_SHIP8) && (stage1_ship8[spawnedS].frame <= f))
    {
        const Ship8Spawn* e = &stage1_ship8[spawnedS++];
        for (i = 0; i < MAX_AIR; i++)
        {
            if (enemies.on[i]) continue;
            enemies.on[i] = 1; state[i] = 1; KIND[i] = 8; flags[i] = e->flags; arcFrames[i] = 0; group[i] = NOGROUP; cnt[i] = 0;
            angle[i] = (e->flags & 1) ? 13 : 3;
            vx[i] = ship8_vel[angle[i]][0]; vy[i] = ship8_vel[angle[i]][1];
            fx[i] = (((e->flags & 1) ? 248 : -8) * 256) + vx[i]; fy[i] = (-32 * 256) + vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            break;
        }
    }

    // ennemis de type 7 : apparaissent en haut (x = 48 ou 192 selon le sens), vitesse verticale initiale $288 (rang de difficulté 4)
    while ((spawnedP < STAGE1_NUM_POD7) && (stage1_pod7[spawnedP].frame <= f))
    {
        const Pod7Spawn* e = &stage1_pod7[spawnedP++];
        for (i = 0; i < MAX_AIR; i++)
        {
            if (enemies.on[i]) continue;
            enemies.on[i] = 1; state[i] = 1; KIND[i] = 7; flags[i] = e->flags; arcFrames[i] = 0; group[i] = NOGROUP;
            vx[i] = 0; ax[i] = ay[i] = 0; vy[i] = 0x288;
            fx[i] = (e->flags & 1) ? (192 * 256) : (48 * 256); fy[i] = (-48 * 256) + vy[i];
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            break;
        }
    }

    // apparitions : table du stage (script d'origine indexé par le défilement, relevé sur une partie de référence)
    while ((spawned < STAGE1_NUM_ENEMIES) && (stage1_enemies[spawned].frame <= f))
    {
        const EnemySpawn* e = &stage1_enemies[spawned++];
        for (i = 0; i < MAX_AIR; i++)
        {
            s16 ex, a;
            if (enemies.on[i]) continue;
            ex = (e->flags & 2) ? 248 : -8;
            if (e->flags & 1)
            {
                // part en visant le joueur, angle borné du côté de l'écran
                a = aim(ex, 0, playerObjX, playerObjY);
                if (e->flags & 2) { if (a >= 0x11) a = 0x10; }
                else if (a >= 8) a = 0;
            }
            else a = (e->flags & 2) ? 13 : 3;
            enemies.on[i] = 1; state[i] = 1; KIND[i] = 5; angle[i] = a; timer[i] = 0; arcFrames[i] = 0;
            flags[i] = e->flags; group[i] = e->group;
            vx[i] = enemy_vel_slow[a][0]; vy[i] = enemy_vel_slow[a][1];
            fx[i] = ((s32) ex * 256) + vx[i]; fy[i] = vy[i];        // déjà déplacé une fois à l'apparition
            enemies.x[i] = fx[i] >> 8; enemies.y[i] = fy[i] >> 8;
            break;
        }
    }
}

bool ENEMY_hitByShot(s16 shotX, s16 shotY)
{
    s16 i;
    for (i = MAX_ENEMIES - 1; i >= 0; i--)          // l'original teste les objets du dernier au premier
    {
        // boîtes de l'original : ennemi 4x5, tir 8x16 (demi-tailles) -> |dx| < 12 et |dy| < 21
        const s16 dx = shotX - (enemies.x[i] - 8);
        const s16 dy = shotY - (enemies.y[i] - 8);
        if ((enemies.on[i] != 1) || ((KIND[i] == 14) || (KIND[i] == 15)) || (enemies.y[i] < 0) || ((KIND[i] == 12) && (state[i] == 1))) continue;       // les 12 premiers projectiles du mi-boss sont intouchables       // hors écran (au-dessus) : intouchable
        if ((dx > -(8 + HWK(KIND[i]))) && (dx < 8 + HWK(KIND[i])) && (dy > -(16 + SHHK(KIND[i]))) && (dy < 16 + SHHK(KIND[i])))
        {
            if (((KIND[i] == 11) || (KIND[i] == 13)) && (--hp[i] > 0)) return TRUE;         // le mi-boss encaisse 16 tirs
            if (KIND[i] == 13) { bossDeathT = 1; enemies.on[i] = 0; return TRUE; }
            kill(i);
            return TRUE;
        }
    }
    return FALSE;
}

s16 ENEMY_hitByCharged(s16 cx, s16 cy, s16 hw, s16 hh)
{
    s16 i, n = 0;
    for (i = 0; i < MAX_ENEMIES; i++)
    {
        const s16 dx = cx - enemies.x[i];
        const s16 dy = cy - enemies.y[i];
        if ((enemies.on[i] != 1) || ((KIND[i] == 14) || (KIND[i] == 15)) || (enemies.y[i] < 0) || ((KIND[i] == 12) && (state[i] == 1))) continue;       // les 12 premiers projectiles du mi-boss sont intouchables
        if ((dx > -(hw + HWK(KIND[i]))) && (dx < (hw + HWK(KIND[i]))) && (dy > -(hh + HHK(KIND[i]))) && (dy < (hh + HHK(KIND[i]))))
        {
            if (((KIND[i] == 11) || (KIND[i] == 13)) && (--hp[i] > 0)) { n++; continue; }
            if (KIND[i] == 13) { bossDeathT = 1; enemies.on[i] = 0; n++; continue; }
            kill(i);
            n++;
        }
    }
    return n;
}

void ENEMY_draw(void)
{
    s16 i, c4 = 0, c16 = 0, c10 = 0;
    if ((bossReady == 1) && !bossDeathT) bossDraw();
    else if ((bossReady == 1) || (bossReady == 3)) { for (i = 0; i < BOSS_MAX_BIG; i++) SPR_setVisibility(sBossL[i], HIDDEN); for (i = 0; i < BOSS_MAX_SMALL; i++) SPR_setVisibility(sBossS[i], HIDDEN); }
    for (i = 0; i < MAX_ENEMIES; i++)
    {
        const s16 k = KIND[i];
        if ((!enemies.on[i]) || (enemies.on[i] >= 3)) continue;
        if ((k == 6) && (flags[i] & 2)) continue;         // clignotement
        if (k == 13) continue;                              // boss : dans le décor
        if (k >= 32) continue;                              // stage 2 : dessiné par e2Draw
        if ((k == 14) || (k == 15))
        {
            if (c16 < maxSpr16)
            {
                const s16 fr = GFR + ((k == 14) ? (((flags[i] & 2) ? 2 : 0) + cnt[i]) : (2 + svx[i]));
                SPR_setVisibility(sEnemy[c16], VISIBLE); SPR_setHFlip(sEnemy[c16], FALSE); SPR_setFrame(sEnemy[c16], fr);
                SPR_setPosition(sEnemy[c16++], enemies.x[i] - 8 + PF_XOFF, enemies.y[i] - 8);
            }
            continue;
        }
        if (k == 11)
        {
            // deux moitiés (gauche normale, droite retournée) : 16x16 avant 171 et après 294, 16x32 entre (image 3 pendant l'arrêt, 207..246)
            const s16 a = arcFrames[i], tall = ((a >= 171) && (a < 295)) ? ((a >= 207) && (a < 247) ? 3 : 2) : 0;
            s16 h;
            for (h = 0; h < 2; h++)
            {
                const s16 px = enemies.x[i] - 16 + 16 * h + PF_XOFF;
                if (tall)
                {
                    if (c4 >= MAX_MISSILE_SPR) continue;
                    SPR_setVisibility(sEn4[c4], VISIBLE); SPR_setHFlip(sEn4[c4], h); SPR_setFrame(sEn4[c4], tall);
                    SPR_setPosition(sEn4[c4++], px, enemies.y[i] - 8);
                }
                else if (c16 < maxSpr16)
                {
                    SPR_setVisibility(sEnemy[c16], VISIBLE); SPR_setHFlip(sEnemy[c16], h); SPR_setFrame(sEnemy[c16], 11);
                    SPR_setPosition(sEnemy[c16++], px, enemies.y[i] - 8);
                }
            }
            continue;
        }
        if (k == 10)
        {
            // 32x16 : image 0-4 selon le nombre de paliers de l'animation d'ouverture (13, 26, 38, 51 frames après le début de la phase 2)
            const s16 t = (state[i] == 1) ? 0 : (state[i] == 3) ? 99 : timer[i];
            const s16 fr = (t >= 13) + (t >= 26) + (t >= 38) + (t >= 51);
            if (c10 >= MAX_SPR10) continue;
            SPR_setVisibility(sEn10[c10], VISIBLE); SPR_setFrame(sEn10[c10], fr);
            SPR_setPosition(sEn10[c10++], enemies.x[i] - 16 + PF_XOFF, enemies.y[i] - 8);
            continue;
        }
        if (k == 4)
        {
            if (c4 >= MAX_MISSILE_SPR) continue;
            SPR_setVisibility(sEn4[c4], VISIBLE); SPR_setHFlip(sEn4[c4], FALSE); SPR_setFrame(sEn4[c4], (arcFrames[i] >> 3) & 1);
            SPR_setPosition(sEn4[c4++], enemies.x[i] - 8 + PF_XOFF, enemies.y[i] - 16);
        }
        else if (c16 < maxSpr16)
        {
            // les types 3, 5 et 7 (16x16) se partagent les sprites sEnemy : images 0-2 = type 5, 3-4 = type 3, 5-6 = type 7
            Sprite* sp = sEnemy[c16++];
            s16 fr, flip = FALSE;
            if (k == 3) fr = 3 + ((arcFrames[i] >> 3) & 1);
            else if (k == 12) fr = 10;
            else if (k == 9) { const s16 a = arcFrames[i]; fr = 12 + ((state[i] != 1 || a >= 80) ? 3 : (a < 56) ? 0 : (a < 68) ? 1 : 2); }
            else if (k == 6) { fr = 9; flip = ((arcFrames[i] >> 3) & 1); }
            else if (k == 8) fr = 7 + ((angle[i] ^ 1) & 1);        // image selon la parité de l'angle
            else if (k == 7) fr = 5 + ((state[i] == 2) ? (arcFrames[i] / 6) & 1 : (state[i] == 4) ? ((arcFrames[i] + 5) / 6) & 1 : 0);    // image alternée toutes les 6 frames pendant les accélérations
            else
            {
                // animation de l'original : images 162, 163, 164, 163 retournée, 8 frames chacune pendant le virage
                const s16 a = (state[i] == 2) ? ((arcFrames[i] >> 3) & 3) : 0;
                fr = (a == 3) ? 1 : a; flip = (a == 3);
            }
            SPR_setVisibility(sp, VISIBLE); SPR_setHFlip(sp, flip); SPR_setFrame(sp, fr);
            SPR_setPosition(sp, enemies.x[i] - 8 + PF_XOFF, enemies.y[i] - 8);
        }
    }
    for (i = 0; i < NUM_BOMBS; i++)
    {
        if (bombOn[i] && !bombKillIn[i] && (c16 < maxSpr16))
        {
            SPR_setVisibility(sEnemy[c16], VISIBLE); SPR_setHFlip(sEnemy[c16], FALSE); SPR_setFrame(sEnemy[c16], GFR + 4);
            SPR_setPosition(sEnemy[c16++], bombX[i] - 8 + PF_XOFF, (bombFy[i] >> 8) - 8);
        }
    }
    for (i = c16; i < maxSpr16; i++) SPR_setVisibility(sEnemy[i], HIDDEN);
    if (stageNo >= 2) e2Draw();
    if (!bossReady && (stageNo == 1))
    {
        for (i = c4; i < MAX_MISSILE_SPR; i++) SPR_setVisibility(sEn4[i], HIDDEN);
        for (i = c10; i < MAX_SPR10; i++) SPR_setVisibility(sEn10[i], HIDDEN);
    }
    for (i = 0; i < MAX_EX; i++)
    {
        if (exTimer[i])
        {
            // petite boule (image 0) pendant 7 frames, puis 3 images de 8 frames
            SPR_setVisibility(sEx[i], VISIBLE);
            SPR_setFrame(sEx[i], (exTimer[i] > 24) ? 0 : 3 - ((exTimer[i] - 1) >> 3));
            SPR_setPosition(sEx[i], exX[i] - 8 + PF_XOFF, exY[i] - 7);
        }
        else SPR_setVisibility(sEx[i], HIDDEN);
    }
}
