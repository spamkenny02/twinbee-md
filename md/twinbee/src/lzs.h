// Flux séquentiels compressés (LZ4 par blocs de 2 Ko, voir tools/lzspack.py) : un seul flux ouvert à la fois (boss N ou fin du stage 6).
#ifndef LZS_H
#define LZS_H
#include <genesis.h>
#define LZS_BLK 2048
#define LZS_MARGIN 512                 // octets garantis disponibles après LZS_ensure (> taille max d'une frame du flux)
extern const u8* lzs_rd;               // curseur de lecture
void LZS_open(const u8* z);            // (re)démarre au début du flux
void LZS_ensure(void);                 // à appeler avant de lire une frame
#endif
