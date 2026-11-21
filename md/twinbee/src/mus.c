#include "mus.h"
#include "stage.h"
#include "music.h"        // généré par rescomp (res/music.res) : mus_all
#include "sfx.h"          // généré par rescomp (res/sfx.res)

// frame de stage (PCE : frame - origine du stage) à laquelle le pilote d'origine lance le thème / le thème du boss
static const s16 mStart[6] = { 322, 60, 53, 62, 59, 66 };
static const s16 mBoss[6] = { 14620, 11815, 15084, 9889, 9211, 8933 };
static const u8 mBossTrack[6] = { MUS_BOSS_A, MUS_BOSS_A, MUS_BOSS_B, MUS_BOSS_B, MUS_BOSS_A, MUS_BOSS_6 };

void MUS_init(void) { XGM2_loadDriver(TRUE); XGM2_load(mus_all); }
void MUS_play(u16 track) { XGM2_stop(); SYS_doVBlankProcess(); SYS_doVBlankProcess(); XGM2_load(mus_all); XGM2_playTrack(track); }
void MUS_stop(void) { XGM2_stop(); }

void MUS_stageUpdate(s16 frame)
{
    const u16 s = stageNo - 1;
    if (frame == mStart[s]) XGM2_playTrack(MUS_STAGE1 + s);
    else if (frame == mBoss[s]) XGM2_playTrack(mBossTrack[s]);
}

void SFX_play(u16 id)
{
    switch (id)
    {
        case SFX_SHOT:    XGM2_playPCMEx(sfx_17, sizeof(sfx_17), SOUND_PCM_CH2, 1, FALSE, FALSE); break;
        case SFX_BOOM:    XGM2_playPCMEx(sfx_1B, sizeof(sfx_1B), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case SFX_BELLHIT: XGM2_playPCMEx(sfx_1A, sizeof(sfx_1A), SOUND_PCM_CH3, 2, FALSE, FALSE); break;
        case SFX_BELLGET: XGM2_playPCMEx(sfx_19, sizeof(sfx_19), SOUND_PCM_CH3, 3, FALSE, FALSE); break;
        case SFX_POWER:   XGM2_playPCMEx(sfx_28, sizeof(sfx_28), SOUND_PCM_CH3, 3, FALSE, FALSE); break;
    }
}
