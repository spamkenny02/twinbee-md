#!/usr/bin/env python3
"""Boss du stage 2 (galion) : rejoue le plan B de la PCE (tilemap par diffs toutes les 8 frames + scroll X/Y par frame).
Sorties : extract/boss2_atlas.npy -> mdpal_dyn -> res/boss2.png ; src/boss2_data.h
usage: mkboss2.py step  (step = atlas | data)"""
import sys, os, numpy as np, pickle
sys.path.insert(0, 'tools'); import pcegfx, pcetrace
F0, F1 = 37400, 47760
T0 = 25000                                   # première frame de la trace s2t
KEYS = [(f, 'dumps/s2d/s%d' % f) for f in range(37400, 37600, 40)] + [(f, 'dumps/s2b/b%d' % f) for f in range(37600, F1 + 1, 8)]

def entries(prefix, tdict):
    v, s, p, r = pcegfx.load(prefix)
    bat = v[:4096]; t8 = pcegfx.tiles8(v); col = (p & 0x1FF); bg = int(col[0])
    out = np.zeros(4096, np.int32); cache = {}
    for i, e in enumerate(bat):
        e = int(e)
        if e not in cache:
            t = t8[e & 0x7FF]; c = col[(e >> 12) * 16 + t]; c = np.where(t == 0, bg, c).astype(np.int16)
            k = c.tobytes()
            if k not in tdict: tdict[k] = len(tdict)
            cache[e] = tdict[k]
        out[i] = cache[e]
    return out, bg

def main():
    step = sys.argv[1]
    tdict = {}; E = []; bgc = None
    for f, pre in KEYS:
        e, bg = entries(pre, tdict); E.append(e); bgc = bg if bgc is None else bgc
    N = len(tdict); print('tiles uniques', N, 'keyframes', len(E))
    tiles = [None] * N
    for k, i in tdict.items(): tiles[i] = np.frombuffer(k, np.int16).reshape(8, 8)
    H = (N + 31) // 32 * 8; atlas = np.full((H, 256), bgc, np.int32)
    for i, t in enumerate(tiles): atlas[(i // 32) * 8:(i // 32) * 8 + 8, (i % 32) * 8:(i % 32) * 8 + 8] = t
    np.save('extract/boss2_atlas.npy', atlas)
    pickle.dump((E, N, bgc), open('extract/boss2_E.pkl', 'wb'))
    print('atlas', atlas.shape, 'fond %03X' % bgc)

main()
