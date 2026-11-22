// Musique : pilote XGM2 (Z80) ; pistes issues du PSG de la PC Engine (tools/mkmusic.py) : FM + PSG + PCM
#ifndef MUS_H
#define MUS_H
#include <genesis.h>

enum { MUS_TITLE = 0, MUS_STAGE1, MUS_STAGE2, MUS_STAGE3, MUS_STAGE4, MUS_STAGE5, MUS_STAGE6,
       MUS_BOSS_A, MUS_BOSS_B, MUS_BOSS_6, MUS_CLEAR, MUS_GAMEOVER, MUS_COUNT };

void MUS_init(void);
void MUS_play(u16 track);
void MUS_stop(void);
void MUS_stageUpdate(s16 frame);

// bruitages PCM (rendus du PSG de la PC Engine, tools/mksfx.py)
enum { SFX_SHOT = 0, SFX_BOOM, SFX_BELLHIT, SFX_BELLGET, SFX_POWER, SFX_DEATH1, SFX_FALL, SFX_RESP1, SFX_RESP2, SFX_BOMB, SFX_BIG, SFX_BHIT, SFX_BHIT2, SFX_BDEAD, SFX_BXPL, SFX_KONAMI };
void SFX_play(u16 id);        // appelée chaque frame de stage : lance la musique du stage puis celle du boss

#endif
