#!/usr/bin/env python3
"""Génère les ressources Mega Drive du projet md/twinbee à partir des extractions PCE :
sprites (PNG indexés + resources.res), tuiles du HUD (chiffres, jauge), tables C (nuages, défilement)."""
import sys, json, collections, numpy as np
sys.path.insert(0, 'tools'); import pcegfx
from PIL import Image
RES = 'md/twinbee/res/'; SRC = 'md/twinbee/src/'
S = np.load('extract/sprites_pce.npy', allow_pickle=True)[0]
S.update(np.load('extract/sprites_twin.npy', allow_pickle=True)[0])      # tir double
def rgb(c): return (((c >> 3) & 7) * 36, ((c >> 6) & 7) * 36, (c & 7) * 36)
def used(names):
    o = set()
    for n in names: o |= set(S[n][S[n] >= 0].tolist())
    return sorted(o)
FLAMES = ['halo0', 'halo1', 'halo2', 'c1a', 'c1b', 'c2s_a', 'c2s_b', 'c2m_a', 'c2m_b', 'c2t_a', 'c2t_b']
P2 = ['body', 'bodyR', 'arm', 'bellA', 'bellB', 'pop500'] + FLAMES   # palette 2 : vaisseau, cloches, flammes
P3 = ['cloudA', 'cloudB', 'shot', 'shotT', 'impA', 'impB']                     # palette 3 : nuages, tir normal (avec le HUD)
pal2 = used(P2); assert len(pal2) <= 15, ('PAL2', len(pal2))
hud = Image.open(RES + 'hud.png'); hp = hud.getpalette(); NH = 7
pal3 = [tuple(hp[i * 3:i * 3 + 3]) for i in range(1, NH + 1)]
G = np.load('extract/gauge_pce.npy', allow_pickle=True)[0]
for c in sorted(G):
    for px in G[c].reshape(-1, 3):
        t = tuple((int(v) >> 5) * 36 for v in px)
        if t not in pal3: pal3.append(t)
for c in used(P3):
    if rgb(c) not in pal3: pal3.append(rgb(c))
assert len(pal3) <= 15, ('PAL3', len(pal3))
# Sprites sans palette propre (ennemis, explosions) : on complète PAL2 avec les couleurs qui réduisent le plus l'erreur,
# puis chaque couleur restante est remplacée par la plus proche.
APPROX = ['enA', 'enB', 'enC', 'ex0', 'ex1', 'ex2', 'ex3']
def dist(a, b): return sum((x - y) ** 2 for x, y in zip(rgb(a), rgb(b)))
need = collections.Counter()
for n in APPROX:
    for c in S[n][S[n] >= 0].tolist(): need[c] += 20 if n.startswith('en') else 1      # priorité aux ennemis, plus longtemps à l'écran
while len(pal2) < 15:
    gain = {c: sum(k * min(dist(q, p) for p in pal2) for q, k in need.items()) - sum(k * min(dist(q, p) for p in pal2 + [c]) for q, k in need.items()) for c in need if c not in pal2}
    if not gain or max(gain.values()) <= 0: break
    pal2.append(max(gain, key=gain.get))
S.update(np.load('extract/sprites34.npy', allow_pickle=True)[0])      # navettes-navets (types 3 et 4) : couleurs approchées par PAL2 sans la modifier
S.update(np.load('extract/sprites7.npy', allow_pickle=True)[0])       # type 7 (nacelles en formation)
S.update(np.load('extract/sprites8.npy', allow_pickle=True)[0])
S.update(np.load('extract/sprites6.npy', allow_pickle=True)[0])
S.update(np.load('extract/sprites910.npy', allow_pickle=True)[0])     # types 9 (soucoupes) et 10 (vaisseaux en formation, 32x16)
S.update(np.load('extract/sprites_gnd.npy', allow_pickle=True)[0])    # ennemis au sol (types 13/14/15) et bombe
S.update(np.load('extract/sprites11.npy', allow_pickle=True)[0])      # type 11 (mi-boss) et 12 (ses projectiles)      # type 6 (spirale)       # type 8 (vaisseaux en demi-tour)
# cloches colorées (ramassages) : la couleur change les 3 teintes du corps (PCE : palette de sprite 0 = jaune, 1 bleu, 5 noire, 7 blanche, 3 verte, 4 rouge, 6 violette)
def _code(rgbs): r, g, b = (int(ch) for ch in rgbs); return (g << 6) | (r << 3) | b
BELL_YEL = [_code('741'), _code('761'), _code('421')]
BELL_COLS = {1: ('127', '057', '114'), 2: ('222', '333', '111'), 3: ('446', '667', '223'), 4: ('153', '175', '122'), 5: ('711', '733', '411'), 6: ('114', '125', '112')}      # violette PCE = 526/637/223, approchée ici par des bleus sombres (PAL2 n'a pas de magenta ; le plus proche automatique la rendait grise, comme la blanche)
   # code cloche (octet $35EC) -> teintes
