// Écran OPTION : décor PCE (res/opt.png, valeurs et curseur effacés) + valeurs en sprites PAL0.
// Relevé sur PC Engine (banc libretro, valeurs confirmées par la RAM) :
//   - curseur « > » statique, lignes espacées de 16 px (y = 52/68/84/100 en coordonnées MD) ;
//   - RANK : NORMAL -> EASY -> PRO -> HARD avec GAUCHE (DROITE inverse), bouclage ;
//   - CREDIT / PLAYER : 1..5, DROITE +1, GAUCHE -1, bouclage 5 <-> 1 ;
//   - SOUND : test de sons en hexadécimal 00..3E, bouclage (DROITE 3E -> 00, GAUCHE 00 -> 3E) ;
//   - SOUND : GAUCHE/DROITE changent la valeur en silence, la touche I joue l'entrée
//     (routine PCE : LDY $73 / LDA $C843,Y / JSR $E3FC, table relevée dans la ROM) ;
//   - HAUT/BAS changent de ligne en bouclant, RUN (= START) sort vers l'écran titre.
#include <genesis.h>
#include "option.h"
#include "opt_pal.h"
#include "mus.h"
#include "resources.h"

u8 optRank = 0, optCredit = 3, optPlayer = 3, optSound = 0;

#define OPT_CURSOR_X    64
#define OPT_CURSOR_Y    52
#define OPT_ROW_STEP    16
#define OPT_RANK_X      144
#define OPT_RANK_Y      52
#define OPT_CREDIT_X    168
#define OPT_CREDIT_Y    68
#define OPT_PLAYER_X    168
#define OPT_PLAYER_Y    84
#define OPT_SOUND_T_X   160
#define OPT_SOUND_X     168
#define OPT_SOUND_Y     100

static const SpriteDefinition* const rankDef[4] = { &opt_rank_normal, &opt_rank_easy, &opt_rank_pro, &opt_rank_hard };
static const SpriteDefinition* const hexDef[16] = { &opt_digit_0, &opt_digit_1, &opt_digit_2, &opt_digit_3, &opt_digit_4,
                                                     &opt_digit_5, &opt_digit_6, &opt_digit_7, &opt_digit_8, &opt_digit_9,
                                                     &opt_hex_a, &opt_hex_b, &opt_hex_c, &opt_hex_d, &opt_hex_e, &opt_hex_f };
static Sprite *sCursor, *sRank, *sCredit, *sPlayer, *sSoundT, *sSound;

static s8 wrap(s8 v, s8 d, s8 lo, s8 hi)
{
    v += d;
    if (v > hi) v = lo;
    if (v < lo) v = hi;
    return v;
}

// SOUND : 00..3E (63 sons), bouclage dans les deux sens
static u8 wrapSound(u8 d)
{
    if (d) { if (optSound == 0x3E) optSound = 0; else optSound++; }
    else   { if (optSound == 0) optSound = 0x3E; else optSound--; }
    return optSound;
}

// Table du test de son de la PC Engine (banque $15, $C843) : valeur affichée -> ID du driver
// sonore PCE. Vérifiée en émulation (00 -> 0B, 05 -> 19, 08 -> 1C, 19 -> 35).
static const u8 optSoundId[0x3F] = {
    0x0B, 0x3E, 0x11, 0x17, 0x18, 0x19, 0x1A, 0x1B,
    0x1C, 0x1D, 0x1E, 0x2D, 0x1F, 0x23, 0x20, 0x21,
    0x2B, 0x31, 0x22, 0x24, 0x26, 0x2E, 0x40, 0x2F,
    0x32, 0x35, 0x36, 0x37, 0x3C, 0x38, 0x28, 0x45,
    0x2C, 0x3A, 0x3B, 0x33, 0x34, 0x39, 0x29, 0x4D,
    0x53, 0x5B, 0x62, 0x67, 0x6C, 0x71, 0x7B, 0x80,
    0x87, 0x8C, 0x91, 0x97, 0x9D, 0xA3, 0x01, 0x02,
    0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x0A
};

