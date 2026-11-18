#!/usr/bin/env python3
"""Extrait le sprite du tir double (bonus de cloche blanche, flag $04 de $3438) : motif 495, palette 4, d'un dump PCE avec poke 3438=04."""
import sys, numpy as np
sys.path.insert(0, 'tools'); import pcegfx, pcesprites
vram, sat, pal, reg = pcegfx.load('dumps/pw04/q3440')
t = pcesprites.sprite(vram, pal, 495, 16, 16, 4)
np.save('extract/sprites_twin.npy', np.array([{'shotT': t}], dtype=object), allow_pickle=True)
print(sorted(set(t[t >= 0].tolist())), np.load('extract/sprites_pce.npy', allow_pickle=True)[0]['shot'].tolist() == t.tolist())