BELLV = []
for k, cols in BELL_COLS.items():
    for f in ('A', 'B'):
        mp = dict(zip(BELL_YEL, [_code(c) for c in cols]))
        S['bellv%d%s' % (k, f)] = np.vectorize(lambda c: mp.get(int(c), int(c)) if c >= 0 else -1)(S['bell' + f])
        BELLV.append('bellv%d%s' % (k, f))
_p = np.full((32, 32), -1, S['ex0'].dtype); _p[7:23, 8:24] = S['ex0']; S['ex0p'] = _p      # petite boule d'explosion dans une image 32x32 (une seule feuille par explosion)
M34 = ['e3a', 'e3b', 'e4a', 'e4b', 'e7a', 'e7b', 'e8a', 'e8b', 'e6a', 'e12', 'e11a', 'e11b', 'e11c', 'e9a', 'e9b', 'e9c', 'e9d', 't10_19', 't10_20', 't10_21', 't10_22', 't10_23', 'g13a', 'g13b', 'g14a', 'g14b', 'bomb', 'orb'] + BELLV
for n in M34:
    for c in S[n][S[n] >= 0].tolist(): need[c] += 0
approx_map = {c: min(pal2, key=lambda p: dist(c, p)) for c in need}
print('couleurs approchées (PCE -> PAL2) :', ', '.join('%03X->%03X' % (c, m) for c, m in sorted(approx_map.items()) if c != m) or 'aucune')
i2 = {c: i + 1 for i, c in enumerate(pal2)}
for c, m in approx_map.items(): i2.setdefault(c, i2[m]); i3 = {c: pal3.index(rgb(c)) + 1 for c in used(P3)}
p2 = [255, 0, 255] + [v for c in pal2 for v in rgb(c)]; p2 += [0] * (768 - len(p2))
p3 = [0, 0, 0] + [v for t in pal3 for v in t]; p3 += [0] * (768 - len(p3))
hud.putpalette(p3); hud.save(RES + 'hud.png')
res = ['TILESET stage1_tileset "stage1.png" BEST ALL', 'MAP stage1_map "stage1.png" stage1_tileset BEST 0', 'IMAGE hud_image "hud.png" NONE ALL', 'TILESET hud_tiles "hud_tiles.png" NONE NONE', 'IMAGE title_image "title.png" NONE ALL']
def sheet(name, frames, lut, palette):
    h, w = S[frames[0]].shape; im = np.zeros((h, w * len(frames)), np.uint8)
    for k, f in enumerate(frames): im[:, k * w:(k + 1) * w] = np.vectorize(lambda c: 0 if c < 0 else lut[c])(S[f])
    o = Image.fromarray(im, 'P'); o.putpalette(palette); o.save(RES + name + '.png')
    res.append('SPRITE %s "%s.png" %d %d NONE 0' % (name, name, w // 8, h // 8))
p3v = [255, 0, 255] + p3[3:]
for name, frames, pl in [('spr_body', ['body', 'bodyR'], 2), ('spr_arm', ['arm'], 2), ('spr_bell', ['bellA', 'bellB'] + BELLV, 2), ('spr_pop500', ['pop500'], 2), ('spr_orb', ['orb'], 2),
                         ('spr_halo', ['halo0', 'halo1', 'halo2'], 2), ('spr_c1', ['c1a', 'c1b'], 2), ('spr_c2s', ['c2s_a', 'c2s_b'], 2),
                         ('spr_c2m', ['c2m_a', 'c2m_b'], 2), ('spr_c2t', ['c2t_a', 'c2t_b'], 2),
                         ('spr_enemy', ['enA', 'enB', 'enC', 'e3a', 'e3b', 'e7a', 'e7b', 'e8a', 'e8b', 'e6a', 'e12', 'e11a', 'e9a', 'e9b', 'e9c', 'e9d', 'g13a', 'g13b', 'g14a', 'g14b', 'bomb'], 2), ('spr_en10', ['t10_19', 't10_20', 't10_21', 't10_22', 't10_23'], 2), ('spr_en4', ['e4a', 'e4b', 'e11b', 'e11c'], 2), ('spr_ex0', ['ex0'], 2), ('spr_exm', ['ex0p', 'ex1', 'ex2', 'ex3'], 2), ('spr_ex', ['ex1', 'ex2', 'ex3'], 2),
                         ('spr_shot', ['shot', 'shotT'], 3), ('spr_imp', ['impA', 'impB'], 3), ('spr_cloud', ['cloudA', 'cloudB'], 3)]:
    lut, palette = (i2, p2) if pl == 2 else (i3, p3v)
    sheet(name, frames, lut, palette)
import mkboss
res += mkboss.build(RES, SRC)
import mkbossfx
res += mkbossfx.build(RES, SRC)
import mkbarrier
res += mkbarrier.build(RES, SRC)
res += ['TILESET stage2_tileset "stage2.png" BEST ALL', 'MAP stage2_map "stage2.png" stage2_tileset BEST 0']
res += ['TILESET stage3_tileset "stage3.png" BEST ALL', 'MAP stage3_map "stage3.png" stage3_tileset BEST 0']
res += ['TILESET stage4_tileset "stage4.png" BEST ALL', 'MAP stage4_map "stage4.png" stage4_tileset BEST 0']
res += ['TILESET stage5_tileset "stage5.png" BEST ALL', 'MAP stage5_map "stage5.png" stage5_tileset BEST 0']
res += ['TILESET boss2_tileset "boss2.png" NONE NONE']
res += ['TILESET stage6_tileset "stage6.png" BEST ALL', 'MAP stage6_map "stage6.png" stage6_tileset BEST 0']
open(RES + 'resources.res', 'w').write('\n'.join(res) + '\n')

# ---- tuiles du HUD : vide, chiffres 0-9, jauge (5 tuiles x 6 états)
def to_idx(a):   # image RGB 8 bits -> index PAL3 (HUD opaque : jamais 0)
    out = np.zeros(a.shape[:2], np.uint8)
    for y in range(a.shape[0]):
        for x in range(a.shape[1]):
            t = tuple(int(v) >> 5 for v in a[y, x]); m = [i + 1 for i, c in enumerate(pal3) if tuple(v >> 5 for v in c) == t]
            assert m, ('couleur HUD absente de PAL3', a[y, x]); out[y, x] = m[0]
    return out
tiles = []
def add(t):
    for i, u in enumerate(tiles):
        if (u == t).all(): return i
    tiles.append(t); return len(tiles) - 1
black = to_idx(np.zeros((8, 8, 3), np.uint8)); T_BLANK = add(black)
# chiffres : tuiles de la police en VRAM, repérées par comparaison avec le « 0 » du score de la capture
vram, sat, pal, reg = pcegfx.load('dumps/s1/s03000'); t8 = pcegfx.tiles8(vram); bat = vram[:4096]
hsrc = np.array(Image.open('extract/hud_src.png').resize((256, 16), Image.NEAREST))
zero = (hsrc[8:16, 104:112].sum(2) > 0)
cands = []
for t in range(2048):
    vals, cnt = np.unique(t8[t], return_counts=True)
    if len(vals) > 1 and ((t8[t] != vals[cnt.argmax()]) == zero).all(): cands.append(t)
assert cands, 'tuile du 0 introuvable'; t0 = cands[0]
bp = [int(e >> 12) for e in bat if (e & 0x7FF) == t0]; bp = bp[0] if bp else 0
col = pcegfx.rgb(pal)
digits = [add(to_idx(col[bp * 16 + t8[t0 + d]].astype(np.uint8))) for d in range(10)]
def gauge_tile(i, state):   # state 0..4 = remplissage 0,2,4,6,8 px ; 5 = jauge pleine (blanche)
    if state == 5: return to_idx(G[40][:, 8 + 8 * i:16 + 8 * i])
    empty = G[0][:, 8 + 8 * i:16 + 8 * i]; full = G[39][:, 8 + 8 * min(i, 3):16 + 8 * min(i, 3)]   # motif bleu identique sur toute la jauge
    return to_idx(np.hstack([full[:, :2 * state], empty[:, 2 * state:]]))
# contrôle : les tuiles reconstruites redonnent bien les jauges observées
for c in G:
    if c == 40: continue
    w = c & ~1; rebuilt = np.hstack([np.hstack([G[39][:, 8 + 8 * min(i, 3):16 + 8 * min(i, 3)][:, :max(0, min(8, w - 8 * i))], G[0][:, 8 + 8 * i:16 + 8 * i][:, max(0, min(8, w - 8 * i)):]]) for i in range(5)])
    assert (rebuilt == G[c][:, 8:48]).all(), ('jauge', c)
gauge = [[add(gauge_tile(i, s)) for s in range(6)] for i in range(5)]
im = np.hstack(tiles); o = Image.fromarray(im, 'P'); o.putpalette(p3); o.save(RES + 'hud_tiles.png')

# ---- tables C
clouds = json.load(open('extract/clouds_stage1.json')); cum = np.load('extract/scroll_stage1.npy'); d = np.diff(cum)
assert d.min() >= 0 and d.max() <= 15
packed = [int(d[i]) | (int(d[i + 1]) << 4 if i + 1 < len(d) else 0) for i in range(0, len(d), 2)]
with open(SRC + 'stage1_data.h', 'w') as f:
    f.write('// Généré par tools/mkassets.py à partir des traces PC Engine du stage 1 (frame 0 = frame 2880 de la trace)\n#ifndef STAGE1_DATA_H\n#define STAGE1_DATA_H\n#include <genesis.h>\n\n')
    f.write('#define HUD_TILE_BLANK %d\nstatic const u8 hud_digit_tiles[10] = {%s};\n' % (T_BLANK, ', '.join(map(str, digits))))
    f.write('// jauge de charge : 5 tuiles, états 0..4 = 0,2,4,6,8 px remplis, 5 = jauge pleine\nstatic const u8 hud_gauge_tiles[5][6] = {%s};\n\n' % ', '.join('{' + ', '.join(map(str, g)) + '}' for g in gauge))
    sys.path.insert(0, 'tools'); import enemy_sim
    f.write('// ennemi de la vague 1 : vitesses 8.8 (routine $4111, table de sinus $FEB8) ; 32 angles à la vitesse $12 (approche), puis à la vitesse de virage $20\n')
    f.write('static const s16 enemy_vel_slow[32][2] = {%s};\nstatic const s16 enemy_vel[32][2] = {%s};\n\n' % (', '.join('{%d, %d}' % enemy_sim.velocity(a, 0x12) for a in range(32)), ', '.join('{%d, %d}' % enemy_sim.velocity(a, 0x20) for a in range(32))))
    en = json.load(open('extract/enemies5_stage1.json'))
    f.write('// ennemis de type 3 et 4 : vitesse constante $22\nstatic const s16 missile_vel[32][2] = {%s};\n\n' % ', '.join('{%d, %d}' % enemy_sim.velocity(a, 34) for a in range(32)))
    f.write('// visée (routine $4030) : table d\'arc tangente 8x8 et décalage par quadrant\nstatic const u8 aim_atan[64] = {%s};\nstatic const u8 aim_quad[4] = {%s};\n\n' % (', '.join(map(str, enemy_sim._atan)), ', '.join(map(str, enemy_sim._quad))))
    f.write('// ennemis de type 5 du stage : frame d\'apparition (frame PCE - 2880), drapeau (bit 1 = par la droite, bit 0 = vise le joueur), groupe de 6\n')
    f.write('typedef struct { s16 frame; u8 flags; u8 group; } EnemySpawn;\n#define STAGE1_NUM_ENEMIES %d\n#define STAGE1_NUM_GROUPS %d\nstatic const EnemySpawn stage1_enemies[STAGE1_NUM_ENEMIES] = {\n' % (len(en), en[-1][2] + 1))
    for e in en: f.write('    {%d, %d, %d},\n' % tuple(e))
    f.write('};\n\n')
    import pickle
    ev = pickle.load(open('extract/ev34.pkl', 'rb'))
    f.write('// ennemis de type 3 (petit) et 4 (haut) : frame d\'apparition (frame PCE - 2880), x de départ (y = -32), type ; ils visent le joueur à l\'apparition\n')
    f.write('typedef struct { s16 frame; s16 x; u8 kind; } MissileSpawn;\n#define STAGE1_NUM_MISSILES %d\nstatic const MissileSpawn stage1_missiles[STAGE1_NUM_MISSILES] = {\n' % len(ev))
    for e in sorted(ev, key=lambda e: e[0]): f.write('    {%d, %d, %d},\n' % (e[0] - 2880, int(e[4]), e[2]))
    f.write('};\n\n')
    ev7 = pickle.load(open('extract/ev7.pkl', 'rb'))
    f.write('// ennemis de type 7 : frame d\'apparition (frame PCE - 2880), indicateur (bit 0 : arrive par la droite, x = 192)\n')
    f.write('typedef struct { s16 frame; u8 flags; } Pod7Spawn;\n#define STAGE1_NUM_POD7 %d\nstatic const Pod7Spawn stage1_pod7[STAGE1_NUM_POD7] = {\n' % len(ev7))
    for e in sorted(ev7, key=lambda e: e[0]): f.write('    {%d, %d},\n' % (e[0] - 2880, e[2]))
    f.write('};\n\n')
    ev8 = pickle.load(open('extract/ev8.pkl', 'rb')) + [(8300, 81, 1)]       # apparition absente de la partie cc (emplacements pleins), relevée sur la partie cb
    f.write('// ennemis de type 8 : frame d\'apparition (frame PCE - 2880), indicateur (bit 0 : arrive par la droite) ; ils tournent d\'un cran toutes les 3 frames (vitesse $24)\n')
    f.write('typedef struct { s16 frame; u8 flags; } Ship8Spawn;\n#define STAGE1_NUM_SHIP8 %d\nstatic const Ship8Spawn stage1_ship8[STAGE1_NUM_SHIP8] = {\n' % len(ev8))
    for e in sorted(ev8, key=lambda e: e[0]): f.write('    {%d, %d},\n' % (e[0] - 2880, e[2]))
    f.write('};\n')
    ev6 = pickle.load(open('extract/ev6.pkl', 'rb'))
    f.write('// ennemis de type 6 : frame d\'apparition (frame PCE - 2880), indicateur (bit 0 : arrive par la droite) ; vitesse $26\ntypedef struct { s16 frame; u8 flags; } Pod6Spawn;\n#define STAGE1_NUM_POD6 %d\nstatic const Pod6Spawn stage1_pod6[STAGE1_NUM_POD6] = {\n' % len(ev6))
    for e in sorted(ev6, key=lambda e: e[0]): f.write('    {%d, %d},\n' % (e[0] - 2880, e[2]))
    f.write('};\n')
    ev12 = pickle.load(open('extract/ev12v.pkl', 'rb'))
    f.write('// mi-boss (type 11) : frames d\'apparition (frame PCE - 2880) ; ses projectiles (type 12) : frame, x, y (8.8), vitesse 8.8, indice (< 12 : convergent vers le boss pendant 80 frames)\n')
    f.write('#define STAGE1_NUM_BOSS11 2\nstatic const s16 stage1_boss11[2] = {%d, %d};\n' % (6691 - 2880, 14787 - 2880))
    f.write('typedef struct { s16 frame; s32 x, y; s16 vx, vy; u8 idx; } Bul12Spawn;\n#define STAGE1_NUM_BUL12 %d\nstatic const Bul12Spawn stage1_bul12[STAGE1_NUM_BUL12] = {\n' % len(ev12))
    for e in sorted(ev12): f.write('    {%d, %d, %d, %d, %d, %d},\n' % ((e[0] - 2880,) + tuple(e[1:])))
    f.write('};\n')
    eb = sorted({(k[0] - 2880, k[1], k[2]) for k, v in pickle.load(open('extract/ebul.pkl', 'rb'))})
    f.write('// tirs ennemis génériques (objets 48..65, type 1, vitesse 319/256 en 32 directions) : frame (PCE - 2880), position de l\'ennemi tireur (relevés sur toutes les traces, fixes d\'une partie à l\'autre)\n')
    f.write('typedef struct { s16 frame; s16 x, y; } EBulSpawn;\n#define STAGE1_NUM_EBUL %d\nstatic const EBulSpawn stage1_ebul[STAGE1_NUM_EBUL] = {\n' % len(eb))
    for e in eb: f.write('    {%d, %d, %d},\n' % e)
    f.write('};\n')
    import math
    f.write('static const s16 ebul_vel[32][2] = {%s};\n' % ', '.join('{%d, %d}' % (round(319 * math.cos(a * math.pi / 16)), round(319 * math.sin(a * math.pi / 16))) for a in range(32)))
    ev910 = pickle.load(open('extract/ev910.pkl', 'rb'))
    f.write('// ennemis de type 9 (soucoupes, routine $65FE) : frame d\'apparition (frame PCE - 2880 - 1), indicateur (bit 0 : arrive par la droite, x = 216)\n')
    e9 = [e for e in ev910 if e[2] == 9]; e10 = [e for e in ev910 if e[2] == 10]
    f.write('typedef struct { s16 frame; u8 flags; } Pod9Spawn;\n#define STAGE1_NUM_POD9 %d\nstatic const Pod9Spawn stage1_pod9[STAGE1_NUM_POD9] = {\n' % len(e9))
    for e in sorted(e9): f.write('    {%d, %d},\n' % (e[0] - 2880, e[5]))
    f.write('};\n')
    f.write('// ennemis de type 10 (vaisseaux en formation, routine $652D) : frame, x de départ, indice dans la formation (y = 224)\n')
    f.write('typedef struct { s16 frame; u8 x; u8 idx; } Pod10Spawn;\n#define STAGE1_NUM_POD10 %d\nstatic const Pod10Spawn stage1_pod10[STAGE1_NUM_POD10] = {\n' % len(e10))
    for e in sorted(e10): f.write('    {%d, %d, %d},\n' % (e[0] - 2880, e[3] & 255, e[5]))
    f.write('};\n')
    evg = pickle.load(open('extract/evgnd.pkl', 'rb'))
    f.write('// ennemis au sol (types 13/14 : clignotants, type 15 : marcheurs ; routines $4EE0 / $4F2E) : frame d\'apparition, x, y, type, indicateur\n')
    f.write('typedef struct { s16 frame; s16 x; s16 y; u8 type; u8 flags; } GroundSpawn;\n#define STAGE1_NUM_GROUND %d\nstatic const GroundSpawn stage1_ground[STAGE1_NUM_GROUND] = {\n' % len(evg))
    for e in sorted(evg, key=lambda e: (e[0], e[5])): f.write('    {%d, %d, %d, %d, %d},\n' % (e[0], e[2], e[3], e[1], e[4]))
    f.write('};\n')
    f.write('static const s16 ship9_vel28[32][2] = {%s};\nstatic const s16 ship9_vel64[32][2] = {%s};\n' % (', '.join('{%d, %d}' % enemy_sim.velocity(a, 28) for a in range(32)), ', '.join('{%d, %d}' % enemy_sim.velocity(a, 64) for a in range(32))))
    f.write('static const s16 ship6_vel[32][2] = {%s};\n' % ', '.join('{%d, %d}' % enemy_sim.velocity(a, 38) for a in range(32)))
    f.write('static const s16 ship8_vel[32][2] = {%s};\n\n' % ', '.join('{%d, %d}' % enemy_sim.velocity(a, 36) for a in range(32)))
    f.write('// nuages : frame d\'apparition, x, y de départ, vitesse 8.8 (0x80 = 0,5 px/frame, 0xC0 = 0,75)\ntypedef struct { s16 frame; s16 x; s16 y; s16 speed; } CloudSpawn;\n#define STAGE1_NUM_CLOUDS %d\nstatic const CloudSpawn stage1_clouds[STAGE1_NUM_CLOUDS] = {\n' % len(clouds))
    for st, x, y, sp, n in clouds:
        fr = st - 2880; y0 = y
        if fr < 0: y0 = int(y - fr * sp); fr = -1         # nuage déjà présent au début du stage
        f.write('    {%d, %d, %d, 0x%02X},\n' % (fr, x, y0, int(sp * 256)))
    f.write('};\n\n// défilement vertical : déplacement par frame sur 4 bits, 2 frames par octet\n#define STAGE1_SCROLL_FRAMES %d\nstatic const u8 stage1_scroll[%d] = {\n' % (len(d), len(packed)))
    for i in range(0, len(packed), 24): f.write('    ' + ','.join(map(str, packed[i:i + 24])) + ',\n')
    f.write('};\n#endif\n')
print('PAL2 %d couleurs, PAL3 %d couleurs, %d tuiles HUD (0 en VRAM PCE = tuile %d, palette %d), %d nuages, %d frames de défilement (%d px)' % (len(pal2), len(pal3), len(tiles), t0, bp, len(clouds), len(d), cum[-1]))
Image.open(RES + 'hud_tiles.png').convert('RGB').resize((len(tiles) * 32, 32), Image.NEAREST).save('extract/hud_tiles_preview.png')
