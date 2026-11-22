// Tableaux d'octets compressés en accès aléatoire (LZ4 par blocs de 128 o ; chaque ennemi garde son bloc courant, voir enemy.c) - voir tools/rapack.py
#ifndef RA_H
#define RA_H
#include <genesis.h>
typedef struct { const u8* z; const u32* o; u32 len; u16 id; } RAArr;     // o[b] = début du bloc b dans z (o[nbl] = fin)
#define RA_BLKSZ 64
void RA_block(const RAArr* a, u16 b, u8* dst);    // décompresse le bloc b (128 o) dans dst
// zone de travail commune (6 Ko) : tampons des ennemis rejoués OU tampon du flux compressé des boss/de la fin (jamais en même temps)
#define RA_WORK_SIZE 6144
extern u8 raWork[RA_WORK_SIZE];
#endif
