#!/usr/bin/env python3
"""Fusionne les tiles indexées rares (même ligne de palette) vers la plus proche jusqu'à NT tiles uniques.
usage: mergeidx.py prefix_md NT   (lit/écrit prefix_md_idx.npy et prefix_md.png)"""
import sys, numpy as np
from PIL import Image
pre, NT = sys.argv[1], int(sys.argv[2])
o = np.load(pre + '_idx.npy'); H, W = o.shape
T = o.reshape(H // 8, 8, W // 8, 8).transpose(0, 2, 1, 3).reshape(-1, 64)
u, inv, cnt = np.unique(T, axis=0, return_inverse=True, return_counts=True); inv = inv.ravel()
def line(t):
    nz = t[t & 15 != 0]; return int(np.bincount(nz >> 4).argmax()) if len(nz) else -1
L = np.array([line(t) for t in u]); alive = np.ones(len(u), bool); remap = np.arange(len(u)); n = len(u)
for k in np.argsort(cnt):
    if n <= NT: break
    cand = np.where(alive & ((L == L[k]) | (L < 0) | (L[k] < 0)))[0]; cand = cand[cand != k]
    if len(cand) == 0: continue
    d = (u[cand] != u[k]).sum(1); j = cand[d.argmin()]
    alive[k] = False; remap[remap == k] = j; n -= 1
T2 = u[remap[inv]]; out = T2.reshape(H // 8, W // 8, 8, 8).transpose(0, 2, 1, 3).reshape(H, W).astype(np.uint8)
print('tiles uniques', len(np.unique(T2, axis=0)), 'pixels modifiés %.2f%%' % (100 * (out != o).mean()))
im = Image.fromarray(out, 'P'); im.putpalette(Image.open(pre + '.png').getpalette()); im.save(pre + '.png'); np.save(pre + '_idx.npy', out)
