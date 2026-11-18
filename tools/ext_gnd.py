#!/usr/bin/env python3
"""Extrait les sprites des ennemis au sol (types 13/14/15) et de la bombe -> extract/sprites_gnd.npy"""
import sys, numpy as np
sys.path.insert(0, 'tools'); import pcegfx, pcesprites
vram, sat, pal, reg = pcegfx.load('dumps/gd/g41')
S = {}
for name, pat, pl in [('g13a', 328, 11), ('g13b', 329, 11), ('g14a', 344, 11), ('g14b', 345, 11), ('bomb', 487, 0)]:
    S[name] = pcesprites.sprite(vram, pal, pat, 16, 16, pl)
np.save('extract/sprites_gnd.npy', np.array([S], dtype=object), allow_pickle=True)
print({k: sorted(set(v[v >= 0].tolist())) for k, v in S.items()})
