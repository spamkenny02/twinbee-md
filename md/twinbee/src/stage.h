// Stage 1 : défilement, nuages, cloches, score, HUD - valeurs mesurées sur la version PC Engine
#ifndef STAGE_H
#define STAGE_H
#include <genesis.h>

#define PLAYFIELD_H     208         // 26 lignes de tiles pour le terrain, 2 pour le HUD (fenêtre)
#define MAX_CLOUDS      8
#define MAX_BELLS       5
#define MAX_POPUPS      4

#define CLOUD_EXIT_Y    240         // un nuage disparaît en bas à y >= 240
#define BELL_V0         (-488)      // vitesse de départ d'une cloche (8.8) à la sortie du nuage
#define BELL_V_HIT      (-500)      // vitesse après un tir reçu
#define BELL_V_NOHIT    (-400)      // une cloche qui monte déjà plus vite que ça n'est pas relancée (seuil entre -464 et -296)
#define BELL_GRAVITY    12          // ajoutée chaque frame (8.8)
#define BELL_VMAX       0x300       // vitesse de chute maximale : 3 px/frame
#define BELL_EXIT_Y     216
#define BELL_SCORE      500
#define POPUP_FRAMES    28

// état lisible de l'extérieur (vérification automatique en émulation)
typedef struct
{
    s16 frame;                      // frame de jeu depuis le début du stage
    s16 scroll;                     // défilement cumulé en pixels
    u32 score;
    s16 cloudOn[MAX_CLOUDS], cloudX[MAX_CLOUDS], cloudY[MAX_CLOUDS], cloudBell[MAX_CLOUDS];
    s16 bellOn[MAX_BELLS], bellX[MAX_BELLS], bellY[MAX_BELLS];
    u32 score2;                     // score du joueur 2 (en fin de structure : les outils de test lisent les champs précédents par offset)
} StageState;

extern StageState stage;
extern bool debugInvincible;
extern bool demoHud;                   // TRUE : HUD de la demo d'attract (2P GAME OVER, sans CREDIT)
extern u8 stageNo;                     // stage en cours (1 ou 2), à fixer avant STAGE_init
extern s16 stageClearTimer;            // > 0 : boss de fin vaincu, frames écoulées depuis

void STAGE_init(void);
void STAGE_setDemoScroll(const u8* tab, u16 frames);   // demo d'attract : defilement releve sur PCE
void STAGE_join(void);              // le joueur 2 entre : HUD 2P
void STAGE_update(void);            // une frame de jeu (après PLAYER_update)
void STAGE_draw(void);              // position des sprites, défilement, HUD
void STAGE_releaseClouds(void);
void STAGE_eraseBoss(void);
void STAGE_afterVBlank(void);       // écritures de palette, juste après le VBlank

#endif
