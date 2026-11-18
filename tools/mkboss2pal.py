#!/usr/bin/env python3
"""Partition statique en 2 palettes MD (15 couleurs chacune + fond) d'un atlas de tiles ; erreur minimisée par recherche locale.
usage: mkboss2pal.py atlas.npy out_prefix  -> out.png (indices 0..15), out_pal.txt (ligne par tile), out_events.txt"""
import sys, random, numpy as np
from PIL import Image
atlas = np.load(sys.argv[1]).astype(np.int32); out = sys.argv[2]
H, W = atlas.shape; NT = (H // 8) * (W // 8)
tiles = atlas.reshape(H // 8, 8, W // 8, 8).transpose(0, 2, 1, 3).reshape(NT, 64)
v, c = np.unique(atlas, return_counts=True); bg = int(v[c.argmax()])
cols = [int(x) for x in v if x != bg]; C = len(cols); ci = {x: i for i, x in enumerate(cols)}
def rgb(x): return np.array([(x >> 3) & 7, (x >> 6) & 7, x & 7])
RG = np.array([rgb(x) for x in cols + [bg]])
D = ((RG[:, None, :] - RG[None, :, :]) ** 2).sum(2)          # (C+1, C+1)
cnt = np.zeros((NT, C + 1))
for t in range(NT):
    for x, n in zip(*np.unique(tiles[t], return_counts=True)): cnt[t, ci[x] if x != bg else C] = n
def err(L):
    idx = sorted(L) + [C]; best = D[:, idx].min(1)           # coût de remplacement de chaque couleur
    return cnt @ best
def cost(L0, L1): return np.minimum(err(L0), err(L1)).sum()
random.seed(1); best_all = None
for restart in range(12):
    order = sorted(range(C), key=lambda i: -cnt[:, i].sum())
    if restart: random.shuffle(order)
    L = [set(order[:15]), set(order[15:30])]
    cur = cost(*L); improved = True
    while improved:
        improved = False
        for l in (0, 1):
            for a in list(L[l]):
                for b in range(C):
                    if b in L[l]: continue
                    N = set(L[l]); N.remove(a); N.add(b); NL = [N, L[1]] if l == 0 else [L[0], N]
                    cc = cost(*NL)
                    if cc < cur - 1e-9: L = NL; cur = cc; improved = True; break
    if best_all is None or cur < best_all[0]: best_all = (cur, [set(L[0]), set(L[1])])
cur, L = best_all
e0, e1 = err(L[0]), err(L[1]); line = (e1 < e0).astype(int)
print('colors', C, 'erreur totale', cur, 'tiles avec erreur', int((np.minimum(e0, e1) > 0).sum()), 'pixels fond/total', (atlas == bg).mean())
slots = [sorted(L[0]), sorted(L[1])]
outimg = np.zeros((NT, 64), np.uint8)
for t in range(NT):
    S = slots[line[t]]; cand = [(-1, 0)] + [(cols[i], 1 + j) for j, i in enumerate(S)]
    m = {}
    for x in set(tiles[t].tolist()):
        if x == bg: m[x] = 0
        else: m[x] = min(cand[1:], key=lambda e: int(((rgb(x) - rgb(e[0])) ** 2).sum()))[1]
    outimg[t] = [m[x] for x in tiles[t]]
img = outimg.reshape(H // 8, W // 8, 8, 8).transpose(0, 2, 1, 3).reshape(H, W)
im = Image.fromarray(img, 'P'); pal = np.zeros((256, 3), np.uint8)
for i in range(16): pal[i] = (i * 16, 255 - i * 16, (i * 37) % 256)
im.putpalette(pal.flatten().tolist()); im.save(out + '.png')
def mdcol(x): r, g, b = rgb(x); return (int(b) << 9) | (int(g) << 5) | (int(r) << 1)
with open(out + '_pal.txt', 'w') as f: f.write(' '.join(map(str, line.tolist())) + '\n')
with open(out + '_events.txt', 'w') as f:
    f.write('backdrop %04X\n' % mdcol(bg))
    for l in (0, 1):
        for j, i in enumerate(slots[l]): f.write('%d %04X\n' % (l * 16 + 1 + j, mdcol(cols[i])))
