#!/usr/bin/env python3
"""Extrait des sprites PCE d'un dump (vram+pal) : liste nom:pattern:largeur:hauteur:palette
Renvoie des tableaux de couleurs 9 bits (-1 = transparent)."""
import sys, numpy as np
sys.path.insert(0, 'tools'); import pcegfx

def sprite(vram, pal, pat, w, h, p):
    s16 = pcegfx.spr16(vram); base = pat
    if w == 32: base &= ~1
    if h >= 32: base &= ~2
    if h == 64: base &= ~4
    img = np.zeros((h, w), int)
    for cy in range(h // 16):
        for cx in range(w // 16): img[cy * 16:cy * 16 + 16, cx * 16:cx * 16 + 16] = s16[(base + cy * 2 + cx) & 511]
    col = (pal & 0x1FF)[256 + p * 16 + img]
    return np.where(img == 0, -1, col)
