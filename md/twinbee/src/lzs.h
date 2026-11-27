// Flux séquentiels compressés (LZ4 par blocs de 2 Ko, voir tools/lzspack.py) : un seul flux ouvert à la fois (boss N ou fin du stage 6).
#ifndef LZS_H
#define LZS_H
#include <genesis.h>
#define LZS_BLK 2048
#define LZS_MARGIN 512                 // octets garantis disponibles après LZS_ensure (> taille max d'une frame du flux)
extern const u8* lzs_rd;               // curseur de lecture
void LZS_open(const u8* z);            // (re)démarre au début du flux
void LZS_ensure(void);                 // à appeler avant de lire une frame

// Second flux indépendant (fond de la fin : tuiles, cartes, palettes), tampon fourni par l'appelant.
// Permet de garder ouvert le flux de sprites (LZS_*) en même temps.
#define LZSB_CAP 4096
typedef struct { const u8* zs; u8* end; u8* rd; u8* mem; } LZSB;
void LZSB_open(LZSB* c, const u8* z, u8* buf);
const u8* LZSB_get(LZSB* c, u16 n);    // n octets contigus (n <= 2048), avance
#endif
