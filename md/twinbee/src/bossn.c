#include "lzs.h"
#include "bossn.h"
#include "resources.h"
#include "stage.h"
#include "player.h"
#include "boss3_data.h"
#include "boss4_data.h"
#include "boss5_data.h"
#include "boss6_data.h"

#define BOSSN_MAXCLS    6
#define BOSSN_HP        400

typedef struct
{
    s16 start; u16 frames; u8 ncls; u8 palLine; u8 loop;
    const u16* colors; const u8* classMax; const u8* flux;
    const SpriteDefinition* defs[BOSSN_MAXCLS];
} BossNInfo;

static const BossNInfo info3 = { 15087, BOSS3_FRAMES, BOSS3_NCLASS, BOSS3_PALLINE, 0, boss3_colors, boss3_classMax, boss3_flux, BOSS3_DEFS };
static const BossNInfo info4 = { 10238, BOSS4_FRAMES, BOSS4_NCLASS, BOSS4_PALLINE, 0, boss4_colors, boss4_classMax, boss4_flux, BOSS4_DEFS };
static const BossNInfo info5 = { 9313, BOSS5_FRAMES, BOSS5_NCLASS, BOSS5_PALLINE, 0, boss5_colors, boss5_classMax, boss5_flux, BOSS5_DEFS };
static const BossNInfo info6 = { 8936, BOSS6_FRAMES, BOSS6_NCLASS, BOSS6_PALLINE, 1, boss6_colors, boss6_classMax, boss6_flux, BOSS6_DEFS };

static const BossNInfo* B;
static Sprite* sp[BOSSN_MAXCLS][20];
static s16 hp, cx, cy, bx0, bx1, by0, by1;
static bool active;

typedef struct { u8 cls, frame, flip; s16 x, y; } BP;
static BP cur[40];
static u8 curN;
#define rd lzs_rd
static s16 lastT;

static void decodeFrame(void)      // une frame du flux : n, masque (forme changée), pièces
{
    LZS_ensure();
    const u8 n = *rd++;
    const u8* mask = rd;
    u8 i;
    rd += (n + 7) >> 3;
    for (i = 0; i < n; i++)
    {
        BP* p = &cur[i];
        if (mask[i >> 3] & (1 << (i & 7)))
        {
            p->cls = rd[0] & 15; p->flip = rd[0] >> 4; p->frame = rd[1];
            p->x = (s16) ((rd[2] << 8) | rd[3]); p->y = (s16) ((rd[4] << 8) | rd[5]);
            rd += 6;
        }
        else { p->x += (s8) rd[0]; p->y += (s8) rd[1]; rd += 2; }
    }
    curN = n;
}

static const BossNInfo* infoOf(s16 stageNo) { return (stageNo == 3) ? &info3 : (stageNo == 4) ? &info4 : (stageNo == 5) ? &info5 : (stageNo == 6) ? &info6 : NULL; }
bool BOSSN_available(s16 stageNo) { return infoOf(stageNo) != NULL; }
s16 BOSSN_startFrame(s16 stageNo) { return infoOf(stageNo) ? infoOf(stageNo)->start : 32767; }
bool BOSSN_dead(void) { return active && (hp <= 0); }
void BOSSN_center(s16* x, s16* y) { *x = cx; *y = cy; }

void BOSSN_start(s16 stageNo)
{
    u16 c, k;
    B = infoOf(stageNo);
    if (B->palLine != 2) for (k = 0; k < 15; k++) PAL_setColor(B->palLine * 16 + 1 + k, B->colors[k]);
    for (c = B->ncls; c-- > 0; )        // grandes classes d'abord (la VRAM sprites est comptée au plus juste)
        for (k = 0; k < B->classMax[c]; k++)
        {
            sp[c][k] = SPR_addSpriteSafe(B->defs[c], 0, -64, TILE_ATTR(B->palLine, FALSE, FALSE, FALSE));
            if (sp[c][k]) { SPR_setDepth(sp[c][k], 5); SPR_setVisibility(sp[c][k], HIDDEN); }
            else {
#ifdef BOSSN_DEBUG
                VDP_drawText("NULLBN", 0, 4 + c);
#endif
            }
        }
    LZS_open(B->flux); lastT = -1; curN = 0;
    hp = BOSSN_HP; active = TRUE; cx = 120; cy = 60; bx0 = by0 = 0; bx1 = by1 = -1;
}

void BOSSN_stop(void)
{
    u16 c, k;
    if (!active) return;
    for (c = 0; c < B->ncls; c++) for (k = 0; k < B->classMax[c]; k++) if (sp[c][k]) { SPR_releaseSprite(sp[c][k]); sp[c][k] = NULL; }
    active = FALSE;
}

bool BOSSN_update(s16 t)
{
    u16 n[BOSSN_MAXCLS] = {0, 0, 0, 0, 0, 0};
    u16 c, k;
    if (!active) return FALSE;
    if (B->loop && (t >= (s16) B->frames)) { t = t % (s16) B->frames; if (t < lastT) { LZS_open(B->flux); lastT = -1; curN = 0; } }      // le dernier boss recommence sa trajectoire
    if (t >= (s16) B->frames) return FALSE;
    while (lastT < t) { decodeFrame(); lastT++; }
    bx0 = 999; bx1 = -999; by0 = 999; by1 = -999;
    for (k = 0; k < curN; k++)
    {
        const BP* pc = &cur[k];
        Sprite* s;
        if (n[pc->cls] >= B->classMax[pc->cls]) continue;
        s = sp[pc->cls][n[pc->cls]++];
        if (!s) continue;
        SPR_setVisibility(s, VISIBLE); SPR_setHFlip(s, pc->flip & 1); SPR_setVFlip(s, (pc->flip >> 1) & 1); SPR_setFrame(s, pc->frame);
        SPR_setPosition(s, pc->x + PF_XOFF, pc->y);
        if (pc->cls == B->ncls - 1)       // les plus grandes pièces forment le corps : boîte de collision
        {
            const s16 w = B->defs[pc->cls]->w, h = B->defs[pc->cls]->h;
            if (pc->x < bx0) bx0 = pc->x;
            if (pc->x + w > bx1) bx1 = pc->x + w;
            if (pc->y < by0) by0 = pc->y;
            if (pc->y + h > by1) by1 = pc->y + h;
        }
    }
    if (bx1 > bx0) { cx = (bx0 + bx1) >> 1; cy = (by0 + by1) >> 1; }
    for (c = 0; c < B->ncls; c++) for (k = n[c]; k < B->classMax[c]; k++) if (sp[c][k]) SPR_setVisibility(sp[c][k], HIDDEN);
    return TRUE;
}

bool BOSSN_hit(s16 sx, s16 sy, s16 hw, s16 hh)
{
    if (!active || (hp <= 0) || (bx1 <= bx0)) return FALSE;
    if ((sx + hw > bx0 + 8) && (sx - hw < bx1 - 8) && (sy + hh > by0 + 8) && (sy - hh < by1 - 8)) { hp--; return TRUE; }
    return FALSE;
}

bool BOSSN_contact(s16 px, s16 py)
{
    if (!active || (hp <= 0) || (bx1 <= bx0)) return FALSE;
    return (px > bx0 + 12) && (px < bx1 - 12) && (py > by0 + 12) && (py < by1 - 12);
}
