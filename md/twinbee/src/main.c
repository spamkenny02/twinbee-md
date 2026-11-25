// Detana!! TwinBee - portage Mega Drive (SGDK)
// Jalon 6 : + toutes les vagues d'ennemis de type 5, contact, mort et réapparition, vies
// Manette : croix = déplacement, B = tir (tenir pour charger), C = jeu accéléré x4 (debug), A = invincible (debug), START = recommencer
#include <genesis.h>
#include "player.h"
#include "stage.h"
#include "title.h"
#include "intro.h"
#include "end.h"
#include "story.h"
#include "saynete.h"
#include "card.h"
#include "option.h"
#include "mus.h"
#include "demo_path.h"
#include "demo_path2.h"

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
    demoHud = FALSE;
    SPR_end();
    SPR_initEx((stageNo >= 2) ? 640 : 696); SPR_disableVDPSpriteChecking();        // VRAM sprites : le décor du stage 2 est plus gros (735 tuiles)
    SPR_reset();
    STAGE_init();
    SYS_doVBlankProcess();
    PLAYER_init();
    gameFrame = 0;
}

static bool wantP2;

// Démo d'attract : le vaisseau suit la trajectoire relevée sur la PC Engine (demo_path.h / demo_path2.h) ;
// pas de tir (la démo PCE n'en fait pas), vaisseau invincible, 2 vies comme sur PCE.
// START écourte comme sur PCE (retour logo + vol).
static bool attractDemo(u8 stage, const u8 (*path)[2], u16 frames, bool keepMusic)
{
    u16 f, prev = JOY_readJoypad(JOY_1);
    bool skipped = FALSE;
    SPR_end();
    SPR_initEx((stage >= 2) ? 640 : 696); SPR_disableVDPSpriteChecking();   // decor stage 2 plus gros (735 tuiles)
    SPR_reset();
    stageNo = stage;
    demoHud = TRUE;                                         // « 2P GAME OVER », pas de CREDIT
    STAGE_init();
    if (stage >= 2) STAGE_setDemoScroll(demoScroll2, DEMO2_FRAMES);   // la demo PCE ne defile pas au rythme du stage
    SYS_doVBlankProcess();
    PLAYER_init();
    players[0].lives = 2;                                   // « 1P 2 » sur la démo PCE
    gameFrame = 0;
    debugInvincible = TRUE;
    for (f = 0; f < frames; f++)
    {
        const u16 raw = JOY_readJoypad(JOY_1);
        const s16 dx = (s16) path[f][0] - players[0].x;
        const s16 dy = (s16) path[f][1] - players[0].y;
        u16 joy = 0;
        if (dx > 0) joy |= BUTTON_RIGHT; else if (dx < 0) joy |= BUTTON_LEFT;
        if (dy > 0) joy |= BUTTON_DOWN; else if (dy < 0) joy |= BUTTON_UP;
        if ((raw & BUTTON_START) && !(prev & BUTTON_START)) { skipped = TRUE; break; }
        prev = raw;
        players[0].speedLvl = 6;                            // 2 px/image, vitesse de la démo PCE
        PLAYER_update(0, joy, gameFrame);
        STAGE_update();
        gameFrame++;
        PLAYER_draw(0);
        STAGE_draw();
        SPR_update();
        SYS_doVBlankProcess();
        STAGE_afterVBlank();
    }
    debugInvincible = FALSE;
    demoHud = FALSE;
    STAGE_releaseMap();                                    // rend la carte au tas avant le titre / la carte princesse
    if (!keepMusic) MUS_stop();                            // phase 1 : le theme du stage 2 continue sur la carte
    SPR_end();
    return skipped;
}

// Attract complet, comme sur PCE : phase 0 = démo stage 1 + saynète garçon/TwinBee ; phase 1 =
// démo stage 2 + carte de la princesse. Les deux phases finissent sur le logo Konami + le vol.
static void attractRun(u8 phase)
{
    const bool skipped = phase ? attractDemo(2, demoPath2, DEMO2_FRAMES, TRUE)
                               : attractDemo(1, demoPath, DEMO_FRAMES, FALSE);
    if (phase == 0)
    {
        if (!skipped) SAYNETE_run();                        // garçon + TwinBee, puis logo (PCE 7105-7490)
    }
    else if (!skipped) CARD_run();                         // princesse + logo (PCE 13380-13740)
    if (phase) MUS_stop();                                 // fin de la carte : silence avant le logo Konami
    SPR_initEx(696); SPR_disableVDPSpriteChecking();
    INTRO_run();                                            // logo + vol, puis retour au titre
}

// Boucle titre : si l'écran reste inactif, la démo d'attract se lance puis on revient au titre.
// Les deux passages alternent la démo du stage 1 et celle du stage 2, comme sur PCE.
static bool titleOrAttract(void)
{
    static u8 phase = 0;
    bool play;
    for (;;)
    {
        play = TITLE_run();
        if (play) phase = 0;                                // partie lancée : l'attract repart à la phase 0
        if (!titleWantsAttract) return play;
        attractRun(phase);
        phase ^= 1;
    }
}

int main(bool hard)
{
    u16 prevJoy = 0, prevJoy2 = 0;
    s16 contCount = -1, contTick = 0;
    credits = optCredit;

    VDP_setScreenWidth256();
    VDP_setPlaneSize(64, 32, TRUE);
    SPR_initEx(696); SPR_disableVDPSpriteChecking();
    MUS_init();
    INTRO_run();
    wantP2 = titleOrAttract();
    STORY_run();                                    // scene de la princesse (PCE 2082-3099), START l'abrege
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
        if (wantP2 && !players[1].active && (stageClearTimer == 0) && (gameFrame > 2)) { wantP2 = FALSE; PLAYER_join(); STAGE_join(); }
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
                credits = optCredit; contCount = -1;
                wantP2 = titleOrAttract();
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
                credits = optCredit; stageClearTimer = 0;
                wantP2 = titleOrAttract(); stageNo = START_STAGE; start(); prevJoy = JOY_readJoypad(JOY_1);
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
                if (stageNo < 6) stageNo++; else { SPR_reset(); wantP2 = titleOrAttract(); stageNo = START_STAGE; }
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
