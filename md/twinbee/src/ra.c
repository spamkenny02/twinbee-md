#include "ra.h"
u8 raWork[RA_WORK_SIZE];

static void unz(const u8* s, const u8* se, u8* d)
{
    for (;;)
    {
        const u8 tok = *s++;
        u16 ll = tok >> 4, ml = tok & 15;
        if (ll == 15) { u8 b; do { b = *s++; ll += b; } while (b == 255); }
        while (ll--) *d++ = *s++;
        if (s >= se) break;
        {
            const u8* m = d - (s[0] | (s[1] << 8)); s += 2;
            if (ml == 15) { u8 b; do { b = *s++; ml += b; } while (b == 255); }
            ml += 4;
            while (ml--) *d++ = *m++;
        }
    }
}

void RA_block(const RAArr* a, u16 b, u8* dst)
{
    if ((u32) b * RA_BLKSZ >= a->len) { u16 i; for (i = 0; i < RA_BLKSZ; i++) dst[i] = 0; return; }       // au-delà de la fin (trajectoire finie) : zéros
    unz(a->z + a->o[b], a->z + a->o[b + 1], dst);
}
