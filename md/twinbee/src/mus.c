#include "mus.h"
#include "stage.h"
#include "music.h"        // généré par rescomp (res/music.res) : mus_all
#include "sfx.h"          // généré par rescomp (res/sfx.res)

// frame de stage (PCE : frame - origine du stage) à laquelle le pilote d'origine lance le thème / le thème du boss
static const s16 mStart[6] = { 0, 60, 53, 62, 59, 66 };
static const s16 mBoss[6] = { 14620, 11815, 15084, 9889, 9211, 8933 };
static const u8 mBossTrack[6] = { MUS_BOSS_A, MUS_BOSS_A, MUS_BOSS_B, MUS_BOSS_B, MUS_BOSS_A, MUS_BOSS_6 };

void MUS_init(void) { XGM2_loadDriver(TRUE); XGM2_load(mus_all); }

// loop = -1 : bouclage sans fin ; 0 : une seule lecture puis arrêt du pilote (XGM2_setLoopNumber)
static void musPlay(u16 track, s8 loop)
{
    XGM2_stop();
    SYS_doVBlankProcess(); SYS_doVBlankProcess();
    XGM2_setLoopNumber(loop);
    XGM2_load(mus_all);
    XGM2_playTrack(track);
}

void MUS_play(u16 track) { musPlay(track, -1); }
void MUS_playOnce(u16 track) { musPlay(track, 0); }
// jingle de boot : piste deja chargee (MUS_init), on la lance sans couper le pilote
void MUS_playNow(u16 track) { XGM2_setLoopNumber(0); XGM2_playTrack(track); }
void MUS_stop(void) { XGM2_stop(); }

// Musique de la scene de la princesse : sur PCE c'est une piece dediee de 15,7 s (non bouclee,
// fondu de fin) absente des 12 pistes PSG converties. On rejoue donc la sortie PCM de la PCE
// (analysis/mk_story_audio.py), sur le canal PCM 2 (aucune musique pendant la scene).
//
// La sortie PCM passe par le DAC, c'est-a-dire le canal FM 6 : si la piste musicale qui precedait
// a laisse le pan de ce canal a droite (0x40), le PCM n'est audible qu'a droite (mesure : L -19 dB
// par rapport a R apres l'arret du theme du titre). On force donc le pan centre avant un long PCM.
static void pcmCenter(void)
{
    // le YM2612 est dans l'espace du Z80 : il faut lui prendre le bus pour ecrire le registre
    // (le pilote XGM2 y accede en permanence pour le DAC).
    Z80_requestBus(TRUE);
    YM2612_writeReg(1, 0xB6, 0xC0);
    Z80_releaseBus();
}

void MUS_storyCue(void)
{
    pcmCenter();
    XGM2_playPCMEx(sfx_story, sizeof(sfx_story), SOUND_PCM_CH2, 4, FALSE, FALSE);
}

void MUS_storyCueStop(void) { XGM2_stopPCM(SOUND_PCM_CH2); }

void MUS_saynCue(void)
{
    pcmCenter();
    XGM2_playPCMEx(sfx_sayn, sizeof(sfx_sayn), SOUND_PCM_CH2, 4, FALSE, FALSE);
}

void MUS_saynCueStop(void) { XGM2_stopPCM(SOUND_PCM_CH2); }

void MUS_stageUpdate(s16 frame)
{
    const u16 s = stageNo - 1;
    if (frame == mStart[s]) { XGM2_setLoopNumber(-1); XGM2_playTrack(MUS_STAGE1 + s); }
    else if (frame == mBoss[s]) { XGM2_setLoopNumber(-1); XGM2_playTrack(mBossTrack[s]); }
}

