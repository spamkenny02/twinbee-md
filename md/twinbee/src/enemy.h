// Ennemis de type 5 (routine d'origine : banque $0C, $6100 à $61DB), toutes les vagues du stage 1
#ifndef ENEMY_H
#define ENEMY_H
#include <genesis.h>

#define MAX_AIR             18          // emplacements des ennemis volants (66 à 83 sur PCE)
#define MAX_ENEMIES         32          // + 6 emplacements pour les ennemis au sol (96 à 101 sur PCE)
#define ENEMY_SCORE         100
#define WAVE_BONUS          1000        // groupe de 6 entièrement détruit (observé une fois : +1000 à la fin de la dernière explosion)
#define WAVE_SIZE           6
#define ENEMY_TRIGGER_DX    0x20        // l'ennemi vire dès que |joueur.x - ennemi.x| < 32
#define ENEMY_TURN_FRAMES   12          // puis tourne d'un cran (11,25 degrés) toutes les 12 frames
#define ENEMY_LAG           2           // sur PCE, les sprites sont affichés 2 frames après le calcul des positions
// contact avec le joueur (routine d'origine banque $17 $AD2B) : |dx| < 10 + demi-largeur (4) et |dy| < 7 + demi-hauteur (5),
// avec dx, dy = joueur - ennemi ; les 3 derniers pixels en x (|dx| >= 7 + demi-largeur) sont la zone des bras.
#define ENEMY_TEST_PRE      0           // 1 : le test de contact précède le déplacement de l'ennemi dans la frame
#define ENEMY_PARITY_I      0           // 1 : la parité du test dépend du numéro d'objet (ancien ajustement), 0 : compteur global ($83)
#define ENEMY_PARITY        1
#define ENEMY_CONTACT_X     14
#define ENEMY_CONTACT_Y     12
#define ENEMY_BODY_X        11

// état lisible de l'extérieur (vérification automatique) : centres des ennemis, comme en RAM PCE
typedef struct
{
    s16 on[MAX_ENEMIES];                // 0 = libre, 1 = en vol, 2 = touché (encore affiché une frame)
    s16 x[MAX_ENEMIES], y[MAX_ENEMIES];
    s16 kills;
    s16 bossDead;                       // boss de fin vaincu (approximation, voir NOTES)
    s16 kind[MAX_ENEMIES];              // 5, 3 ou 4 (type de l'ennemi d'origine)
    s16 bombState[2], bombX[2], bombY[2];   // bombes : 0 = libre, 1 = en vol (y = centre de la bombe), 2 = vient d'exploser
} EnemyState;

extern EnemyState enemies;

void ENEMY_init(void);
// déplace les ennemis ; *bonus reçoit les points gagnés (bonus de groupe, ennemis détruits au contact) ;
// contactOn = FALSE : pas de contact avec le joueur (mode debug)
void ENEMY_update(s16 frame, s16 playerObjX, s16 playerObjY, s16 scrollDelta, u16* bonus, bool contactOn);
bool ENEMY_hitByShot(s16 shotX, s16 shotY);     // coordonnées sprite du tir ; TRUE si un ennemi est détruit
// tir chargé : centre et demi-tailles (table d'origine $CAEA : 15x20 au niveau 1, 28x52 au niveau 2) ; il traverse les ennemis
s16 ENEMY_hitByCharged(s16 cx, s16 cy, s16 hw, s16 hh);  // renvoie le nombre d'ennemis détruits
void ENEMY_bombPress(s16 px, s16 py);          // bouton bombe : lance une bombe (2 en vol au maximum)
void ENEMY_draw(void);

#endif
