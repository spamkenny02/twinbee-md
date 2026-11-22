// Boss du stage 2 (galion) : plan B rejoué depuis la PCE (tilemap 64x64 par diffs, scroll X/Y par frame)
#include "boss2.h"
#include "resources.h"
#include "ra.h"

u16 bat[4096];       // copie du BAT PCE (valeur = tile | palette << 12)
static u16 keyPos;
static s16 lastTop;

// flux séquentiel compressé (voir tools/b2pack.py) : tampon de 256 o, relu mot par mot
static u8 zb[256];
static u16 zpos, zlen;
static const u8* zs;
static s16 curT, curX, curY;
static u16 rdW(void)
{
    u16 v;
    if (zpos >= zlen)
    {
        const u16 clen = (u16) ((zs[0] << 8) | zs[1]);
        u16 n = 0;
        if (clen) { RA_unz(zs + 2, zs + 2 + clen, zb); zs += 2 + clen; n = 256; }
        zlen = n; zpos = 0;
        if (!clen) return 0;
    }
    v = (zb[zpos] << 8) | zb[zpos + 1]; zpos += 2;
    return v;
}

static u16 attr(u16 v) { return TILE_ATTR_FULL((v >> 12) & 1, FALSE, FALSE, FALSE, TILE_USER_INDEX + (v & 0xFFF)); }

static void writeRow(u16 r)     // ligne r (0..63) du BAT PCE -> ligne r & 31 du plan
{
    u16 row[64], i;
    for (i = 0; i < 64; i++) row[i] = attr(bat[r * 64 + i]);
    VDP_setTileMapDataRect(BG_B, row, 0, r & 31, 64, 1, 64, CPU);
}

void BOSS2_start(void)
{
    u16 i;
    VDP_loadTileSet(&boss2_tileset, TILE_USER_INDEX, DMA);
    for (i = 0; i < BOSS2_NCOL; i++) PAL_setColor(boss2_colors[i][0], boss2_colors[i][1]);
    PAL_setColor(0, BOSS2_BACKDROP); PAL_setColor(16, BOSS2_BACKDROP);
    for (i = 0; i < 4096; i++) bat[i] = boss2_bat0[i];
    keyPos = 0; lastTop = -1;
    zs = boss2_stream; zpos = zlen = 0; curT = -1;
}

void BOSS2_update(u16 t)
{
    s16 y, x, top, k;
    if (t >= BOSS2_FRAMES) t = BOSS2_FRAMES - 1;
    while (curT < (s16) t)          // une frame du flux : scroll X, scroll Y, keyframes (liste de diffs du BAT)
    {
        u16 nk = 0;
        curT++;
        curX = rdW(); curY = rdW(); nk = rdW();
        while (nk--)
        {
            u16 n = rdW();
            top = (curY >> 3) & 63;
            while (n--)
            {
                const u16 idx = rdW(); bat[idx] = rdW();
                if (((((idx >> 6) - top) & 63) < 28) && (lastTop >= 0)) { u16 col = idx & 63; VDP_setTileMapXY(BG_B, attr(bat[idx]), col, (idx >> 6) & 31); }
            }
        }
    }
    y = curY; x = curX; top = (y >> 3) & 63;
    if (lastTop < 0) { for (k = 0; k < 28; k++) writeRow((top + k) & 63); lastTop = top; }
    else
    {
        while (lastTop != top)
        {
            if (((top - lastTop) & 63) < 32) { lastTop = (lastTop + 1) & 63; writeRow((lastTop + 27) & 63); }
            else { lastTop = (lastTop - 1) & 63; writeRow(lastTop); }
        }
    }
    VDP_setHorizontalScroll(BG_B, -x);
    VDP_setVerticalScroll(BG_B, y & 255);
}
