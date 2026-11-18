#!/usr/bin/env python3
"""Stage 2 : ennemis rejoués depuis la trace sans tir (extract/s2_inst.pkl) -> res/e2_*.png + src/stage2_enemies.h
Chaque instance = type, frame d'apparition, position de départ, gabarit de trajectoire (deltas par frame + indice d'image)."""
import sys, pickle, collections, numpy as np, math, re
from PIL import Image
sys.path.insert(0, 'tools'); import pcegfx, pcesprites
RES = 'md/twinbee/res/'; SRC = 'md/twinbee/src/'; START = 25541
EXCL = {448, 464, 468, 472, 487, 312, 316, 383}
def rgb9(c): return np.array([((c >> 3) & 7) * 36, ((c >> 6) & 7) * 36, (c & 7) * 36])
pal2 = np.array(Image.open(RES + 'spr_body.png').getpalette()[3:48]).reshape(15, 3)
inst = sorted([o for o in pickle.load(open('extract/s2_inst.pkl', 'rb')) if 16 <= o['ty'] <= 27], key=lambda o: (o['t0'], o['slot']))
off = collections.defaultdict(collections.Counter); imgs = {}
for o in inst:
    o['pieces'] = [[p for p in pcs if p[0] not in EXCL] for pcs in o['pieces']]
    for pcs in o['pieces']:
        for (pat, w, h, hf, pal, dx, dy) in pcs: off[(pat, w, h, hf, pal)][(dx, dy)] += 1; imgs[(pat, w, h, pal)] = None
off = {k: c.most_common(1)[0][0] for k, c in off.items()}
# images : classes de taille
cls = {(16, 16): 0, (16, 32): 1, (32, 16): 2, (32, 32): 3}
imglist = {c: sorted(k for k in imgs if (k[1], k[2]) == s) for s, c in cls.items()}
index = {k: (c, i) for c, l in imglist.items() for i, k in enumerate(l)}
# rendu des images depuis les dumps de la partie (toutes les 40 frames)
need = set(imgs); done = {}
for f in range(25560, 37700, 40):
    if not need: break
    vram, sat, pal, reg = pcegfx.load('dumps/s2d/s%05d' % f)
    import pcetrace
    for s in pcetrace.sprites(sat.reshape(-1, 4) if sat.ndim == 1 else sat):
        sx, sy, pat, p, hf, w, h, i = s
        k = (pat, w, h, p)
        if k in need:
            done[k] = pcesprites.sprite(vram, pal, pat, w, h, p); need.discard(k)
print('images', len(imgs), 'manquantes', sorted(need))
def quant(c):
    if c < 0: return 0
    d = ((pal2 - rgb9(int(c))) ** 2 * np.array([2, 4, 3])).sum(1)
    return 1 + int(d.argmin())
