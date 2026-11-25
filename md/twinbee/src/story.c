// Scene d'histoire (princesse Melora) rejouee depuis la PC Engine (frames 2082-3099).
// Fond fixe 256x224 (une palette), orbe 16x16 qui monte du bas de l'ecran puis reste sur la poitrine,
// texte japonais en sprites 32x32 (18 elements) : silhouette noire, allumage couleur par couleur,
// flash blanc, puis fondu de sortie. Chronologie relevee sur les captures PCE (analysis/out).
#include <genesis.h>
#include "story.h"
#include "story_pal.h"
#include "story_pose.h"
#include "resources.h"
#include "mus.h"

#define ST_ORB_X      120
#define ST_ORB_Y0     216                 // sommet de l'orbe a la frame 2 (PCE 231 -> MD 216)
#define ST_ORB_Y1      88                 // position de repos (PCE 103 -> MD 88)
#define ST_ORB_RISE   128                 // 1 px par frame (2084 -> 2212)
#define ST_WAKE_F     144                 // PCE 2132 : la tete se releve (pose intermediaire)
#define ST_TEXT_F     160                 // apparition du texte + yeux ouverts (PCE 2148)
#define ST_COLOR_F    164                 // allumage des couleurs (PCE 2152, une toutes les 4 frames)
#define ST_FLASH1_F   192                 // PCE 2180
#define ST_FLASH2_F   196                 // PCE 2184 (blanc)
#define ST_FLASH3_F   200                 // PCE 2188
#define ST_FINAL_F    204                 // PCE 2192
#define ST_SLEEP_F    784                 // PCE 2772 : retour a la pose intermediaire avant le fondu
#define ST_BLINK_F    296                 // premier clignement (PCE 2284), puis toutes les 152 frames
#define ST_BLINK_PERIOD 152
#define ST_MOUTH_F    176                 // debut du cycle de bouche (PCE 2164)
#define ST_MOUTH_PERIOD 24                // 16 frames ouvertes, 8 fermees
#define ST_MOUTH_ON    16
#define ST_AUDIO_F     66                 // musique de scene : PCE 1979 = 1,1 s apres le START
#define ST_FADE_F     858                 // fondu du decor (PCE 2848)
#define ST_TEXT_OFF_F 890                 // le texte s'eteint couleur par couleur
#define ST_BLACK_F    906                 // PCE 2892 : ecran noir
#define ST_END_F      961                 // PCE 3004 : debut du stage 1

// tuiles des poses prechargees en VRAM, juste apres celles du decor
#define ST_POSE_BASE  (TILE_USER_INDEX + 512)


static u16 joyPrev;

static bool waitFrames(u16 n)
{
    while (n--)
    {
        const u16 joy = JOY_readJoypad(JOY_1);
        if ((joy & BUTTON_START) && !(joyPrev & BUTTON_START)) return TRUE;
        joyPrev = joy;
        SYS_doVBlankProcess();
    }
    return FALSE;
}

// interpole deux couleurs MD 9 bits (t = 0 -> a, 16 -> b)
static u16 blend(u16 a, u16 b, u16 t)
{
    const u16 r = ((((a >> 1) & 7) * (16 - t)) + (((b >> 1) & 7) * t)) >> 4;
    const u16 g = ((((a >> 5) & 7) * (16 - t)) + (((b >> 5) & 7) * t)) >> 4;
    const u16 bl = ((((a >> 9) & 7) * (16 - t)) + (((b >> 9) & 7) * t)) >> 4;
    return (u16) ((bl << 9) | (g << 5) | (r << 1));
}

static void setOrbPal(u16 t)
{
    u16 pal[16], i;
    if (t >= 16)
        PAL_setPalette(PAL3, story_orb.palette->data, CPU);
    else
    {
        for (i = 0; i < 16; i++) pal[i] = blend(story_orb_deep[i], story_orb.palette->data[i], t);
        PAL_setColors(48, pal, 16, CPU);
    }
}

