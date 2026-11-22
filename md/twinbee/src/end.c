// Fin du jeu (après le boss du stage 6) rejouée depuis la PCE : fond défilant en 3 cartes (tuiles réduites par tools/mkend.py),
// chronologie de palette interpolée (fondus), défilement par segments mesurés sur dumps/end6b (dumps tous les 20 frames).
#include <genesis.h>
#include "end.h"
#include "mus.h"
#include "end_data.h"
#include "resources.h"
#include "end_spr.h"
#include "end_sprd.h"

// sprites rejoués (flux de tools/mkendspr.py : n, masque, pièces ; forme inchangée = dx, dy)
typedef struct { u8 ncls; u16 frames; s32 start; u8 ng; const u8* cpal; const u16* colors; const u8* classMax; const u8* flux; const SpriteDefinition* defs[8]; } SprInfo;
static const u8 cpalA[] = ENDS_A_CPAL, cpalB[] = ENDS_B_CPAL, cpalC[] = ENDS_C_CPAL;
static const SprInfo sinfo[3] = {
    { ENDS_A_NCLASS, ENDS_A_FRAMES, ENDS_A_START, ENDS_A_NG, cpalA, ends_a_colors, ends_a_classMax, ends_a_flux, ENDS_A_DEFS },
    { ENDS_B_NCLASS, ENDS_B_FRAMES, ENDS_B_START, ENDS_B_NG, cpalB, ends_b_colors, ends_b_classMax, ends_b_flux, ENDS_B_DEFS },
    { ENDS_C_NCLASS, ENDS_C_FRAMES, ENDS_C_START, ENDS_C_NG, cpalC, ends_c_colors, ends_c_classMax, ends_c_flux, ENDS_C_DEFS },
};
typedef struct { u8 cls, flip; u16 frame; s16 x, y; } EP;
static EP ecur[64];
static u8 ecurN;
static const u8* erd;
static s32 elast;
static Sprite* esp[8][48];
static const SprInfo* SI;
static s16 edep[8][48];

static void sprStart(const SprInfo* si)
{
    u16 c, k;
    SI = si;
    for (c = 0; c < si->ng; c++) PAL_setColors((4 - si->ng + c) * 16 + 1, si->colors + c * 15, 15, CPU);
    for (c = si->ncls; c-- > 0; )
        for (k = 0; k < si->classMax[c]; k++)
        {
            esp[c][k] = SPR_addSpriteSafe(si->defs[c], 0, -64, TILE_ATTR(si->cpal[c], FALSE, FALSE, FALSE));
            if (esp[c][k]) { SPR_setVisibility(esp[c][k], HIDDEN); edep[c][k] = 0x7FFF; }
        }
    erd = si->flux; elast = -1; ecurN = 0;
}

static void sprStop(void)
{
    u16 c, k;
    if (!SI) return;
    for (c = 0; c < SI->ncls; c++) for (k = 0; k < SI->classMax[c]; k++) if (esp[c][k]) { SPR_releaseSprite(esp[c][k]); esp[c][k] = NULL; }
    SI = NULL;
}

static void sprFrame(void)
{
    const u8 n = *erd++;
    const u8* mask = erd;
    u8 i;
    erd += (n + 7) >> 3;
    for (i = 0; i < n; i++)
    {
        EP* p = &ecur[i];
        if (mask[i >> 3] & (1 << (i & 7)))
        {
            p->cls = erd[0] & 15; p->flip = erd[0] >> 4; p->frame = erd[1] | (erd[2] << 8);
            p->x = (s16) ((erd[3] << 8) | erd[4]); p->y = (s16) ((erd[5] << 8) | erd[6]);
            erd += 7;
        }
        else { p->x += (s8) erd[0]; p->y += (s8) erd[1]; erd += 2; }
    }
    ecurN = n;
}

