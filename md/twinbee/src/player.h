// Joueur (TwinBee) et tirs - valeurs mesurées sur la version PC Engine
#ifndef PLAYER_H
#define PLAYER_H
#include <genesis.h>

// Coordonnées « PCE » : zone de jeu de 240 px ; l'écran MD en affiche 256, d'où un décalage de 8 px.
#define PF_XOFF         8

#define PLAYER_START_X  64
#define PLAYER_START_X2 160         // WinBee (joueur 2) : x de départ / de réapparition
#define START_LIVES2    2
#define PLAYER_START_Y  159
#define PLAYER_MIN_X    16
#define PLAYER_MAX_X    225
#define PLAYER_MIN_Y    24
#define PLAYER_MAX_Y    198
#define PLAYER_SPEED    0x180       // 1,5 px/frame en virgule fixe 8.8

#define SHOT_SPEED      6           // px/frame, tirs normaux et chargés
#define SHOT_DELAY      1           // + 1 frame de retard des commandes = 2 frames entre appui/relâchement et tir, comme mesuré
// Règles lues dans le code d'origine (banque $01, $CA34-$CD54) :
#define SHOT_COOLDOWN   4           // posé à chaque tir ; ne décompte que les frames où le bouton est tenu ou vient d'être pressé
#define CHARGE_MAX      40          // compteur de charge ($A6) : +1 par frame bouton tenu, plafonné à $28 = niveau 2
#define CHARGE_LVL1     12          // relâchement à partir de $0C : tir chargé niveau 1 ; c'est aussi le seuil du halo
#define CHARGE_HALO     12

// Mort et réapparition (mesurées sur l'original) :
#define DEATH_EXPLODE   25          // frames entre le contact et le début de la chute
#define DEATH_FALL_MIN  52          // la chute (3 px/frame) dure au moins 52 frames et jusqu'à y >= 246
#define RESPAWN_Y       255         // réapparition en (64, 255), montée de 2 px/frame pendant 48 frames
#define RESPAWN_INV     192
#ifndef START_LIVES
#define START_LIVES     3
#endif
#define ARM_BLINK_FRAMES 32         // un bras touché clignote 32 frames (4 visibles, 4 cachés) puis reste perdu
#define ARM_BLINK_PHASE  4          // décalage de phase du clignotement par rapport au compteur de frames

// résultat d'un contact ennemi -> joueur (routine d'origine banque $17 $AFE2)
#define CONTACT_NONE    0           // l'ennemi traverse (zone de bras sans bras disponible, ou joueur déjà touché / invincible)
#define CONTACT_ARM     1           // un bras encaisse : l'ennemi est détruit, pas le joueur
#define CONTACT_BODY    2           // le corps est touché : le joueur meurt, l'ennemi est détruit

#define PW_OPT1    0x01     // option 1 (cloche verte)
#define PW_OPT2    0x02     // option 2 (cloche violette)
#define PW_TWIN    0x04     // tir double (cloche blanche)
#define PW_FAN     0x08     // ventilateur : tir en éventail (3 directions)
#define PW_BARRIER 0x80     // cloche rouge
#define PLAYER_SPEED_LVL0 4

// état lisible de l'extérieur (sert aussi à la vérification automatique en émulation)
typedef struct
{
    s16 x, y;               // position du joueur, pixels PCE
    s16 shotActive, shotX, shotY;
    s16 charge;             // compteur de charge
    s16 chargedLevel;       // 0 = aucun tir chargé à l'écran, 1 ou 2
    s16 chargedX, chargedY;
    s16 shotCooldown;       // voir SHOT_COOLDOWN
    s16 shot2Active, shot2X, shot2Y;    // second emplacement de tir (deux tirs normaux à l'écran au maximum)
    s16 phase;              // 0 = en jeu, 1 = touché (explosion puis chute), 2 = réapparition par le bas
    s16 inv;                // minuteur d'invincibilité ($380D) : 192 à la réapparition, -1 par frame
    s16 lives;
    s16 gameOver;
    s16 armLost;            // bras perdus ($34A5) : bit 0 = gauche, bit 1 = droit ; remis à zéro à la réapparition
    s16 armBlink;           // bras qui clignote ($38E7) : 0 aucun, 1 gauche, 2 droit
    s16 armTimer;           // minuteur de clignotement ($387A), ARM_BLINK_FRAMES puis -1 par frame
    s16 speedLvl;           // niveau de vitesse ($3954) : 4 au départ, +2 par cloche bleue (max 18), -2 par cloche noire ; vitesse = 0x80 + niveau * 0x40 (table $C91D)
    s16 flags;              // bonus ($3438) : voir PW_*
    s16 barrier;            // barrière de la cloche rouge ($34AE) : coups restants (10 au ramassage)
    s16 shotTw, shot2Tw;    // le tir en vol est un tir double (sprite et boîte de collision plus larges)
    s16 active;             // joueur présent dans la partie (le joueur 2 n'y entre qu'avec RUN / START de la manette 2)
    s16 armHidden;          // bras non dessinés cette frame (bit 0 gauche, bit 1 droit) : sert à la vérification
    s16 sideOn[2], sideX[2], sideY[2], sideDx[2];   // tirs latéraux du ventilateur
    s16 shield;             // bouclier ($A0 bit 4) : frames restantes
} PlayerState;

extern PlayerState players[2];
#define player players[0]       // joueur 1 : accès historique
extern s16 playerCur;            // joueur visé par PLAYER_contact / PLAYER_kill

void PLAYER_init(void);
void PLAYER_continue(s16 n);               // reprise après Continue : 2 vies, retour par le bas
void PLAYER_join(void);                    // entrée du joueur 2
void PLAYER_collide(void);                 // les deux vaisseaux se repoussent (à appeler après les PLAYER_update)
void PLAYER_update(s16 n, u16 joy, u16 frame);   // logique d'une frame du joueur n
void PLAYER_updateDemo(const u8 target[2], u16 joy, u16 frame);
void PLAYER_draw(s16 n);
void PLAYER_bombArm(s16 n, s16 lane);       // la main de la voie (0 gauche, 1 droite) tient la bombe 8 images
s16 PLAYER_contact(bool armZone, bool enemyLeft);   // armZone : les 3 derniers pixels de la boîte ; enemyLeft : ennemi à gauche du joueur
void PLAYER_kill(void);                    // contact avec un ennemi (sans effet si invincible ou déjà touché)                    // position des sprites

#endif
