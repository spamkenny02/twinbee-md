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
    // PCE : image 12 à 54, un trait bleu (y 10) s'étire de gauche à droite (8 px / image) avec un éclat qui rétrécit à sa pointe ;
    // puis il descend de 2 px / image (image 54 à 160) et révèle le contour
    VDP_setVerticalScroll(BG_A, -8);
    PAL_setPalette(PAL2, intro_spark.palette->data, CPU);
    for (i = 0; i < 32; i++) VDP_setTileMapXY(BG_A, TILE_ATTR_FULL(PAL1, FALSE, FALSE, FALSE, 0), i, 0);       // le trait n'apparaît qu'au fil de l'étirement
    if (wait(12, &prev)) return TRUE;
    {
        Sprite* sp = SPR_addSprite(&intro_spark, 0, 0, TILE_ATTR(PAL2, FALSE, FALSE, FALSE));
        u16 f;
        for (f = 12; f <= 54; f++)
        {
            const s16 tip = (f - 11) * 8 > 255 ? 255 : (f - 11) * 8;
            for (i = 0; i <= (tip >> 3); i++) VDP_setTileMapXY(BG_A, TILE_ATTR_FULL(PAL1, FALSE, FALSE, FALSE, TILE_USER_INDEX + intro_kout.tileset->numTile), i, 0);
            if (sp)
            {
                if (tip >= 255) SPR_setVisibility(sp, HIDDEN);
                else { SPR_setFrame(sp, (f < 26) ? 0 : (f < 36) ? 1 : 2); SPR_setPosition(sp, tip - 6 - 8, 3); }
            }
            SPR_update();
            if (wait(1, &prev)) { if (sp) SPR_releaseSprite(sp); SPR_update(); return TRUE; }
        }
        if (sp) SPR_releaseSprite(sp);
        SPR_update();
    }
    for (y = 8; y < 224; y += 2)                                    // balayage : ~2 px par image
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
    if (wait(253, &prev)) return TRUE;                              // le logo reste affiché jusqu'à l'image 490 de la PCE, puis fondu au noir (490-526)
    PAL_fadeOut(0, 15, 36, FALSE);
    return FALSE;
}

bool titleMusicOn;

void INTRO_run(void)
{
    VDP_setWindowVPos(FALSE, 0);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    if (logo()) goto out;
    INTRO_replay();
out:
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
}
