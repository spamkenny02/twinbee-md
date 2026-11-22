// Intro : logo Konami (images fixes), puis vol de TwinBee dans les nuages qui défilent, le ciel passe du jour à la nuit étoilée
// (fond en dégradé de CRAM, nuages/étoiles/abeille en sprites : tout est animé image par image).
#include <genesis.h>
#include "intro.h"
#include "resources.h"

#define NCLOUD 6
#define NSTAR  22
#define SKY_FRAMES 520

static bool logo(const Image *img, u16 frames, bool fadeIn)
{
    u16 prev = JOY_readJoypad(JOY_1);
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_drawImageEx(BG_B, img, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, TILE_USER_INDEX), 0, 0, FALSE, TRUE);
    SYS_doVBlankProcess();
    if (fadeIn) PAL_fadeIn(0, 15, img->palette->data, 20, FALSE);
    else PAL_setPalette(PAL0, img->palette->data, CPU);
    for (u16 f = 0; f < frames; f++)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        if ((joy & BUTTON_START) && !(prev & BUTTON_START)) return TRUE;
        prev = joy;
        SYS_doVBlankProcess();
    }
    return FALSE;
}

static u16 mix(u16 a, u16 b, u16 t, u16 n)       // mélange de deux couleurs MD (0000BBB0GGG0RRR0) à t/n
{
    u16 r = 0, k;
    for (k = 0; k < 3; k++)
    {
        const s16 ca = (a >> (1 + 4 * k)) & 7, cb = (b >> (1 + 4 * k)) & 7;
        r |= (u16)(ca + ((cb - ca) * (s16) t) / (s16) n) << (1 + 4 * k);
    }
    return r;
}

static bool sky(void)
{
    static const u16 DAY = 0x0EC0 | 0x0000, DUSK = 0x0E62, NIGHT = 0x0000;      // cyan, bleu crépuscule, noir
    Sprite *cl[NCLOUD], *st[NSTAR], *bee;
    s16 cx[NCLOUD], cy[NCLOUD], sx[NSTAR], sy[NSTAR];
    u16 prev = JOY_readJoypad(JOY_1), seed = 12345, i, f;
    bool skipped = FALSE;

    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    PAL_setPalette(PAL1, intro_cloud.palette->data, CPU);
    PAL_setPalette(PAL2, intro_bee.palette->data, CPU);
    PAL_setPalette(PAL3, intro_star.palette->data, CPU);
    for (i = 0; i < NCLOUD; i++)
    {
        seed = seed * 25173 + 13849; cx[i] = (seed >> 3) % 224; cy[i] = i * 44 - 40;
        cl[i] = SPR_addSprite(&intro_cloud, cx[i], cy[i], TILE_ATTR(PAL1, FALSE, FALSE, FALSE));
    }
    for (i = 0; i < NSTAR; i++)
    {
        seed = seed * 25173 + 13849; sx[i] = (seed >> 4) % 248; seed = seed * 25173 + 13849; sy[i] = (seed >> 4) % 224;
        st[i] = SPR_addSprite(&intro_star, 320, -32, TILE_ATTR(PAL3, FALSE, FALSE, FALSE));
        if (st[i]) SPR_setFrame(st[i], i % 3);
    }
    bee = SPR_addSprite(&intro_bee, 112, 300, TILE_ATTR(PAL2, FALSE, FALSE, FALSE));
    if (bee) SPR_setDepth(bee, SPR_MIN_DEPTH);
    for (f = 0; f < SKY_FRAMES; f++)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        u16 bg;
        if ((joy & BUTTON_START) && !(prev & BUTTON_START)) { skipped = TRUE; break; }
        prev = joy;
        // fond : fondu d'entrée, jour -> crépuscule (170..250) -> nuit (330..410)
        if (f < 24) bg = mix(NIGHT, DAY, f, 24);
        else if (f < 170) bg = DAY;
        else if (f < 250) bg = mix(DAY, DUSK, f - 170, 80);
        else if (f < 330) bg = DUSK;
        else bg = (f < 410) ? mix(DUSK, NIGHT, f - 330, 80) : NIGHT;
        PAL_setColor(0, bg);
        if (f == 0) { PAL_setColor(0, NIGHT); }
        // nuages : 1 px par image vers le bas, recyclés tant que le jour dure, puis laissés sortir
        for (i = 0; i < NCLOUD; i++)
        {
            cy[i] += 1;
            if (cy[i] > 224) { if (f < 230) { seed = seed * 25173 + 13849; cx[i] = (seed >> 3) % 224; cy[i] = -32; } else cy[i] = 300; }
            if (cl[i]) SPR_setPosition(cl[i], cx[i], cy[i]);
        }
        // étoiles : apparaissent avec la nuit, scintillent toutes les 16 images, dérivent vers le bas (1 px / 2 images)
        for (i = 0; i < NSTAR; i++)
        {
            if (!st[i]) continue;
            if (f < 250 + i * 3) { SPR_setPosition(st[i], 320, -32); continue; }
            if (!(f & 1)) { sy[i]++; if (sy[i] > 224) sy[i] = -8; }
            SPR_setFrame(st[i], ((f >> 4) + i) % 3);
            SPR_setPosition(st[i], sx[i], sy[i]);
        }
        // TwinBee : monte de bas d'écran en 70 images puis flotte en 8 mouvant
        {
            s16 bx = 112 + (sinFix16((f * 6) & 1023) >> 5) * 1, by;
            if (f < 70) by = 230 - (f * 110) / 70; else by = 120;
            by += (sinFix16((f * 9) & 1023) >> 6);
            if (bee) SPR_setPosition(bee, bx, by);
        }
        SPR_update();
        SYS_doVBlankProcess();
    }
    for (i = 0; i < NCLOUD; i++) if (cl[i]) SPR_releaseSprite(cl[i]);
    for (i = 0; i < NSTAR; i++) if (st[i]) SPR_releaseSprite(st[i]);
    if (bee) SPR_releaseSprite(bee);
    SPR_update();
    return skipped;
}

void INTRO_run(void)
{
    VDP_setWindowVPos(FALSE, 0);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    if (logo(&intro_k1, 70, TRUE)) goto out;
    if (logo(&intro_k2, 110, FALSE)) goto out;
    sky();
out:
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
}
