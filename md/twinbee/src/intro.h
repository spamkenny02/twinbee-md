#ifndef INTRO_H
#define INTRO_H
#include <genesis.h>
void INTRO_run(void);       // intro (logo Konami, puis scène PCE rejouée) ; START l'abrège
bool INTRO_replay(void);    // scène de vol rejouée depuis la trace PCE (end.c) ; TRUE si abrégée
extern bool titleMusicOn;   // la musique du titre est déjà lancée (elle démarre pendant l'intro sur la PCE)
#endif
