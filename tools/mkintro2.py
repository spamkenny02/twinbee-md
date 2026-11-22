#!/usr/bin/env python3
"""Intro rejouée depuis la PCE (dumps/intro) : enseigne du titre (BG, 2 palettes MD) + chronologies (fond, défilement vertical).
Sprites : tools/mkendspr.py (scène 'i'). Sortie : res/intro_sign.png, src/intro_data.h"""
import sys, subprocess, numpy as np
sys.path.insert(0, 'tools'); import pcegfx
from PIL import Image
def md9(c): return (((c >> 0) & 7) << 9) | (((c >> 6) & 7) << 5) | (((c >> 3) & 7) << 1)     # GRB PCE -> BGR MD
v, s, p, r = pcegfx.load('dumps/intro/v1740')
bat = v[:4096].reshape(64, 64); t8 = pcegfx.tiles8(v)
px = t8[bat & 0x7FF]; tp = bat >> 12
full = (tp[:, :, None, None] * 16 + px).transpose(0, 2, 1, 3).reshape(512, 512)
val = np.where(full % 16 == 0, p[0], p[full]).astype(int)                           # indice 0 = fond
sign = val[24:120, 32:224]
pad = np.full((96, 600), int(p[0]), int)
np.save('/tmp/sign.npy', np.hstack([sign, pad]).astype(np.int32))
print(subprocess.run(['python3', 'tools/mdpal.py', '/tmp/sign.npy', '2', '/tmp/sign_md', '0'], capture_output=True, text=True).stdout)
im = Image.open('/tmp/sign_md.png'); im.crop((0, 0, 192, 96)).save('md/twinbee/res/intro_sign.png')
pal = im.getpalette()
cols = [(((pal[3 * i + 2] // 36) << 9) | ((pal[3 * i + 1] // 36) << 5) | ((pal[3 * i] // 36) << 1)) for i in range(32)]
# chronologies : fond (entrée 0 de la palette) et BYR, une valeur par frame de 530 à 1744
F0, F1 = 530, 1745
def pal0(F):
    d = F if F >= 1180 else (F + 1) // 2 * 2
    return int(pcegfx.load('dumps/intro/v%04d' % d)[2][0])
bg = []; last = None
for F in range(F0, F1):
    c = md9(pal0(F))
    if c != last: bg.append((F - F0, c)); last = c
byr = []; last = None
for F in range(1180, F1):
    b = int(pcegfx.load('dumps/intro/v%04d' % F)[3][8])
    if b != last: byr.append((F - F0, b)); last = b
h = ['// Généré par tools/mkintro2.py\n#ifndef INTRO_DATA_H\n#define INTRO_DATA_H\n#include <genesis.h>\n']
h.append('#define INTRO_F0 %d\n#define INTRO_NF %d\n' % (F0, F1 - F0))
h.append('static const u16 intro_sign_pal[32] = {%s};\n' % ','.join('0x%04X' % c for c in cols))
h.append('#define INTRO_NBG %d\nstatic const u16 intro_bgt[%d][2] = {%s};\n' % (len(bg), len(bg), ','.join('{%d,0x%04X}' % t for t in bg)))
h.append('#define INTRO_NBY %d\nstatic const u16 intro_byt[%d][2] = {%s};\n' % (len(byr), len(byr), ','.join('{%d,%d}' % t for t in byr)))
h.append('#endif\n')
open('md/twinbee/src/intro_data.h', 'w').write(''.join(h))
print('bg', bg, 'byr n', len(byr))