lines = []
for s, c in cls.items():
    l = imglist[c]
    if not l: continue
    w, h = s; sheet = np.zeros((h, w * len(l)), np.uint8)
    for i, k in enumerate(l):
        im = done.get(k)
        if im is None: continue
        for y in range(h):
            for x in range(w): sheet[y, i * w + x] = quant(im[y, x])
    o = Image.fromarray(sheet, 'P'); pl = [255, 0, 255] + [int(v) for v in pal2.ravel()]; pl += [0] * (768 - len(pl)); o.putpalette(pl); o.save(RES + 'e2_%d.png' % c)
    lines.append('SPRITE spr_e2_%d "e2_%d.png" %d %d NONE 0' % (c, c, w // 8, h // 8))
# images (frames) : tuples de pièces (classe, indice, flip, dx, dy)
frames = {}; flist = []
def fid(pcs):
    key = tuple(sorted((index[(p[0], p[1], p[2], p[4])] + (p[3],) + off[(p[0], p[1], p[2], p[3], p[4])]) for p in pcs))
    if key not in frames: frames[key] = len(flist); flist.append(key)
    return frames[key]
tpls = {}; tlist = []; insts = []
for o in inst:
    p = np.array(o['pts']); d = np.diff(p, axis=0); f = [fid(pcs) for pcs in o['pieces']]
    key = (tuple(d[:, 0].tolist()), tuple(d[:, 1].tolist()), tuple(f))
    if key not in tpls: tpls[key] = len(tlist); tlist.append(key)
    insts.append((o['t0'] - START, o['ty'], int(p[0, 0]), int(p[0, 1]), tpls[key], o['hw'], o['hh']))
print('frames', len(flist), 'gabarits', len(tlist), 'instances', len(insts), 'total frames gabarits', sum(len(t[2]) for t in tlist))
cnt = max(len(k) for k in flist); print('pièces max par image', cnt)
C = collections.Counter(); T = collections.defaultdict(collections.Counter)
for (t0, ty, x, y, tp, hw, hh) in insts:
    for i, fi in enumerate(tlist[tp][2]):
        for pc in flist[fi]: T[t0 + i][pc[0]] += 1
mx = [max(T[t][c] for t in T) for c in range(4)]; print('max concurrent par classe', mx)
with open(SRC + 'stage2_enemies.h', 'w') as f:
    f.write('// Généré par tools/mkenemies2.py : ennemis du stage 2 rejoués depuis une partie sans tir\n#ifndef STAGE2_ENEMIES_H\n#define STAGE2_ENEMIES_H\n#include <genesis.h>\n')
    f.write('#define E2_MAX_PIECES %d\n#define E2_POOL0 %d\n#define E2_POOL1 %d\n#define E2_POOL2 %d\n#define E2_POOL3 %d\n' % ((cnt,) + tuple(mx)))
    f.write('typedef struct { u8 cls, img, flip; s8 dx, dy; } E2Piece;\ntypedef struct { u8 n; E2Piece p[%d]; } E2Frame;\n' % cnt)
    f.write('#define E2_NUM_FRAMES %d\nstatic const E2Frame e2_frames[E2_NUM_FRAMES] = {\n' % len(flist))
    for k in flist: f.write('    {%d, {%s}},\n' % (len(k), ', '.join('{%d, %d, %d, %d, %d}' % pc for pc in k)))
    f.write('};\n')
    offs = []; PI = []; RF = []; RL = []
    PT = sorted(set(p for t in tlist for p in zip(list(t[0]) + [0], list(t[1]) + [0])))
    for t in tlist:
        dxs = list(t[0]) + [0]; dys = list(t[1]) + [0]; fis = list(t[2])
        assert len(dxs) == len(fis)
        offs.append((len(PI), len(fis), len(RF)))
        PI += [PT.index(p) for p in zip(dxs, dys)]
        i = 0
        while i < len(fis):
            j = i
            while j < len(fis) and fis[j] == fis[i] and j - i < 255: j += 1
            RF.append(fis[i]); RL.append(j - i); i = j
    assert len(PT) < 256
    for t, (o, n, r) in zip(tlist, offs):
        dd = [PT[PI[o + k]] for k in range(n)]
        assert [d[0] for d in dd[:-1]] == list(t[0]) and [d[1] for d in dd[:-1]] == list(t[1])
        ff = []; rr = r
        while len(ff) < n: ff += [RF[rr]] * RL[rr]; rr += 1
        assert ff == list(t[2])
    f.write('#define E2_NUM_TPL %d\ntypedef struct { u32 off; u16 len; u16 roff; } E2Tpl;\nstatic const E2Tpl e2_tpl[E2_NUM_TPL] = {%s};\n' % (len(tlist), ', '.join('{%d, %d, %d}' % o for o in offs)))
    f.write('static const s8 e2_pdx[%d] = {%s};\nstatic const s8 e2_pdy[%d] = {%s};\n' % (len(PT), ','.join(str(p[0]) for p in PT), len(PT), ','.join(str(p[1]) for p in PT)))
    f.write('static const u8 e2_pi[%d] = {%s};\n' % (len(PI), ','.join(map(str, PI))))
    f.write('static const u8 e2_rf[%d] = {%s};\nstatic const u8 e2_rl[%d] = {%s};\n' % (len(RF), ','.join(map(str, RF)), len(RL), ','.join(map(str, RL))))
    f.write('typedef struct { s16 t0; u8 ty; s16 x, y; u16 tpl; } E2Inst;\n#define E2_NUM_INST %d\nstatic const E2Inst e2_inst[E2_NUM_INST] = {\n' % len(insts))
    for (t0, ty, x, y, tp, hw, hh) in insts: f.write('    {%d, %d, %d, %d, %d},\n' % (t0, ty, x, y, tp))
    f.write('};\n')
    hwh = {}
    for (t0, ty, x, y, tp, hw, hh) in insts: hwh[ty] = (hw, hh)
    f.write('// demi-tailles de collision par type (16..27)\nstatic const u8 e2_hw[12] = {%s}, e2_hh[12] = {%s};\n' % (','.join(str(hwh.get(16 + i, (5, 5))[0]) for i in range(12)), ','.join(str(hwh.get(16 + i, (5, 5))[1]) for i in range(12))))
    eb = pickle.load(open('extract/ebul2.pkl', 'rb'))
    f.write('typedef struct { s16 frame, x, y; } E2Bul;\n#define E2_NUM_BUL %d\nstatic const E2Bul e2_bul[E2_NUM_BUL] = {%s};\n' % (len(eb), ', '.join('{%d, %d, %d}' % (e[0] - START, e[1], e[2]) for e in eb)))
    f.write('#endif\n')
cur = open(RES + 'resources.res').read().split('\n')
open(RES + 'resources.res', 'w').write('\n'.join([l for l in cur if l.strip() and not l.startswith('SPRITE spr_e2_')] + lines) + '\n')
print('\n'.join(lines))