// ordre d'allumage des couleurs du texte releve sur la PC Engine
static const u8 txtOrder[8] = { 0, 1, 2, 4, 5, 3, 6, 7 };

// etat de la palette du texte : nombre de couleurs allumees + mode flash
static void setTextPal(const u16* final, u16 on, u16 mode)
{
    u16 pal[16], i;
    pal[0] = 0;
    for (i = 1; i < 16; i++) pal[i] = 0;
    if (mode == 1)
    {
        for (i = 1; i < 16; i++) pal[i] = 0x0CCC;
        pal[1] = 0x0AAA;                            // le contour reste plus sombre pendant le flash
    }
    else if (mode == 2)
    {
        for (i = 1; i < 16; i++) pal[i] = 0x0EEE;
    }
    else
    {
        for (i = 1; (i <= on) && (i < 8); i++) pal[txtOrder[i]] = final[txtOrder[i]];
    }
    PAL_setColors(32, pal, 16, CPU);
}

// pose de la tete : remplace le bloc de tuiles (x13..18, y0..87) de BG_B
static void setPose(const u16* map)
{
    VDP_setTileMapDataRectEx(BG_B, map, TILE_ATTR_FULL(PAL1, FALSE, FALSE, FALSE, ST_POSE_BASE),
                             ST_POSE_X, ST_POSE_Y, ST_POSE_W, ST_POSE_H, ST_POSE_W, CPU);
}

// bouche : deux tuiles dans le bloc precedent (x15, y7)
static void setMouth(const u16* map)
{
    VDP_setTileMapDataRectEx(BG_B, map, TILE_ATTR_FULL(PAL1, FALSE, FALSE, FALSE, ST_POSE_BASE),
                             ST_MOUTH_X, ST_MOUTH_Y, ST_MOUTH_W, ST_MOUTH_H, ST_MOUTH_W, CPU);
}

static const u16* const poses[5] = { story_pose_A, story_pose_B, story_pose_C,
                                     story_pose_D, story_pose_E };

