// Musique : pilote XGM2 (Z80) ; pistes issues du PSG de la PC Engine (tools/mkmusic.py) : FM + PSG + PCM
#ifndef MUS_H
#define MUS_H
#include <genesis.h>

enum { MUS_TITLE = 0, MUS_STAGE1, MUS_STAGE2, MUS_STAGE3, MUS_STAGE4, MUS_STAGE5, MUS_STAGE6,
       MUS_BOSS_A, MUS_BOSS_B, MUS_BOSS_6, MUS_CLEAR, MUS_GAMEOVER, MUS_KONAMI, MUS_COUNT };

void MUS_init(void);
void MUS_play(u16 track);       // piste bouclée (musique de jeu)
void MUS_playOnce(u16 track);   // piste jouée une seule fois (thème du titre sur PCE)
void MUS_playNow(u16 track);    // jingle : lance la piste immédiatement, sans arrêt/rechargement
void MUS_stop(void);
void MUS_stageUpdate(s16 frame);

// La scene de la princesse a sur PCE une musique propre (15,7 s, non bouclee) qui ne figure pas
// parmi les 12 pistes converties en XGM2 : on la rejoue en PCM 13,3 kHz, rendu de la sortie PCE.
void MUS_storyCue(void);
void MUS_storyCueStop(void);

// La saynete garcon + TwinBee a elle aussi un cue dedie sur PCE (5,6 s, 7093-7434) absent des
// pistes converties : PCM 13,3 kHz rendu de la sortie PCE (analysis/mk_sayn_audio.py).
void MUS_saynCue(void);
void MUS_saynCueStop(void);

// bruitages PCM (rendus du PSG de la PC Engine, tools/mksfx.py)
enum { SFX_SHOT = 0, SFX_BOOM, SFX_BELLHIT, SFX_BELLGET, SFX_POWER, SFX_DEATH1, SFX_FALL, SFX_RESP1, SFX_RESP2, SFX_BOMB, SFX_BIG, SFX_BHIT, SFX_BHIT2, SFX_BDEAD, SFX_BXPL, SFX_CURSOR, SFX_SELECT };
void SFX_play(u16 id);
// ID du driver sonore PCE (0x01..0x45) : utilise par le test de son de l'ecran OPTION.
// Les 15 bruitages de jeu passent par SFX_play ; les autres sont des WAV dedies.
void SFX_playPce(u16 id);        // appelée chaque frame de stage : lance la musique du stage puis celle du boss

#endif
