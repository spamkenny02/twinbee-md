// Carte de la princesse (attract, PCE 13380-13740) : page fixe 256x224 en 3 palettes,
// puis revelation du logo TwinBee avec les assets et les temps de la saynete
// (mot colonne par colonne a 150, mot complet a 215, logo complet a 240).
#include <genesis.h>
#include "card.h"
#include "card_pal.h"
#include "sayn_pal.h"
#include "resources.h"
#include "mus.h"

#define CARD_LOGO_X    17                  // logo complet : x136..231, y168..215
#define CARD_LOGO_Y    21
#define CARD_LOG_IN    150                 // premiere lettre (PCE ~13530)
#define CARD_LOG_END   215                 // mot complet, sans ombre ni badge (PCE ~13580)
#define CARD_LOG_FULL  240                 // logo complet + badge + ombre (PCE 13620)
#define CARD_END       370                 // PCE 13740
#define CARD_MUS_END   300                 // PCE 13680 : la musique du stage 2 s arrete pendant la carte

void CARD_run(void)
{
    u16 f, shown = 0, full = FALSE;
    u16 prev = JOY_readJoypad(JOY_1);
    u16 baseC, baseL, baseW;

    VDP_setWindowVPos(FALSE, 0);
    VDP_setScrollingMode(HSCROLL_PLANE, VSCROLL_PLANE);
    VDP_clearPlane(BG_A, TRUE);
    VDP_clearPlane(BG_B, TRUE);
    VDP_setHorizontalScroll(BG_A, 0); VDP_setVerticalScroll(BG_A, 0);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    PAL_setColors(0, palette_black, 64, CPU);

    baseC = TILE_USER_INDEX;
    baseL = baseC + card.tileset->numTile;
    baseW = baseL + sayn_logo.tileset->numTile;
    VDP_loadTileSet(card.tileset, baseC, DMA);
    VDP_loadTileSet(sayn_logo.tileset, baseL, DMA);
    VDP_loadTileSet(sayn_word.tileset, baseW, DMA);
    VDP_drawImageEx(BG_B, &card, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, baseC), 0, 0, FALSE, TRUE);
    PAL_setColors(0, card_pal, 48, CPU);
    PAL_setColors(48, sayn_pal + 48, 16, CPU);      // PAL3 : palette du logo TwinBee

    for (f = 0; f < CARD_END; f++)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        if ((joy & BUTTON_START) && !(prev & BUTTON_START)) break;
        prev = joy;

        if (f >= CARD_LOG_IN && !full)
        {
            u16 n = 1 + (u16) (((f - CARD_LOG_IN) * 12) / (CARD_LOG_END - CARD_LOG_IN));
            if (n > 12) n = 12;
            if (n > shown)
            {
                VDP_setTileMapEx(BG_B, sayn_word.tilemap, TILE_ATTR_FULL(PAL3, FALSE, FALSE, FALSE, baseW),
                                 CARD_LOGO_X + shown, CARD_LOGO_Y,
                                 shown, 0, n - shown, 6, CPU);
                shown = n;
            }
        }
        if (f >= CARD_LOG_FULL && !full)
        {
            VDP_setTileMapEx(BG_B, sayn_logo.tilemap, TILE_ATTR_FULL(PAL3, FALSE, FALSE, FALSE, baseL),
                             CARD_LOGO_X, CARD_LOGO_Y, 0, 0, 12, 6, CPU);
            full = TRUE;
        }
        if (f == CARD_MUS_END) MUS_stop();
        SYS_doVBlankProcess();
    }
    PAL_fadeOut(0, 63, 10, FALSE);
    VDP_clearPlane(BG_B, TRUE);
}
