#!/usr/bin/env python3
"""Découpe un fond en segments dont les tuiles uniques (miroirs inclus) tiennent dans CAP tuiles. usage: segplan.py idx.npy CAP [OVERLAP_rows]"""
import sys, numpy as np
idx = np.load(sys.argv[1]); CAP = int(sys.argv[2]); OV = int(sys.argv[3]) if len(sys.argv) > 3 else 30
H, W = idx.shape; TH = H // 8
t = idx.reshape(TH, 8, W // 8, 8).transpose(0, 2, 1, 3)
def canon(a):
    c = [a, a[:, ::-1], a[::-1], a[::-1, ::-1]]
    return min(x.tobytes() for x in c)
keys = [[canon(t[r, x]) for x in range(W // 8)] for r in range(TH)]
segs = []; r = 0
while r < TH:
    s = set(); e = r
    while e < TH:
        n = s | set(keys[e])
        if len(n) > CAP: break
        s = n; e += 1
    segs.append((r, e, len(s)))
    if e >= TH: break
    r = max(r + 1, e - OV)
print(len(segs), segs)
