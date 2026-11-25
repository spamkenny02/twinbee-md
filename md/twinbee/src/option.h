#ifndef OPTION_H
#define OPTION_H

// Écran OPTION (PCE : RANK / CREDIT / PLAYER / SOUND).
// Valeurs conservées pour la partie : RANK 0=NORMAL 1=EASY 2=PRO 3=HARD,
// CREDIT et PLAYER 1..5, SOUND 0..8 (ordre et plages relevés sur la ROM PCE).
extern u8 optRank, optCredit, optPlayer, optSound;

void OPTION_run(void);      // boucle jusqu'à RUN/START, puis retour à l'écran titre

#endif
