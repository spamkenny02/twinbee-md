// Écran titre : image de la PC Engine (dernière image de l'intro), « PUSH START » clignotant (ajout MD)
#include <genesis.h>
#include "title.h"
#include "title_pal.h"
#include "resources.h"

void TITLE_run(void)
{
    u16 f = 0, prev = 0xFFFF;
    VDP_setWindowVPos(FALSE, 0);
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE); VDP_clearPlane(WINDOW, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_setBackgroundColor(0);
    VDP_drawImageEx(BG_B, &title_image, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, TILE_USER_INDEX), 0, 0, FALSE, TRUE);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    VDP_setTextPlane(BG_A); VDP_setTextPalette(PAL0);
    SYS_doVBlankProcess();
    PAL_setColors(0, title_pal, 64, CPU);
    while (TRUE)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        if ((joy & BUTTON_START) && !(prev & BUTTON_START)) break;
        prev = joy;
        if ((f & 31) == 0) VDP_drawText(((f >> 5) & 1) ? "                " : "PUSH START BUTTON", 11, 24);
        f++;
        SYS_doVBlankProcess();
    }
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
}
