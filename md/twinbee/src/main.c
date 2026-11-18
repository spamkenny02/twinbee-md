// Detana!! TwinBee - portage Mega Drive (SGDK)
// Jalon 6 : + toutes les vagues d'ennemis de type 5, contact, mort et réapparition, vies
// Manette : croix = déplacement, B = tir (tenir pour charger), C = jeu accéléré x4 (debug), A = invincible (debug), START = recommencer
#include <genesis.h>
#include "player.h"
#include "stage.h"
#include "title.h"

u16 gameFrame;                            // compteur de frames de jeu (lu par les tests)

#ifndef START_STAGE
#define START_STAGE 1
#endif

static void start(void)
{
    SPR_end();
    SPR_initEx((stageNo >= 2) ? 640 : 696);        // VRAM sprites : le décor du stage 2 est plus gros (735 tuiles)
    SPR_reset();
    STAGE_init();
    SYS_doVBlankProcess();
    PLAYER_init();
    gameFrame = 0;
}

int main(bool hard)
{
    u16 prevJoy = 0;

    VDP_setScreenWidth256();
    VDP_setPlaneSize(64, 32, TRUE);
    SPR_initEx(696);
    TITLE_run();
    stageNo = START_STAGE;
    start();

    while (TRUE)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        s16 n = ((joy & (BUTTON_UP | BUTTON_DOWN)) == (BUTTON_UP | BUTTON_DOWN)) ? 4 : 1;        // débogage : haut + bas = vitesse x4

        if (player.gameOver)                // plus de vie : retour à l'écran titre
        {
            SPR_reset();
            TITLE_run();
            stageNo = START_STAGE;
            start();
            prevJoy = JOY_readJoypad(JOY_1);
            continue;
        }
        else if ((joy & ~prevJoy & BUTTON_START) && (stageClearTimer == 0)) start();
        else if (stageClearTimer > 0)
        {
            if (stageClearTimer < 1000) stageClearTimer++;
            if (stageClearTimer == 150)
            {
                VDP_setTextPlane(BG_A); VDP_setTextPalette(PAL1); PAL_setColor(31, 0x0EEE);
                { char t[] = "STAGE 1 CLEAR"; t[6] = '0' + stageNo; VDP_drawText(t, 9, 8); }
                VDP_drawText("PUSH START BUTTON", 7, 12);
            }
            if ((stageClearTimer > 150) && (joy & ~prevJoy & BUTTON_START))
            {
                if (stageNo < 6) stageNo++; else { SPR_reset(); TITLE_run(); stageNo = START_STAGE; }
                start(); prevJoy = JOY_readJoypad(JOY_1);
                continue;
            }
        }
        debugInvincible = (joy & BUTTON_A) ? TRUE : FALSE;

        while (n--)
        {
            PLAYER_update(prevJoy, gameFrame);     // l'original applique les commandes avec une frame de retard
            STAGE_update();
            gameFrame++;
        }
        PLAYER_draw();
        STAGE_draw();
        SPR_update();
        SYS_doVBlankProcess();
        STAGE_afterVBlank();
        prevJoy = joy;
    }
    return 0;
}
