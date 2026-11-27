#include "lzs.h"
#include "ra.h"
#define buf raWork          // partagé avec les tampons des ennemis (voir ra.h)
static u8* end;
static const u8* zs;
static const u8* z0;
const u8* lzs_rd;

static void block(void)                // décompresse le bloc suivant à la suite de `end`
{
    const u16 clen = (u16) ((zs[0] << 8) | zs[1]);
    const u8* s; const u8* se; u8* d = end;
    if (!clen) return;
    s = zs + 2; se = s + clen; zs = se;
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
    end = d;
}

void LZS_open(const u8* z)
{
    z0 = zs = z; end = buf; lzs_rd = buf;
    block();
}

void LZS_ensure(void)
{
    u8* rd = (u8*) lzs_rd;
    if ((s32) (end - rd) >= LZS_MARGIN) return;
    {
        const u16 n = end - rd;
        u16 i;
        for (i = 0; i < n; i++) buf[i] = rd[i];       // recouvrement : copie vers l'avant
        end = buf + n; lzs_rd = buf;
        block();
    }
}

// --- second flux séquentiel indépendant (fond de la fin) ---
static void blockB(LZSB* c)
{
    const u16 clen = (u16) ((c->zs[0] << 8) | c->zs[1]);
    const u8* s; const u8* se; u8* d = c->end;
    if (!clen) return;
    s = c->zs + 2; se = s + clen; c->zs = se;
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
    c->end = d;
}

void LZSB_open(LZSB* c, const u8* z, u8* mem)
{
    c->zs = z; c->mem = mem; c->end = mem; c->rd = mem;
    blockB(c);
}

const u8* LZSB_get(LZSB* c, u16 n)     // n octets contigus (n <= 2048), avance
{
    u16 avail = (u16) (c->end - c->rd), i;
    if (avail < n)
    {
        for (i = 0; i < avail; i++) c->mem[i] = c->rd[i];
        c->end = c->mem + avail; c->rd = c->mem;
        while ((u16) (c->end - c->rd) < n)
        {
            const u16 before = (u16) (c->end - c->rd);
            blockB(c);
            if ((u16) (c->end - c->rd) == before) break;     // fin de flux (ne doit pas arriver)
        }
    }
    { const u8* p = c->rd; c->rd += n; return p; }
}