// Joue l'entrée courante (touche I sur PCE = B sur MD, A accepté aussi).
// Les ID sans équivalent MD restent muets : bruitages PCE non portés (0B, 11, 1C, 1E, 20..26,
// 2B..2E, 32, 33, 36..3C, 45, 01..04, 06, 07, 0A) et pistes 97/9D absentes des 12 converties.
static void soundTestPlay(void)
{
    switch (optSoundId[optSound])
    {
        case 0x05: SFX_play(SFX_FALL);    break;
        case 0x08: SFX_play(SFX_RESP2);   break;
        case 0x17: SFX_play(SFX_SHOT);    break;
        case 0x18: SFX_play(SFX_BOMB);    break;
        case 0x19: SFX_play(SFX_BELLGET); break;
        case 0x1A: SFX_play(SFX_BELLHIT); break;
        case 0x1B: SFX_play(SFX_BOOM);    break;
        case 0x1D: SFX_play(SFX_BIG);     break;
        case 0x1F: SFX_play(SFX_BHIT);    break;
        case 0x28: SFX_play(SFX_POWER);   break;
        case 0x2F: SFX_play(SFX_DEATH1);  break;
        case 0x31: SFX_play(SFX_RESP1);   break;
        case 0x34: SFX_play(SFX_BDEAD);   break;
        case 0x35: SFX_play(SFX_BHIT2);   break;
        case 0x40: SFX_play(SFX_BXPL);    break;
        case 0x3E:                        // ID d'arrêt du driver PCE : coupe musique et bruitages
            MUS_stop();
            XGM2_stopPCM(SOUND_PCM_CH2); XGM2_stopPCM(SOUND_PCM_CH3);
            break;
        case 0x4D: MUS_play(MUS_STAGE1);  break;
        case 0x53: MUS_play(MUS_TITLE);   break;
        case 0x5B: MUS_play(MUS_STAGE1);  break;
        case 0x62: MUS_play(MUS_STAGE2);  break;
        case 0x67: MUS_play(MUS_STAGE3);  break;
        case 0x6C: MUS_play(MUS_STAGE4);  break;
        case 0x71: MUS_play(MUS_STAGE5);  break;
        case 0x7B: MUS_play(MUS_STAGE6);  break;
        case 0x80: MUS_play(MUS_BOSS_A);  break;
        case 0x87: MUS_play(MUS_BOSS_B);  break;
        case 0x8C: MUS_play(MUS_BOSS_6);  break;
        case 0x91: MUS_play(MUS_CLEAR);   break;
        case 0xA3: MUS_play(MUS_GAMEOVER);break;
    }
}

static void refreshValues(void)
{
    SPR_setDefinition(sRank, rankDef[optRank]);
    SPR_setDefinition(sCredit, hexDef[optCredit]);
    SPR_setDefinition(sPlayer, hexDef[optPlayer]);
    SPR_setDefinition(sSoundT, hexDef[optSound >> 4]);
    SPR_setDefinition(sSound, hexDef[optSound & 0xF]);
}

