#ifndef BOSSN_H
#define BOSSN_H
#include <genesis.h>
// Boss « sprites » des stages 3 à 6 : pièces rejouées frame par frame depuis la trace PCE (tools/mkbossN.py)
bool BOSSN_available(s16 stageNo);          // données de boss pour ce stage ?
s16  BOSSN_startFrame(s16 stageNo);         // frame de jeu du début du boss
void BOSSN_start(s16 stageNo);              // crée les sprites, charge la palette
void BOSSN_stop(void);                      // libère les sprites
bool BOSSN_update(s16 t);                   // t = frames depuis le début ; FALSE quand la trace est terminée
bool BOSSN_hit(s16 cx, s16 cy, s16 hw, s16 hh);   // tir (centre, demi-boîte) : TRUE si le corps est touché ; décrémente les points de vie
bool BOSSN_contact(s16 px, s16 py);         // le joueur touche le corps du boss
bool BOSSN_dead(void);                      // points de vie épuisés
void BOSSN_center(s16* x, s16* y);          // centre de la boîte de collision (pour les explosions)
#endif
