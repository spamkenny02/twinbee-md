// Intro : logo Konami, ciel, étoiles (images PCE quantifiées 16 couleurs, défilement vertical)
#include <genesis.h>
#include "intro.h"
#include "resources.h"

static bool scene(const Image *img, u16 frames, s16 vs, bool fadeIn)
{
    u16 prev = JOY_readJoypad(JOY_1);
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_drawImageEx(BG_B, img, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, TILE_USER_INDEX), 0, 0, FALSE, TRUE);
    VDP_setVerticalScroll(BG_B, 0);
    SYS_doVBlankProcess();
    if (fadeIn) PAL_fadeIn(0, 15, img->palette->data, 20, FALSE);
    else PAL_setPalette(PAL0, img->palette->data, CPU);
    VDP_setBackgroundColor(0);
    for (u16 f = 0; f < frames; f++)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        if ((joy & BUTTON_START) && !(prev & BUTTON_START)) return TRUE;
        prev = joy;
        if (vs) VDP_setVerticalScroll(BG_B, (s16)((f * vs) >> 3));
        SYS_doVBlankProcess();
    }
    return FALSE;
}

void INTRO_run(void)
{
    VDP_setWindowVPos(FALSE, 0);
    VDP_setHorizontalScroll(BG_B, 0);
    if (scene(&intro_k1, 70, 0, TRUE)) goto out;
    if (scene(&intro_k2, 110, 0, FALSE)) goto out;
    if (scene(&intro_sky, 130, 0, TRUE)) goto out;
    if (scene(&intro_dusk, 130, 0, TRUE)) goto out;
    if (scene(&intro_star, 160, 0, TRUE)) goto out;
out:
    VDP_setVerticalScroll(BG_B, 0);
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
}
