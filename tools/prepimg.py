#!/usr/bin/env python3
"""Prétraitement d'une image décor (couleurs 9 bits) : comble les lignes manquantes, limite à NC couleurs,
fusionne les tiles rares vers la tile la plus proche jusqu'à NT tiles uniques.  usage: prepimg.py in.npy out.npy NC NT"""
import sys, numpy as np
img = np.load(sys.argv[1]).astype(np.int32); NC, NT = int(sys.argv[3]), int(sys.argv[4])
for y in range(img.shape[0]):
    if img[y, 0] < 0:
        s = y
        while s < img.shape[0] and img[s, 0] < 0: s += 1
        img[y] = img[s] if s < img.shape[0] else img[y - 1]
for y in range(img.shape[0] - 1, -1, -1):
    if img[y, 0] < 0: img[y] = img[y + 1]
def rgb(c): return np.array([(c >> 3) & 7, (c >> 6) & 7, c & 7])
v, c = np.unique(img, return_counts=True)
keep = list(v[np.argsort(-c)][:NC]); mp = {}
for col in v:
    mp[int(col)] = int(col) if col in keep else int(min(keep, key=lambda k: ((rgb(k) - rgb(col)) ** 2).sum()))
lut = np.zeros(512, np.int32)
for a, b in mp.items(): lut[a] = b
img = lut[img]
H, W = img.shape; H8 = H // 8 * 8; img = img[:H8]
T = img.reshape(H8 // 8, 8, W // 8, 8).transpose(0, 2, 1, 3).reshape(-1, 64)
u, inv, cnt = np.unique(T, axis=0, return_inverse=True, return_counts=True); inv = inv.ravel()
print('couleurs', len(keep), 'tiles uniques', len(u))
alive = np.ones(len(u), bool); order = np.argsort(cnt)         # fusionne les plus rares d'abord
remap = np.arange(len(u))
n = len(u)
for k in order:
    if n <= NT: break
    cand = np.where(alive)[0]; cand = cand[cand != k]
    d = (u[cand] != u[k]).sum(1); j = cand[d.argmin()]
    alive[k] = False; remap[remap == k] = j; n -= 1
T2 = u[remap[inv]]
out = T2.reshape(H8 // 8, W // 8, 8, 8).transpose(0, 2, 1, 3).reshape(H8, W)
print('tiles uniques après', len(np.unique(T2, axis=0)), 'pixels modifiés %.2f%%' % (100 * (out != img).mean()))
np.save(sys.argv[2], out)