static void sprUpdate(s32 f)
{
    u16 n[8] = {0, 0, 0, 0, 0, 0, 0, 0};
    u16 c, k;
    s32 t = f - SI->start;
    if (!SI || (t < 0) || (t >= (s32) SI->frames)) return;
    while (elast < t) { sprFrame(); elast++; }
    for (k = 0; k < ecurN; k++)
    {
        const EP* pc = &ecur[k];
        Sprite* s;
        if (n[pc->cls] >= SI->classMax[pc->cls]) continue;
        const u16 sl = n[pc->cls]++;
        s = esp[pc->cls][sl];
        if (!s) continue;
        if (edep[pc->cls][sl] != (s16) k) { edep[pc->cls][sl] = k; SPR_setDepth(s, k); }      // priorité = ordre SAT (le plus bas devant)
        SPR_setVisibility(s, VISIBLE); SPR_setHFlip(s, pc->flip & 1); SPR_setVFlip(s, (pc->flip >> 1) & 1); SPR_setFrame(s, pc->frame);
        SPR_setPosition(s, pc->x, pc->y);
    }
    for (c = 0; c < SI->ncls; c++) for (k = n[c]; k < SI->classMax[c]; k++) if (esp[c][k]) SPR_setVisibility(esp[c][k], HIDDEN);
}

#define F_A0 126340
#define F_B0 128780
#define F_C0 133380
#define F_END 136040

typedef struct { const u32* tiles; const u16* const* maps; const s32* mapf; const u16* pal; u16 ntiles, steps, npal, nmaps; s32 step0; } Scene;
static const u16* const mapsA[] = { end_a_map0, end_a_map1, end_a_map2, end_a_map3 };
static const u16* const mapsB[] = { end_b_map0 };
static const u16* const mapsC[] = { end_c_map0 };
static const Scene scenes[3] = {
    { end_a_tiles, mapsA, end_a_mapf, end_a_pal, END_A_TILES, END_A_STEPS, END_A_NPAL, END_A_NMAPS, END_A_STEP0 },
    { end_b_tiles, mapsB, end_b_mapf, end_b_pal, END_B_TILES, END_B_STEPS, END_B_NPAL, END_B_NMAPS, END_B_STEP0 },
    { end_c_tiles, mapsC, end_c_mapf, end_c_pal, END_C_TILES, END_C_STEPS, END_C_NPAL, END_C_NMAPS, END_C_STEP0 },
};
static s16 curMap;

static u16 lerp3(u16 a, u16 b, s16 n)      // n/20 entre deux couleurs MD (3 bits par canal)
{
    const s16 r = (((a >> 1) & 7) * (20 - n) + ((b >> 1) & 7) * n + 10) / 20;
    const s16 g = (((a >> 5) & 7) * (20 - n) + ((b >> 5) & 7) * n + 10) / 20;
    const s16 bl = (((a >> 9) & 7) * (20 - n) + ((b >> 9) & 7) * n + 10) / 20;
    return (bl << 9) | (g << 5) | (r << 1);
}

static void setPalette(const Scene* sc, s32 f)
{
    s32 t;
    s16 st, frac, k, n = sc->npal * 16;
    u16 buf[64];
    t = f - sc->step0;
    if (t < 0) t = 0;
    st = t / 20; frac = t % 20;
    if (st >= sc->steps - 1) { st = sc->steps - 1; frac = 0; }
    for (k = 0; k < n; k++)
    {
        const u16 a = sc->pal[st * n + k];
        buf[k] = frac ? lerp3(a, sc->pal[(st + 1) * n + k], frac) : a;
    }
    PAL_setColors(0, buf, n, DMA);
}

static void loadScene(const Scene* sc)
{
    VDP_clearPlane(BG_B, TRUE);
    VDP_loadTileData(sc->tiles, TILE_USER_INDEX, sc->ntiles, CPU);
    VDP_setTileMapDataRectEx(BG_B, sc->maps[0], TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, TILE_USER_INDEX), 0, 0, 64, 64, 64, CPU);
    curMap = 0;
}

static void updateMap(const Scene* sc, s32 f)       // la carte change à des frames précises (visage de la princesse dessiné dans le fond)
{
    s16 m = 0, k;
    for (k = 0; k < sc->nmaps; k++) if (f >= sc->mapf[k]) m = k;
    if (m != curMap)
    {
        VDP_setTileMapDataRectEx(BG_B, sc->maps[m], TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, TILE_USER_INDEX), 0, 0, 64, 64, 64, CPU);
        curMap = m;
    }
}

