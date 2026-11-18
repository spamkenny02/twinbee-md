// types communs des ennemis rejoués (stages 2 et suivants)
#ifndef E2TYPES_H
#define E2TYPES_H
#include <genesis.h>
#include "resources.h"
#define E2_MAX_PIECES 12
typedef struct { u8 cls, img, flip; s8 dx, dy; } E2Piece;
typedef struct { u8 n; E2Piece p[E2_MAX_PIECES]; } E2Frame;
typedef struct { u32 off; u16 len; u16 roff; } E2Tpl;
typedef struct { s16 t0; u8 ty; s16 x, y; u16 tpl; } E2Inst;
typedef struct { s16 frame, x, y; } E2Bul;
typedef struct {
    const E2Frame* frames; const E2Tpl* tpl; const s8 *pdx, *pdy; const u8 *pi; const u16 *rf; const u8 *rl;
    const E2Inst* inst; u16 nInst; const u8 *hw, *hh; const E2Bul* bul; u16 nBul;
    const SpriteDefinition* spr[4]; u8 pool[4];
} E2Data;
#endif