void STORY_run(void)
{
    static Sprite* txt[18];
    Sprite* orb;
    const u16* tpal = story_text.palette->data;
    u16 f, i, r, c, curPose = 0xFF, curMouth = 0xFF;

    joyPrev = JOY_readJoypad(JOY_1);
    SPR_initEx(320);                                 // 18 sprites de texte + l'orbe
    VDP_setWindowVPos(FALSE, 0);
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE); VDP_clearPlane(WINDOW, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_setBackgroundColor(0);
    VDP_setHorizontalScroll(BG_A, 0); VDP_setVerticalScroll(BG_A, 0);
    VDP_drawImageEx(BG_B, &story_bg, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, TILE_USER_INDEX), 0, 0, FALSE, TRUE);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    // poses de la tete : tuiles chargees des maintenant (ecran noir), 3 variantes
    VDP_loadTileData(story_pose_tiles, ST_POSE_BASE, ST_POSE_TILES, DMA);
    setPose(story_pose_A);                           // princesse endormie
    SYS_doVBlankProcess();

    orb = SPR_addSprite(&story_orb, ST_ORB_X, ST_ORB_Y0, TILE_ATTR(PAL3, FALSE, FALSE, FALSE));
    setOrbPal(0);

    for (f = 0; f < ST_END_F; f++)
    {
        // --- decor (fondu de sortie sur 8 paliers de 4 frames)
        if (f == 2)
        {
            PAL_setPalette(PAL0, story_bg.palette->data, CPU);
            PAL_setPalette(PAL1, story_pose_pal, CPU);       // palette propre a la tete
        }
        else if ((f >= ST_FADE_F + 4) && (f < ST_FADE_F + 36) && (((f - ST_FADE_F - 4) % 4) == 0))
        {
            const u16 s = 7 - ((f - ST_FADE_F - 4) >> 2);   // 7/8 puis 6/8 ... 0
            u16 pal[16];
            for (i = 0; i < 16; i++) pal[i] = blend(0, story_bg.palette->data[i], s * 2);
            PAL_setColors(0, pal, 16, CPU);
            for (i = 0; i < 16; i++) pal[i] = blend(0, story_pose_pal[i], s * 2);
            PAL_setColors(16, pal, 16, CPU);
            for (i = 0; i < 16; i++) pal[i] = blend(0, story_orb.palette->data[i], s * 2);
            PAL_setColors(48, pal, 16, CPU);
        }

        // --- orbe : monte de 1 px par frame, puis change de palette (bleu profond -> cyan clair)
        if (f >= 2)
        {
            s16 y = ST_ORB_Y0 - (s16) (f - 2);
            if (y < ST_ORB_Y1) y = ST_ORB_Y1;
            SPR_setPosition(orb, ST_ORB_X, y);
        }
        if ((f >= 78) && (f < 98) && ((f & 1) == 0))
            setOrbPal((f - 78) >> 1);
        else if (f == 98) setOrbPal(16);

        // --- tete : A endormie, B intermediaire, puis C eveillee avec clignements
        {
            u16 want = 0, mouth = 0;
            if ((f >= ST_WAKE_F) && (f < ST_TEXT_F)) want = 1;
            else if (f >= ST_SLEEP_F) want = 1;
            else if (f >= ST_TEXT_F)
            {
                if (f >= ST_BLINK_F)
                {
                    const u16 d = (f - ST_BLINK_F) % ST_BLINK_PERIOD;
                    want = (d < 8) ? 3 : ((d < 16) ? 4 : 2);
                }
                else want = 2;
                if (f >= ST_MOUTH_F)
                    mouth = (((f - ST_MOUTH_F) % ST_MOUTH_PERIOD) < ST_MOUTH_ON) ? 1 : 0;
            }
            if (want != curPose)
            {
                curPose = want;
                setPose(poses[want]);
                curMouth = 0xFF;                     // la pose a reecrit la zone de la bouche
            }
            if ((want >= 2) && (mouth != curMouth))
            {
                curMouth = mouth;
                setMouth(mouth ? story_mouth_alt : story_mouth_ref);
            }
        }

        // --- texte : silhouette noire puis allumage progressif
        if (f == ST_TEXT_F)
        {
            for (r = 0; r < 3; r++)
                for (c = 0; c < 6; c++)
                {
                    Sprite* s = SPR_addSprite(&story_text, 32 + c * 32, 124 + r * 32, TILE_ATTR(PAL2, FALSE, FALSE, FALSE));
                    txt[r * 6 + c] = s;
                    if (s) SPR_setAnimAndFrame(s, r, c);
                }
            setTextPal(tpal, 0, 0);
        }
        if ((f >= ST_COLOR_F) && (f < ST_COLOR_F + 28) && ((f - ST_COLOR_F) % 4 == 0))
            setTextPal(tpal, 1 + ((f - ST_COLOR_F) >> 2), 0);
        if ((f >= ST_FLASH1_F) && (f < ST_FLASH2_F)) setTextPal(tpal, 0, 1);
        if ((f >= ST_FLASH2_F) && (f < ST_FLASH3_F)) setTextPal(tpal, 0, 2);
        if ((f >= ST_FLASH3_F) && (f < ST_FINAL_F)) setTextPal(tpal, 0, 1);
        if (f == ST_FINAL_F) setTextPal(tpal, 7, 0);
        // extinction du texte, une couleur toutes les 2 frames (PCE 2972-2986)
        if ((f >= ST_TEXT_OFF_F) && (f < ST_TEXT_OFF_F + 14) && ((f - ST_TEXT_OFF_F) % 2 == 0))
            setTextPal(tpal, 6 - ((f - ST_TEXT_OFF_F) >> 1), 0);
        if (f == ST_BLACK_F) PAL_setColors(0, palette_black, 64, CPU);

        if (f == ST_AUDIO_F) MUS_storyCue();        // musique propre a la scene (PCE 1979-2921)

        SPR_update();
        if (waitFrames(1)) break;
    }

    MUS_storyCueStop();
    SPR_reset();
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE); VDP_clearPlane(WINDOW, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
}
