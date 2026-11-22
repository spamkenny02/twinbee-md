// Intro : logo Konami (images fixes), puis vol de TwinBee dans les nuages qui défilent, le ciel passe du jour à la nuit étoilée
// (fond en dégradé de CRAM, nuages/étoiles/abeille en sprites : tout est animé image par image).
#include <genesis.h>
#include "intro.h"
#include "resources.h"

#define NCLOUD 6
#define NSTAR  22
#define SKY_FRAMES 520

// logo Konami (original) : une ligne bleue descend et dessine le contour, le contour se remplit de couleurs,
// puis le fond passe du noir au blanc par paliers. Timings relevés sur dumps/kon (PCE, images 20-260).
static void logoRows(const Image *img, u16 from, u16 to)
{
    u16 r;
    for (r = from; r < to; r++)
        VDP_setTileMapEx(BG_B, img->tilemap, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, TILE_USER_INDEX), 0, r, 0, r, 32, 1, CPU);
}

static bool wait(u16 n, u16 *prev)
{
    while (n--)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        if ((joy & BUTTON_START) && !(*prev & BUTTON_START)) return TRUE;
        *prev = joy;
        SYS_doVBlankProcess();
    }
    return FALSE;
}

static bool logo(void)
{
    static const u32 lineTile[8] = { 0, 0, 0x11111111, 0x11111111, 0x11111111, 0, 0, 0 };
    u16 prev = JOY_readJoypad(JOY_1), y, shown = 0, i;
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_loadTileSet(intro_kout.tileset, TILE_USER_INDEX, DMA);
    VDP_loadTileData(lineTile, TILE_USER_INDEX + intro_kout.tileset->numTile, 1, DMA);
    PAL_setPalette(PAL0, intro_kout.palette->data, CPU);
    PAL_setColor(16 + 1, 0x0E64);                                   // ligne de balayage : bleu clair (PAL1 indice 1)
    for (i = 0; i < 32; i++) VDP_setTileMapXY(BG_A, TILE_ATTR_FULL(PAL1, FALSE, FALSE, FALSE, TILE_USER_INDEX + intro_kout.tileset->numTile), i, 0);
    VDP_setVerticalScroll(BG_A, 0);
    if (wait(20, &prev)) return TRUE;
    for (y = 0; y < 224; y += 2)                                    // balayage : ~2 px par image
    {
        const u16 rows = (y >> 3) + 1;
        if (rows > shown) { logoRows(&intro_kout, shown, rows > 28 ? 28 : rows); shown = rows; }
        VDP_setVerticalScroll(BG_A, -(s16) y);
        if (wait(1, &prev)) return TRUE;
    }
    VDP_clearPlane(BG_A, TRUE); VDP_setVerticalScroll(BG_A, 0);
    if (wait(30, &prev)) return TRUE;
    // remplissage couleur : même position, palette en fondu depuis le noir
    VDP_loadTileSet(intro_kcol.tileset, TILE_USER_INDEX, DMA);
    logoRows(&intro_kcol, 0, 28);
    PAL_setColors(0, palette_black, 16, CPU);
    PAL_fadeIn(0, 15, intro_kcol.palette->data, 16, FALSE);
    if (wait(12, &prev)) return TRUE;
    // fond noir -> blanc par paliers (indice 0 de la palette)
    for (i = 1; i <= 7; i++)
    {
        PAL_setColor(0, i * 0x222);
        if (wait(5, &prev)) return TRUE;
    }
    return wait(70, &prev);
}

static u16 mix(u16 a, u16 b, u16 t, u16 n)       // mélange de deux couleurs MD (0000BBB0GGG0RRR0) à t/n
{
    u16 r = 0, k;
    for (k = 0; k < 3; k++)
    {
        const s16 ca = (a >> (1 + 4 * k)) & 7, cb = (b >> (1 + 4 * k)) & 7;
        r |= (u16)(ca + ((cb - ca) * (s16) t) / (s16) n) << (1 + 4 * k);
    }
    return r;
}

