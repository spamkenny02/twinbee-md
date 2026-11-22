// Intro : logo Konami (images fixes), puis vol de TwinBee dans les nuages qui défilent, le ciel passe du jour à la nuit étoilée
// (fond en dégradé de CRAM, nuages/étoiles/abeille en sprites : tout est animé image par image).
#include <genesis.h>
#include "intro.h"
#include "mus.h"
#include "resources.h"
#include "konami_data.h"

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

static u32 kt0;
static bool waitTo(u16 target, u16 *prev)                          // attend l'image logo "target" (temps reel : vtimer), comme sur la PCE
{
    while ((u16) (vtimer - kt0) < target)
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
    static const u32 blackTile[8] = { 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF };
    const u16 LT = TILE_USER_INDEX + 400;                           // tuiles du trait : 0-7 = profil 3 lignes (largeur 1-8), 8 = 5 lignes, 9 = 7 lignes, 10 = 8 lignes, 11 = noir opaque
    u16 prev = JOY_readJoypad(JOY_1), shown = 0, i, f;
    Sprite* sp;
    VDP_setPlaneSize(64, 64, TRUE);
    kt0 = vtimer;
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_loadTileSet(intro_kout.tileset, TILE_USER_INDEX, DMA);
    VDP_loadTileData(konl_tiles, LT, 11, DMA);
    VDP_loadTileData(blackTile, LT + 11, 1, DMA);
    PAL_setPalette(PAL0, intro_kout.palette->data, CPU);
    PAL_setColors(48, konl_pal, 9, CPU);                            // PAL3 : couleurs du trait releves sur la PCE
    VDP_setVerticalScroll(BG_A, -5);                                // les profils sont alignes sur y = 5..12
    PAL_setPalette(PAL2, intro_spark.palette->data, CPU);
    // PCE : image 12 a 54, un trait bleu (y 10-12) s'etire de gauche a droite (8 px / image) avec un eclat a sa pointe, puis il s'epaissit vers le haut
    // (5, 7, 8 lignes) ; des l'image 55 il descend de 2 px / image en revelant le contour (opaque dessous)
    if (waitTo(12, &prev)) return TRUE;
    sp = SPR_addSprite(&intro_spark, 0, 0, TILE_ATTR(PAL2, FALSE, FALSE, FALSE));
    for (f = 12; f < 55; f++)
    {
        const u16 pt = (f < 47) ? 0 : (f < 51) ? 8 : 9;
        if (pt) { for (i = 0; i < 32; i++) VDP_setTileMapXY(BG_A, TILE_ATTR_FULL(PAL3, FALSE, FALSE, FALSE, LT + pt), i, 0); }
        else for (i = 0; i < kon_spk_x0[f - 12]; i++) VDP_setTileMapXY(BG_A, TILE_ATTR_FULL(PAL3, FALSE, FALSE, FALSE, LT + 7), i, 0);
        if (sp)
        {
            if (pt) SPR_setVisibility(sp, HIDDEN);                  // l'eclat (fenetre 48x24 relevee sur la PCE) accompagne la pointe du trait
            else { SPR_setFrame(sp, f - 12); SPR_setPosition(sp, kon_spk_x0[f - 12] * 8, 0); }
        }
        SPR_update();
        if (waitTo(f + 1, &prev)) { if (sp) SPR_releaseSprite(sp); SPR_update(); return TRUE; }
    }
    if (sp) SPR_releaseSprite(sp);
    SPR_update();
    {
        for (i = 0; i < 32; i++) VDP_setTileMapXY(BG_A, TILE_ATTR_FULL(PAL3, FALSE, FALSE, FALSE, LT + 10), i, 0);
        VDP_fillTileMapRect(BG_A, TILE_ATTR_FULL(PAL3, FALSE, FALSE, FALSE, LT + 11), 0, 1, 32, 40);
        for (f = 55; ; f++)
        {
            const s16 top = (f < 57) ? 5 : 7 + 2 * (f - 57);
            const u16 rows = ((top + 7) >> 3) + 1;
            if (top >= 224) break;
            if (rows > shown) { logoRows(&intro_kout, shown, rows > 28 ? 28 : rows); shown = rows; }
            VDP_setVerticalScroll(BG_A, -top);
            if (waitTo(f + 1, &prev)) return TRUE;
        }
    }
    VDP_clearPlane(BG_A, TRUE); VDP_setVerticalScroll(BG_A, 0);
    if (waitTo(170, &prev)) return TRUE;
    SFX_play(SFX_KONAMI);                                           // PCE : jingle de boot (son 0B) lance a l'image 170                                // PCE : le logo en couleur apparait d'un coup a l'image 170
    {   // image 170 : BG de la PCE tel quel (4 palettes), puis rejeu exact des changements de palette (scintillement, fond blanc)
        u16 x, y, f, k = 0;
        VDP_loadTileData(kon_tiles, TILE_USER_INDEX, KON_NT, DMA);
        for (y = 0; y < KON_H; y++)
            for (x = 0; x < KON_W; x++)
            {
                const u16 m = kon_map[y * KON_W + x];
                VDP_setTileMapXY(BG_B, m ? ((m & 0xE000) | (TILE_USER_INDEX + (m & 0x1FFF))) : 0, KON_C0 + x, KON_R0 - 2 + y);
            }
        VDP_setVerticalScroll(BG_B, -4);
        PAL_setColors(0, kon_pal, 64, CPU);
        for (f = 1; f < 80; f++)
        {
            if (waitTo(170 + f, &prev)) return TRUE;
            while (k < KON_NTL && kon_tl[k][0] == f) { PAL_setColor(kon_tl[k][1], kon_tl[k][2]); k++; }
        }
    }
    if (waitTo(490, &prev)) return TRUE;                              // maintien jusqu'a l'image 490, puis fondu au noir (490-526)
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
    VDP_setPlaneSize(64, 32, TRUE);
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
}
