// Écran titre : décor PCE (s1900, menu effacé) + menu en sprites (PAL0) comme sur PC Engine.
// Le curseur « > » est fixe ; la ligne sélectionnée clignote 8 images sur 8 (mesuré sur PCE).
// START sur OPTION ouvre l'ecran OPTION ; RUN en sort et relance l'attract (logo + vol), comme sur PCE.
#include <genesis.h>
#include "title.h"
#include "intro.h"
#include "option.h"
#include "mus.h"
#include "title_pal.h"
#include "title_menu.h"
#include "resources.h"

static Sprite* sCursor;
static Sprite* sMenu[3];
static bool musicDone;

bool titleWantsAttract;
#define TITLE_IDLE_FRAMES 640      // PCE : le titre reste ~630 images sans touche avant la démo d'attract

static void menuUpdate(u8 sel, bool on)
{
    u8 i;
    for (i = 0; i < 3; i++)
        SPR_setVisibility(sMenu[i], (i == sel && !on) ? HIDDEN : VISIBLE);
    SPR_setPosition(sCursor, TM_CURSOR_X, TM_CURSOR_Y + 16 * sel);
}

static void titleEnter(void)
{
    VDP_setWindowVPos(FALSE, 0);
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE); VDP_clearPlane(WINDOW, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_setBackgroundColor(0);
    VDP_drawImageEx(BG_B, &title_image, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, TILE_USER_INDEX), 0, 0, FALSE, TRUE);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    SYS_doVBlankProcess();
    PAL_setColors(0, title_pal, 64, CPU);
    // la musique du titre démarre pendant l'intro sur la PCE : ne pas la relancer au retour d'OPTION
    if (titleMusicOn) { titleMusicOn = FALSE; musicDone = TRUE; }
    else if (!musicDone) { MUS_playOnce(MUS_TITLE); musicDone = TRUE; }
    // le menu partage la palette 0 : indice 1 = noir, 2 = cyan clair (voir title_pal.h)
    sCursor = SPR_addSprite(&title_cursor, TM_CURSOR_X, TM_CURSOR_Y, TILE_ATTR(PAL0, FALSE, FALSE, FALSE));
    sMenu[0] = SPR_addSprite(&title_menu1, TM_MENU1_X, TM_MENU1_Y, TILE_ATTR(PAL0, FALSE, FALSE, FALSE));
    sMenu[1] = SPR_addSprite(&title_menu2, TM_MENU2_X, TM_MENU2_Y, TILE_ATTR(PAL0, FALSE, FALSE, FALSE));
    sMenu[2] = SPR_addSprite(&title_menu3, TM_MENU3_X, TM_MENU3_Y, TILE_ATTR(PAL0, FALSE, FALSE, FALSE));
}

static void titleLeave(void)
{
    // la PCE coupe la musique du titre des qu'on quitte l'ecran (mesure : silence en ~0,1 s
    // quand START lance la scene de la princesse) ; elle repart avec l'attract au retour d'OPTION
    MUS_stop();
    SPR_releaseSprite(sCursor);
    SPR_releaseSprite(sMenu[0]); SPR_releaseSprite(sMenu[1]); SPR_releaseSprite(sMenu[2]);
    SPR_update();
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
}

bool TITLE_run(void)
{
    titleWantsAttract = FALSE;
    while (TRUE)
    {
        u16 f = 0, prev = 0, prev2 = 0, idle = 0;
        u8 sel = 0;
        bool play = FALSE, done = FALSE;

        titleEnter();
        prev = JOY_readJoypad(JOY_1); prev2 = JOY_readJoypad(JOY_2);     // ignore une touche deja tenue
        while (!done)
        {
            const u16 joy = JOY_readJoypad(JOY_1), joy2 = JOY_readJoypad(JOY_2);
            const bool pressed = ((joy & BUTTON_START) && !(prev & BUTTON_START)) ||
                                 ((joy & BUTTON_A) && !(prev & BUTTON_A)) ||
                                 ((joy & BUTTON_C) && !(prev & BUTTON_C));
            if (pressed)
            {
                SFX_play(SFX_SELECT);                       // jingle de confirmation START (PCE 1902)
                play = (sel == 1);                          // 1 PLAYER / 2 PLAYERS ; OPTION = ecran option
                done = TRUE;
                break;
            }
            if ((joy2 & BUTTON_START) && !(prev2 & BUTTON_START)) { SFX_play(SFX_SELECT); play = TRUE; done = TRUE; break; }
            if ((joy & BUTTON_UP) && !(prev & BUTTON_UP) && sel > 0) sel--;
            if ((joy & BUTTON_DOWN) && !(prev & BUTTON_DOWN) && sel < 2) sel++;
            // inactivité : au bout de ~11 s la démo d'attract démarre, comme sur PC Engine
            if (joy & (BUTTON_UP | BUTTON_DOWN | BUTTON_LEFT | BUTTON_RIGHT | BUTTON_START | BUTTON_A | BUTTON_C)) idle = 0;
            else if (++idle >= TITLE_IDLE_FRAMES) { titleWantsAttract = TRUE; done = TRUE; break; }
            prev = joy; prev2 = joy2;
            menuUpdate(sel, ((f >> 3) & 1) == 0);
            f++;
            SPR_update();
            SYS_doVBlankProcess();
        }
        titleLeave();
        if (titleWantsAttract) return FALSE;               // inactivité : la démo prend la main
        // Sur PCE, RUN depuis OPTION relance l'attract depuis le debut (logo Konami, vol, puis titre) :
        // releve pceopt35 (sortie a l'image 2300 -> logo a 2520, nuages 2880, titre 3660).
        if (!play && sel == 2) { OPTION_run(); INTRO_run(); continue; }
        return play;
    }
}
