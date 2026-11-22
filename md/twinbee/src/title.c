// Écran titre : image de la PC Engine (dernière image de l'intro), « PUSH START » clignotant (ajout MD)
#include <genesis.h>
#include "title.h"
#include "intro.h"
#include "mus.h"
#include "title_pal.h"
#include "resources.h"

bool TITLE_run(void)
{
    u16 f = 0, prev = 0xFFFF, prev2 = 0xFFFF;
    u8 sel = 0;
    VDP_setWindowVPos(FALSE, 0);
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE); VDP_clearPlane(WINDOW, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_setBackgroundColor(0);
    VDP_drawImageEx(BG_B, &title_image, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, TILE_USER_INDEX), 0, 0, FALSE, TRUE);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    VDP_setTextPlane(BG_A); VDP_setTextPalette(PAL0);
    SYS_doVBlankProcess();
    PAL_setColors(0, title_pal, 64, CPU);
    if (titleMusicOn) titleMusicOn = FALSE; else MUS_play(MUS_TITLE);
    while (TRUE)
    {
        const u16 joy = JOY_readJoypad(JOY_1), joy2 = JOY_readJoypad(JOY_2);
        if (((joy & BUTTON_START) && !(prev & BUTTON_START)) || ((joy & BUTTON_A) && !(prev & BUTTON_A)) || ((joy & BUTTON_C) && !(prev & BUTTON_C))) break;
        if ((joy2 & BUTTON_START) && !(prev2 & BUTTON_START)) { sel = 1; break; }
        if (((joy & BUTTON_UP) && !(prev & BUTTON_UP)) || ((joy & BUTTON_DOWN) && !(prev & BUTTON_DOWN))) sel ^= 1;
        prev = joy; prev2 = joy2;
        {   // l'entrée choisie clignote (le curseur « > » se perdrait dans les nuages)
            const bool on = (f & 16) == 0;
            VDP_drawText((sel == 0 && !on) ? "        " : "1 PLAYER", 22, 15);
            VDP_drawText((sel == 1 && !on) ? "         " : "2 PLAYERS", 22, 17);
        }
        f++;
        SYS_doVBlankProcess();
    }
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
    return sel != 0;
}