void SFX_play(u16 id)
{
    switch (id)
    {
        case SFX_SHOT:    XGM2_playPCMEx(sfx_17, sizeof(sfx_17), SOUND_PCM_CH2, 1, FALSE, FALSE); break;
        case SFX_BOOM:    XGM2_playPCMEx(sfx_1B, sizeof(sfx_1B), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case SFX_BELLHIT: XGM2_playPCMEx(sfx_1A, sizeof(sfx_1A), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case SFX_BELLGET: XGM2_playPCMEx(sfx_19, sizeof(sfx_19), SOUND_PCM_CH3, 3, FALSE, FALSE); break;
        case SFX_DEATH1:  XGM2_playPCMEx(sfx_2F, sizeof(sfx_2F), SOUND_PCM_CH2, 3, FALSE, FALSE); break;
        case SFX_FALL:    XGM2_playPCMEx(sfx_05, sizeof(sfx_05), SOUND_PCM_CH3, 3, FALSE, FALSE); break;
        case SFX_RESP1:   XGM2_playPCMEx(sfx_31, sizeof(sfx_31), SOUND_PCM_CH2, 3, FALSE, FALSE); break;
        case SFX_RESP2:   XGM2_playPCMEx(sfx_08, sizeof(sfx_08), SOUND_PCM_CH3, 3, FALSE, FALSE); break;
        case SFX_BOMB:    XGM2_playPCMEx(sfx_18, sizeof(sfx_18), SOUND_PCM_CH2, 2, FALSE, FALSE); break;
        case SFX_BIG:     XGM2_playPCMEx(sfx_1D, sizeof(sfx_1D), SOUND_PCM_CH3, 3, FALSE, FALSE); break;
        case SFX_BHIT:    XGM2_playPCMEx(sfx_1F, sizeof(sfx_1F), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case SFX_BHIT2:   XGM2_playPCMEx(sfx_35, sizeof(sfx_35), SOUND_PCM_CH3, 2, TRUE, FALSE); break;
        case SFX_BDEAD:   XGM2_playPCMEx(sfx_34, sizeof(sfx_34), SOUND_PCM_CH3, 3, TRUE, FALSE); break;
        case SFX_BXPL:    XGM2_playPCMEx(sfx_40, sizeof(sfx_40), SOUND_PCM_CH3, 3, FALSE, FALSE); break;
        case SFX_POWER:   XGM2_playPCMEx(sfx_28, sizeof(sfx_28), SOUND_PCM_CH3, 3, FALSE, FALSE); break;
        case SFX_CURSOR:  XGM2_playPCMEx(sfx_cursor, sizeof(sfx_cursor), SOUND_PCM_CH2, 2, FALSE, FALSE); break;
        case SFX_SELECT:  pcmCenter();
                          XGM2_playPCMEx(sfx_start, sizeof(sfx_start), SOUND_PCM_CH2, 3, FALSE, FALSE); break;
    }
}

// Test de son de l'ecran OPTION : joue l'ID du driver PCE (table  de la ROM).
// Les 15 bruitages de jeu gardent leur canal/priorite ; les autres, absents du jeu,
// passent sur le canal PCM 3 avec une priorite basse.
void SFX_playPce(u16 id)
{
    switch (id)
    {
        case 0x01: XGM2_playPCMEx(sfx_01, sizeof(sfx_01), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x02: XGM2_playPCMEx(sfx_02, sizeof(sfx_02), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x03: XGM2_playPCMEx(sfx_03, sizeof(sfx_03), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x04: XGM2_playPCMEx(sfx_04, sizeof(sfx_04), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x05: SFX_play(SFX_FALL); break;
        case 0x06: XGM2_playPCMEx(sfx_06, sizeof(sfx_06), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x07: XGM2_playPCMEx(sfx_07, sizeof(sfx_07), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x08: SFX_play(SFX_RESP2); break;
        case 0x0A: XGM2_playPCMEx(sfx_0A, sizeof(sfx_0A), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x0B: XGM2_playPCMEx(sfx_0B, sizeof(sfx_0B), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x11: XGM2_playPCMEx(sfx_11, sizeof(sfx_11), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x17: SFX_play(SFX_SHOT); break;
        case 0x18: SFX_play(SFX_BOMB); break;
        case 0x19: SFX_play(SFX_BELLGET); break;
        case 0x1A: SFX_play(SFX_BELLHIT); break;
        case 0x1B: SFX_play(SFX_BOOM); break;
        case 0x1C: XGM2_playPCMEx(sfx_1C, sizeof(sfx_1C), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x1D: SFX_play(SFX_BIG); break;
        case 0x1E: XGM2_playPCMEx(sfx_1E, sizeof(sfx_1E), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x1F: SFX_play(SFX_BHIT); break;
        case 0x20: XGM2_playPCMEx(sfx_20, sizeof(sfx_20), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x21: XGM2_playPCMEx(sfx_21, sizeof(sfx_21), SOUND_PCM_CH3, 2, TRUE, FALSE); break;
        case 0x22: XGM2_playPCMEx(sfx_22, sizeof(sfx_22), SOUND_PCM_CH3, 2, TRUE, FALSE); break;
        case 0x23: XGM2_playPCMEx(sfx_23, sizeof(sfx_23), SOUND_PCM_CH3, 2, TRUE, FALSE); break;
        case 0x24: XGM2_playPCMEx(sfx_24, sizeof(sfx_24), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x26: XGM2_playPCMEx(sfx_26, sizeof(sfx_26), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x28: SFX_play(SFX_POWER); break;
        case 0x29: XGM2_playPCMEx(sfx_29, sizeof(sfx_29), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x2B: XGM2_playPCMEx(sfx_2B, sizeof(sfx_2B), SOUND_PCM_CH3, 2, TRUE, FALSE); break;
        case 0x2C: XGM2_playPCMEx(sfx_2C, sizeof(sfx_2C), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x2D: XGM2_playPCMEx(sfx_2D, sizeof(sfx_2D), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x2E: XGM2_playPCMEx(sfx_2E, sizeof(sfx_2E), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x2F: SFX_play(SFX_DEATH1); break;
        case 0x31: SFX_play(SFX_RESP1); break;
        case 0x32: XGM2_playPCMEx(sfx_32, sizeof(sfx_32), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x33: XGM2_playPCMEx(sfx_33, sizeof(sfx_33), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x34: SFX_play(SFX_BDEAD); break;
        case 0x35: SFX_play(SFX_BHIT2); break;
        case 0x36: XGM2_playPCMEx(sfx_36, sizeof(sfx_36), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x37: XGM2_playPCMEx(sfx_37, sizeof(sfx_37), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x38: XGM2_playPCMEx(sfx_38, sizeof(sfx_38), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x39: XGM2_playPCMEx(sfx_39, sizeof(sfx_39), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x3A: XGM2_playPCMEx(sfx_3A, sizeof(sfx_3A), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x3B: XGM2_playPCMEx(sfx_3B, sizeof(sfx_3B), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case 0x40: SFX_play(SFX_BXPL); break;
        case 0x45: XGM2_playPCMEx(sfx_45, sizeof(sfx_45), SOUND_PCM_CH3, 2, TRUE, FALSE); break;
    }
}
