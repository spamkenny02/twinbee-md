// Detana!! TwinBee - portage Mega Drive (SGDK)
// Jalon 6 : + toutes les vagues d'ennemis de type 5, contact, mort et réapparition, vies
// Manette : croix = déplacement, B = tir (tenir pour charger), C = jeu accéléré x4 (debug), A = invincible (debug), START = recommencer
#include <genesis.h>
#include "player.h"
#include "stage.h"
#include "title.h"
#include "intro.h"
#include "end.h"
#include "mus.h"

u16 gameFrame;
static s16 credits;                       // continues restants

static void drawScoreRow(const char* label, u32 v, u16 y)
{
    char t[24];
    sprintf(t, "%s %08lu", label, v);
    VDP_drawText(t, 8, y);
}

// écran GAME OVER : fond noir, scores, jingle ; retour au titre après la musique ou START
static void gameOverScreen(void)
{
    u16 f = 0, prev = JOY_readJoypad(JOY_1);
    SPR_reset(); SPR_update();
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE); VDP_clearPlane(WINDOW, TRUE);
    VDP_setWindowVPos(FALSE, 0);
    VDP_setHorizontalScroll(BG_A, 0); VDP_setVerticalScroll(BG_A, 0); VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_setBackgroundColor(0);
    VDP_setTextPlane(BG_A); VDP_setTextPalette(PAL1);
    VDP_drawText("GAME OVER", 11, 7);
    drawScoreRow("1P", stage.score, 13);
    if (players[1].active) drawScoreRow("2P", stage.score2, 15);
    SYS_doVBlankProcess();
    PAL_setColor(17, 0x0EEE);
    MUS_play(MUS_GAMEOVER);
    while (f < 480)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        const u16 hue = (f >> 3) % 6;
        static const u16 rainbow[6] = { 0x000E, 0x00EE, 0x00E0, 0x0EE0, 0x0E00, 0x0E0E };
        PAL_setColor(31, rainbow[hue]);
        if ((f > 60) && (joy & ~prev & BUTTON_START)) break;
        prev = joy; f++;
        SYS_doVBlankProcess();
    }
    MUS_stop();
}
                            // compteur de frames de jeu (lu par les tests)

#ifndef START_STAGE
#define START_STAGE 1
#endif

static void start(void)
{
    SPR_end();
    SPR_initEx((stageNo >= 2) ? 640 : 696); SPR_disableVDPSpriteChecking();        // VRAM sprites : le décor du stage 2 est plus gros (735 tuiles)
    SPR_reset();
    STAGE_init();
    SYS_doVBlankProcess();
    PLAYER_init();
    gameFrame = 0;
}

int main(bool hard)
{
    u16 prevJoy = 0, prevJoy2 = 0;
    s16 contCount = -1, contTick = 0;
    credits = 3;

    VDP_setScreenWidth256();
    VDP_setPlaneSize(64, 32, TRUE);
    SPR_initEx(696); SPR_disableVDPSpriteChecking();
    MUS_init();
    INTRO_run();
    TITLE_run();
#ifdef DBG_ENDING
    ENDING_run();
#endif
    stageNo = START_STAGE;
    start();

    while (TRUE)
    {
        const u16 joy = JOY_readJoypad(JOY_1), joy2 = JOY_readJoypad(JOY_2);
        s16 n = ((joy & (BUTTON_UP | BUTTON_DOWN)) == (BUTTON_UP | BUTTON_DOWN)) ? 4 : 1;        // débogage : haut + bas = vitesse x4

#ifdef DBG_GAMEOVER_AT
        if (gameFrame == DBG_GAMEOVER_AT) { players[0].gameOver = TRUE; players[1].gameOver = TRUE; }
#endif
        // le joueur 2 entre avec START sur la manette 2 (RUN sur PC Engine), pas pendant l'écran de fin de niveau
        if (!players[1].active && (joy2 & ~prevJoy2 & BUTTON_START) && (stageClearTimer == 0)) { PLAYER_join(); STAGE_join(); }
        if (players[0].gameOver && (!players[1].active || players[1].gameOver))                // plus de vie : Continue, puis GAME OVER
        {
            if (contCount < 0)
            {
                s16 k;
                for (k = 0; k < 2; k++) if (players[k].active) { players[k].phase = 3; players[k].gameOver = TRUE; }
                if (credits > 0) { contCount = 9; contTick = 0; }
                else contCount = 100;
            }
            if (contCount <= 9)
            {
                // décompte « CONTINUE » : l'écran reste figé (l'original continue à faire défiler le décor)
                s16 k, started = -1;
                char t[24];
                sprintf(t, "%dP CONTINUE %d", players[1].active && !players[0].active ? 2 : 1, contCount);
                VDP_setTextPlane(BG_A); VDP_setTextPalette(PAL1); PAL_setColor(31, 0x0EEE);
                VDP_drawText(t, 9, 12);
                if ((joy & ~prevJoy & BUTTON_START)) started = 0;
                if (players[1].active && (joy2 & ~prevJoy2 & BUTTON_START)) started = 1;
                if (started >= 0)
                {
                    credits--;
                    PLAYER_continue(started);
                    if (started == 0) stage.score = 0; else stage.score2 = 0;
                    if ((started == 0) && players[1].active && players[1].gameOver) players[1].phase = 3;
                    VDP_clearTextArea(0, 12, 32, 1);
                    contCount = -1;
                    prevJoy = joy; prevJoy2 = joy2;
                    continue;
                }
                if (++contTick >= 60) { contTick = 0; contCount--; }
                if (contCount < 0) contCount = 100;
            }
            if (contCount >= 100)
            {
                VDP_clearTextArea(0, 12, 32, 1);
                gameOverScreen();
                credits = 3; contCount = -1;
                TITLE_run();
                stageNo = START_STAGE;
                start();
                prevJoy = JOY_readJoypad(JOY_1);
                continue;
            }
            PLAYER_draw(0);
            if (players[1].active) PLAYER_draw(1);
            STAGE_draw();
            SPR_update();
            SYS_doVBlankProcess();
            STAGE_afterVBlank();
            prevJoy = joy; prevJoy2 = joy2;
            continue;
        }
        else if ((joy & ~prevJoy & BUTTON_START) && (stageClearTimer == 0)) start();
        else if (stageClearTimer > 0)
        {
            if ((stageNo == 6) && (stageClearTimer == 150))      // fin du jeu : séquence de fin, puis retour au titre
            {
                MUS_stop(); ENDING_run(); SPR_reset();
                credits = 3; stageClearTimer = 0;
                TITLE_run(); stageNo = START_STAGE; start(); prevJoy = JOY_readJoypad(JOY_1);
                continue;
            }
            if (stageClearTimer == 1) MUS_play(MUS_CLEAR);
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
            PLAYER_update(0, prevJoy, gameFrame);     // l'original applique les commandes avec une frame de retard
            if (players[1].active) PLAYER_update(1, prevJoy2, gameFrame);
            PLAYER_collide();
            STAGE_update();
            gameFrame++;
        }
        PLAYER_draw(0);
        if (players[1].active) PLAYER_draw(1);
        STAGE_draw();
        SPR_update();
        SYS_doVBlankProcess();
        STAGE_afterVBlank();
        prevJoy = joy; prevJoy2 = joy2;
    }
    return 0;
}
