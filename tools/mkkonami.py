#!/usr/bin/env python3
"""Logo Konami couleur : tuiles/BAT du BG PCE à l'image 170 (4 palettes, sans perte) + chronologie des palettes 170-249.
Sortie : src/konami_data.h"""
import sys, numpy as np
sys.path.insert(0, 'tools'); import pcegfx
def md9(c): return (((c >> 0) & 7) << 9) | (((c >> 6) & 7) << 5) | (((c >> 3) & 7) << 1)
D = '/tmp/in4/v%04d'
v, s, p, r = pcegfx.load(D % 170)
bat = v[:4096].reshape(32, 128); t8 = pcegfx.tiles8(v)
R0, R1, C0, C1 = 4, 26, 6, 25
tiles = []; idx = {}; tm = []
for y in range(R0, R1):
    for x in range(C0, C1):
        b = int(bat[y, x]); t = b & 0x7FF; pl = b >> 12
        if not t8[t].any(): tm.append(0); continue            # tuile vide : transparente (indice 0 de la tuile 0)
        if t not in idx: idx[t] = len(tiles) + 1; tiles.append(t)
        tm.append((pl << 13) | idx[t])
def tile4(t):
    a = t8[t]; w = []
    for row in a: w.append(sum(int(row[i]) << (28 - 4 * i) for i in range(8)))
    return w
data = [0] * 8
for t in tiles: data += tile4(t)
pal = [md9(int(x)) for x in pcegfx.load(D % 170)[2][:64]]
tl = []; prev = [int(x) for x in pcegfx.load(D % 170)[2][:64]]
for f in range(171, 250):
    cur = [int(x) for x in pcegfx.load(D % f)[2][:64]]
    for i in range(64):
        if cur[i] != prev[i] and (i % 16 == 0) <= (i == 0): tl.append((f - 170, i, md9(cur[i])))
    prev = cur
h = ['// Généré par tools/mkkonami.py\n#ifndef KONAMI_DATA_H\n#define KONAMI_DATA_H\n#include <genesis.h>\n']
h.append('#define KON_NT %d\n#define KON_W %d\n#define KON_H %d\n#define KON_R0 %d\n#define KON_C0 %d\n' % (len(tiles) + 1, C1 - C0, R1 - R0, R0, C0))
h.append('static const u32 kon_tiles[] = {%s};\n' % ','.join('0x%08X' % w for w in data))
h.append('static const u16 kon_map[] = {%s};\n' % ','.join(str(x) for x in tm))
h.append('static const u16 kon_pal[64] = {%s};\n' % ','.join('0x%04X' % c for c in pal))
h.append('#define KON_NTL %d\nstatic const u16 kon_tl[][3] = {%s};\n#endif\n' % (len(tl), ','.join('{%d,%d,0x%04X}' % t for t in tl)))
open('md/twinbee/src/konami_data.h', 'w').write(''.join(h))
print(len(tiles), len(tl))

# --- trait de balayage : profils verticaux (colonne x=2) relevés sur la PCE (3 lignes -> 5 -> 7 -> 8), bas aligné sur y=12
def prof(f):
    q = np.frombuffer(open('/tmp/in4/v%04d.rgba' % f, 'rb').read(), dtype=np.uint8).reshape(242, 256, 4)[15:239, :, :3].astype(int)
    return [tuple(int(v) for v in q[y, 2]) for y in range(5, 13)]
PR = [prof(f) for f in (18, 48, 52, 55)]
def lv(c): return min(7, (c * 7 + 127) // 255)
cols = []
for pr in PR:
    for c in pr:
        if c != (0, 0, 0) and c not in cols: cols.append(c)
assert len(cols) <= 14, cols
def mdc(c): return (lv(c[2]) << 9) | (lv(c[1]) << 5) | (lv(c[0]) << 1)
def tilerows(pr, w=8):
    out = []
    for c in pr:
        i = 0 if c == (0, 0, 0) else cols.index(c) + 1
        out.append(sum((i if x < w else 0) << (28 - 4 * x) for x in range(8)))
    return out
tl_ = []
for w in range(1, 9): tl_ += tilerows(PR[0], w)      # 8 variantes (largeur 1..8) du profil 3 lignes
for pr in PR[1:]: tl_ += tilerows(pr)                # profils 5, 7, 8 lignes
tl_ += [0x77777777] * 8                              # tuile noire opaque (indice 7 -> remplacee par un indice libre)
h2 = ['\n#ifndef KONLINE_H\n#define KONLINE_H\n']
h2.append('static const u16 konl_pal[%d] = {0,%s};\n' % (len(cols) + 1, ','.join('0x%04X' % mdc(c) for c in cols)))
h2.append('static const u32 konl_tiles[] = {%s};\n#endif\n' % ','.join('0x%08X' % x for x in tl_))
print(len(cols), cols)
txt = open('md/twinbee/src/konami_data.h').read()
txt = txt.replace('#endif\n', '', 1) if txt.count('#endif') == 1 else txt
open('md/twinbee/src/konami_data.h', 'w').write(txt.rstrip() + '\n' + ''.join(h2) + '#endif\n')

# --- éclat du trait (images 12-46) : fenêtres 48x24 relevées sur le rgba PCE, l'éclat est BG sur PCE : on le rejoue en sprite
from PIL import Image
NF = 35; wins = []; wcols = []
for k in range(NF):
    f = 12 + k
    q = np.frombuffer(open('/tmp/in4/v%04d.rgba' % f, 'rb').read(), dtype=np.uint8).reshape(242, 256, 4)[15:239, :, :3].astype(int)
    x0 = max(0, 8 * (f - 11) - 40) // 8 * 8
    top = q[:24]
    assert not top[:, x0 + 48:].any(), (f, 'pixels a droite')
    w = np.zeros((24, 48, 3), int); xe = min(256, x0 + 48); w[:, :xe - x0] = top[:, x0:xe]
    if x0:  # a gauche : doit etre le trait seul (profil 3 lignes)
        for y in range(24):
            exp = PR[0][y - 5] if 5 <= y < 13 else (0, 0, 0)
            assert (top[y, :x0] == exp).all(), (f, y)
    wins.append((x0, w))
    for c in set(map(tuple, w.reshape(-1, 3))):
        if c != (0, 0, 0) and c not in wcols: wcols.append(c)
print('couleurs eclat', len(wcols))
assert len(wcols) <= 15
sheet = np.zeros((24, 48 * NF), np.uint8)
for k, (x0, w) in enumerate(wins):
    for y in range(24):
        for x in range(48):
            c = tuple(int(v) for v in w[y, x]); sheet[y, 48 * k + x] = 0 if c == (0, 0, 0) else wcols.index(c) + 1
im = Image.fromarray(sheet, 'P')
pal = [0, 0, 0]
for c in wcols: pal += [min(255, lv(c[0]) * 36), min(255, lv(c[1]) * 36), min(255, lv(c[2]) * 36)]
im.putpalette(pal + [0] * (768 - len(pal))); im.save('md/twinbee/res/intro_spark.png')
open('md/twinbee/src/konami_data.h', 'a').write('#define KON_SPK_NF %d\nstatic const u8 kon_spk_x0[%d] = {%s};\n' % (NF, NF, ','.join(str(x0 // 8) for x0, _ in wins)))