void OPTION_run(void)
{
    u16 prev = 0, prev2 = 0;
    u8 sel = 0;

    VDP_setWindowVPos(FALSE, 0);
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE); VDP_clearPlane(WINDOW, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    VDP_setBackgroundColor(0);
    VDP_drawImageEx(BG_B, &opt_image, TILE_ATTR_FULL(PAL0, FALSE, FALSE, FALSE, TILE_USER_INDEX), 0, 0, FALSE, TRUE);
    VDP_setHorizontalScroll(BG_B, 0); VDP_setVerticalScroll(BG_B, 0);
    SYS_doVBlankProcess();
    PAL_setColors(0, opt_pal, 64, CPU);

    // valeurs : indices 1 = noir, 2 = cyan clair dans la palette 0 (voir opt_pal.h)
    sCursor = SPR_addSprite(&opt_cursor, OPT_CURSOR_X, OPT_CURSOR_Y, TILE_ATTR(PAL0, FALSE, FALSE, FALSE));
    sRank = SPR_addSprite(rankDef[optRank], OPT_RANK_X, OPT_RANK_Y, TILE_ATTR(PAL0, FALSE, FALSE, FALSE));
    sCredit = SPR_addSprite(hexDef[optCredit], OPT_CREDIT_X, OPT_CREDIT_Y, TILE_ATTR(PAL0, FALSE, FALSE, FALSE));
    sPlayer = SPR_addSprite(hexDef[optPlayer], OPT_PLAYER_X, OPT_PLAYER_Y, TILE_ATTR(PAL0, FALSE, FALSE, FALSE));
    sSoundT = SPR_addSprite(hexDef[optSound >> 4], OPT_SOUND_T_X, OPT_SOUND_Y, TILE_ATTR(PAL0, FALSE, FALSE, FALSE));
    sSound = SPR_addSprite(hexDef[optSound & 0xF], OPT_SOUND_X, OPT_SOUND_Y, TILE_ATTR(PAL0, FALSE, FALSE, FALSE));
    refreshValues();

    prev = JOY_readJoypad(JOY_1); prev2 = JOY_readJoypad(JOY_2);     // ignore une touche deja tenue
    while (TRUE)
    {
        const u16 joy = JOY_readJoypad(JOY_1), joy2 = JOY_readJoypad(JOY_2);
        if (((joy & BUTTON_START) && !(prev & BUTTON_START)) || ((joy2 & BUTTON_START) && !(prev2 & BUTTON_START)))
            break;                                                              // RUN : retour au titre
        if ((joy & BUTTON_UP) && !(prev & BUTTON_UP))
        {
            sel = (sel == 0) ? 3 : sel - 1;
            SFX_play(SFX_CURSOR);
        }
        if ((joy & BUTTON_DOWN) && !(prev & BUTTON_DOWN))
        {
            sel = (sel == 3) ? 0 : sel + 1;
            SFX_play(SFX_CURSOR);
        }
        SPR_setPosition(sCursor, OPT_CURSOR_X, OPT_CURSOR_Y + OPT_ROW_STEP * sel);
        if ((joy & BUTTON_LEFT) && !(prev & BUTTON_LEFT))
        {
            if (sel == 0) optRank = (optRank == 3) ? 0 : optRank + 1;            // GAUCHE avance le rang
            if (sel == 1) optCredit = wrap(optCredit, -1, 1, 5);
            if (sel == 2) optPlayer = wrap(optPlayer, -1, 1, 5);
            if (sel == 3) wrapSound(0);
            refreshValues();
        }
        if ((joy & BUTTON_RIGHT) && !(prev & BUTTON_RIGHT))
        {
            if (sel == 0) optRank = (optRank == 0) ? 3 : optRank - 1;
            if (sel == 1) optCredit = wrap(optCredit, 1, 1, 5);
            if (sel == 2) optPlayer = wrap(optPlayer, 1, 1, 5);
            if (sel == 3) wrapSound(1);
            refreshValues();
        }
        // test de son : la touche I de la PCE (B sur MD, A accepté) joue l'entrée sélectionnée
        if (sel == 3 && (joy & (BUTTON_A | BUTTON_B)) && !(prev & (BUTTON_A | BUTTON_B)))
            soundTestPlay();
        prev = joy; prev2 = joy2;
        SPR_update();
        SYS_doVBlankProcess();
    }

    SPR_releaseSprite(sCursor);
    SPR_releaseSprite(sRank); SPR_releaseSprite(sCredit); SPR_releaseSprite(sPlayer);
    SPR_releaseSprite(sSoundT); SPR_releaseSprite(sSound);
    SPR_update();
    MUS_stop();                                     // coupe une piste lancée par le test de son
    VDP_clearPlane(BG_A, TRUE); VDP_clearPlane(BG_B, TRUE);
    PAL_setColors(0, palette_black, 64, CPU);
    SYS_doVBlankProcess();
}