static bool sky(void)
{
    static const u16 DAY = 0x0EC0 | 0x0000, DUSK = 0x0E62, NIGHT = 0x0000;      // cyan, bleu crépuscule, noir
    Sprite *cl[NCLOUD], *st[NSTAR], *bee;
    s16 cx[NCLOUD], cy[NCLOUD], sx[NSTAR], sy[NSTAR];
    u16 prev = JOY_readJoypad(JOY_1), seed = 12345, i, f;
    bool skipped = FALSE;

    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    PAL_setPalette(PAL1, intro_cloud.palette->data, CPU);
    PAL_setPalette(PAL2, intro_bee.palette->data, CPU);
    PAL_setPalette(PAL3, intro_star.palette->data, CPU);
    for (i = 0; i < NCLOUD; i++)
    {
        seed = seed * 25173 + 13849; cx[i] = (seed >> 3) % 224; cy[i] = i * 44 - 40;
        cl[i] = SPR_addSprite(&intro_cloud, cx[i], cy[i], TILE_ATTR(PAL1, FALSE, FALSE, FALSE));
    }
    for (i = 0; i < NSTAR; i++)
    {
        seed = seed * 25173 + 13849; sx[i] = (seed >> 4) % 248; seed = seed * 25173 + 13849; sy[i] = (seed >> 4) % 224;
        st[i] = SPR_addSprite(&intro_star, 320, -32, TILE_ATTR(PAL3, FALSE, FALSE, FALSE));
        if (st[i]) SPR_setFrame(st[i], i % 3);
    }
    bee = SPR_addSprite(&intro_bee, 112, 300, TILE_ATTR(PAL2, FALSE, FALSE, FALSE));
    if (bee) SPR_setDepth(bee, SPR_MIN_DEPTH);
    for (f = 0; f < SKY_FRAMES; f++)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        u16 bg;
        if ((joy & BUTTON_START) && !(prev & BUTTON_START)) { skipped = TRUE; break; }
        prev = joy;
        // fond : fondu d'entrée, jour -> crépuscule (170..250) -> nuit (330..410)
        if (f < 24) bg = mix(NIGHT, DAY, f, 24);
        else if (f < 170) bg = DAY;
        else if (f < 250) bg = mix(DAY, DUSK, f - 170, 80);
        else if (f < 330) bg = DUSK;
        else bg = (f < 410) ? mix(DUSK, NIGHT, f - 330, 80) : NIGHT;
        PAL_setColor(0, bg);
        if (f == 0) { PAL_setColor(0, NIGHT); }
        // nuages : 1 px par image vers le bas, recyclés tant que le jour dure, puis laissés sortir
        for (i = 0; i < NCLOUD; i++)
        {
            cy[i] += 1;
            if (cy[i] > 224) { if (f < 230) { seed = seed * 25173 + 13849; cx[i] = (seed >> 3) % 224; cy[i] = -32; } else cy[i] = 300; }
            if (cl[i]) SPR_setPosition(cl[i], cx[i], cy[i]);
        }
        // étoiles : apparaissent avec la nuit, scintillent toutes les 16 images, dérivent vers le bas (1 px / 2 images)
        for (i = 0; i < NSTAR; i++)
        {
            if (!st[i]) continue;
            if (f < 250 + i * 3) { SPR_setPosition(st[i], 320, -32); continue; }
            if (!(f & 1)) { sy[i]++; if (sy[i] > 224) sy[i] = -8; }
            SPR_setFrame(st[i], ((f >> 4) + i) % 3);
            SPR_setPosition(st[i], sx[i], sy[i]);
        }
        // TwinBee : monte de bas d'écran en 70 images puis flotte en 8 mouvant
        {
            s16 bx = 112 + (sinFix16((f * 6) & 1023) >> 5) * 1, by;
            if (f < 70) by = 230 - (f * 110) / 70; else by = 120;
            by += (sinFix16((f * 9) & 1023) >> 6);
            if (bee) SPR_setPosition(bee, bx, by);
        }
        SPR_update();
        SYS_doVBlankProcess();
    }
    for (i = 0; i < NCLOUD; i++) if (cl[i]) SPR_releaseSprite(cl[i]);
    for (i = 0; i < NSTAR; i++) if (st[i]) SPR_releaseSprite(st[i]);
    if (bee) SPR_releaseSprite(bee);
    SPR_update();
    return skipped;
}

void INTRO_run(void)
{
    VDP_setWindowVPos(FALSE, 0);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    if (logo()) goto out;
    sky();
out:
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
}
