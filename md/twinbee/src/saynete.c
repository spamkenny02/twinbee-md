// Saynete de l'attract : le garcon et TwinBee, puis le logo TwinBee (PCE 7105-7490).
// Fond fixe 256x224 en 3 palettes (PAL0..PAL2) ; TwinBee ondule par copie d'un petit bloc
// de tiles (2 poses) ; le logo (palette dediee PAL3) s'ecrit colonne par colonne comme sur PCE.
#include <genesis.h>
#include "saynete.h"
#include "sayn_pal.h"
#include "resources.h"
#include "mus.h"

#define SAYN_BOB_X     13                  // bloc anime (pixels 104..191)
#define SAYN_BOB_Y     12                  //                 (pixels  96..167)
#define SAYN_BOB_W     11
#define SAYN_BOB_H      9
#define SAYN_BOB_PERIOD 25                 // 25 images par pose (releve PCE : periode 50)

#define SAYN_LOGO_X    17                  // logo complet : x136..231, y168..215
#define SAYN_LOGO_Y    21
#define SAYN_LOG_IN    150                 // premiere lettre (PCE ~7255)
#define SAYN_LOG_END   215                 // mot complet, sans ombre ni badge (PCE 7320)
#define SAYN_LOG_FULL  240                 // logo complet + badge + ombre (PCE 7345)
#define SAYN_END       385                 // PCE 7490

static u16 baseA, baseB, baseL, baseW;

static void drawBob(const Image *img, u16 base)
{
    VDP_setTileMapEx(BG_B, img->tilemap, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, base),
                     SAYN_BOB_X, SAYN_BOB_Y, SAYN_BOB_X, SAYN_BOB_Y, SAYN_BOB_W, SAYN_BOB_H, CPU);
}

void SAYNETE_run(void)
{
    u16 f, pose = 0, shown = 0, full = FALSE;
    u16 prev = JOY_readJoypad(JOY_1);

    VDP_setWindowVPos(FALSE, 0);
    VDP_setScrollingMode(HSCROLL_PLANE, VSCROLL_PLANE);
    VDP_clearPlane(BG_A, TRUE);
    VDP_clearPlane(BG_B, TRUE);
    VDP_setHorizontalScroll(BG_A, 0); VDP_setVerticalScroll(BG_A, 0);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    PAL_setColors(0, palette_black, 64, CPU);

    baseA = TILE_USER_INDEX;
    baseB = baseA + sayn_a.tileset->numTile;
    baseL = baseB + sayn_b.tileset->numTile;
    baseW = baseL + sayn_logo.tileset->numTile;
    VDP_loadTileSet(sayn_a.tileset, baseA, DMA);
    VDP_loadTileSet(sayn_b.tileset, baseB, DMA);
    VDP_loadTileSet(sayn_logo.tileset, baseL, DMA);
    VDP_loadTileSet(sayn_word.tileset, baseW, DMA);
    VDP_drawImageEx(BG_B, &sayn_a, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, baseA), 0, 0, FALSE, TRUE);
    PAL_setColors(0, sayn_pal, 48, CPU);
    PAL_setColors(48, sayn_pal + 48, 16, CPU);

    MUS_saynCue();                                          // cue dedie de la saynete (PCE 7093-7434)

    for (f = 0; f < SAYN_END; f++)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        if ((joy & BUTTON_START) && !(prev & BUTTON_START)) break;
        prev = joy;

        {
            const u16 ph = (f / SAYN_BOB_PERIOD) & 1;
            if (ph != pose)
            {
                pose = ph;
                drawBob(ph ? &sayn_b : &sayn_a, ph ? baseB : baseA);
            }
            // Le mot apparait sans son ombre ni le badge (etat PCE 7320), puis le logo complet
            // (ombre + badge) est pose d'un coup a 7345.
            if (f >= SAYN_LOG_IN && !full)
            {
                u16 n = 1 + (u16) (((f - SAYN_LOG_IN) * 12) / (SAYN_LOG_END - SAYN_LOG_IN));
                if (n > 12) n = 12;
                if (n > shown)
                {
                    VDP_setTileMapEx(BG_B, sayn_word.tilemap, TILE_ATTR_FULL(PAL3, FALSE, FALSE, FALSE, baseW),
                                     SAYN_LOGO_X + shown, SAYN_LOGO_Y,
                                     shown, 0, n - shown, 6, CPU);
                    shown = n;
                }
            }
            if (f >= SAYN_LOG_FULL && !full)
            {
                VDP_setTileMapEx(BG_B, sayn_logo.tilemap, TILE_ATTR_FULL(PAL3, FALSE, FALSE, FALSE, baseL),
                                 SAYN_LOGO_X, SAYN_LOGO_Y, 0, 0, 12, 6, CPU);
                full = TRUE;
            }
        }
        SYS_doVBlankProcess();
    }
    MUS_saynCueStop();
    PAL_fadeOut(0, 63, 12, FALSE);
    VDP_clearPlane(BG_B, TRUE);
}