// défilement vertical / horizontal (registres BYR / BXR de la PCE) à la frame PCE f
static s16 splitRow = 224;      // lignes < splitRow : BXR 0 ; au-delà : BXR 256 (dialogue)
static void scroll(s32 f, s16* bx, s16* by)
{
    *bx = 0; splitRow = 224;
    if (f < F_B0)
    {
        if (f < 126400) *by = 0;
        else if (f < 127780)
        {
            if (f < 126440) splitRow = 224; else if (f < 126540) splitRow = 80; else if (f < 127480) splitRow = 72;
            else splitRow = 96 + (s16) (((f - 127480) * 9) / 20);
            if (splitRow > 224) splitRow = 224;
            if (f < 126500) *by = 196;
            else if (f < 127500) *by = 256;
            else *by = 250 - (f - 127500) / 4;
        }
        else if (f < 128180) *by = 180 - (f - 127780) / 4;
        else if (f < 128509) *by = 80;
        else *by = (80 - (f - 128509)) & 511;
    }
    else if (f < F_C0)
    {
        if (f <= 133373) *by = (65 - (f - F_B0)) & 511; else *by = 80;
    }
    else
    {
        if (f < 133501) *by = 80;
        else if (f < 133773) *by = 80 + (f - 133501);
        else *by = 352;
    }
}

void ENDING_run(void)
{
    s32 f = F_A0 - 60;                // un peu de noir avant
    u32 t0;
    s16 sc = -1, prevSc, bx, by;
    u16 prev = JOY_readJoypad(JOY_1);
    SPR_reset(); SPR_update();
    VDP_setPlaneSize(64, 64, TRUE);
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE); VDP_clearPlane(WINDOW, TRUE);
    VDP_setWindowVPos(FALSE, 0);
    VDP_setScrollingMode(HSCROLL_LINE, VSCROLL_PLANE);
    VDP_setHorizontalScroll(BG_A, 0); VDP_setVerticalScroll(BG_A, 0);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_setBackgroundColor(0);
    SYS_doVBlankProcess();
    t0 = vtimer;
    while (f < F_END)
    {
        f = F_A0 - 60 + (s32) (vtimer - t0);          // temps réel : les transferts de sprites peuvent ralentir la boucle
        if (f >= F_END) break;
        const u16 joy = JOY_readJoypad(JOY_1);
        prevSc = sc;
        if (f < F_A0) { SYS_doVBlankProcess(); continue; }
        sc = (f >= F_C0) ? 2 : (f >= F_B0) ? 1 : 0;
        if (sc != prevSc)
        {
            PAL_setColors(0, palette_black, 64, CPU);
            sprStop(); SPR_update();
            SYS_doVBlankProcess();
            loadScene(&scenes[sc]);
            sprStart(&sinfo[sc]);
        }
        updateMap(&scenes[sc], f);
        scroll(f, &bx, &by);
        {
            s16 y; static u16 hs[224];
            for (y = 0; y < 224; y++) hs[y] = (y >= splitRow && f < 127780) ? (u16) -256 : 0;
            if (f >= 127780) for (y = 0; y < 224; y++) hs[y] = (u16) -bx;
            VDP_setHorizontalScrollLine(BG_B, 0, (s16*) hs, 224, DMA_QUEUE);
        }
        VDP_setVerticalScroll(BG_B, (by + 12) & 511);       // ligne 0 affichée = BYR + 12 (mesuré par comparaison avec les captures PCE)
        setPalette(&scenes[sc], f);
        sprUpdate(f);
        SPR_update();
        if ((joy & ~prev & BUTTON_START)) break;
        prev = joy;
        SYS_doVBlankProcess();
    }
    sprStop(); SPR_reset(); SPR_update();
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
    VDP_setPlaneSize(64, 32, TRUE);
    VDP_setScrollingMode(HSCROLL_PLANE, VSCROLL_PLANE);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
}
