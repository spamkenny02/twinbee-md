#!/usr/bin/env python3
"""Fond de la fin (stage 6) : BAT 64x64 + tuiles + palette d'un dump PCE -> image RGB 512x512 (couleurs 9 bits GRB en entier)."""
import sys; sys.path.insert(0, 'tools')
import pcegfx, numpy as np
def render(prefix, palprefix=None):
    v, s, p, r = pcegfx.load(prefix)
    if palprefix: p = pcegfx.load(palprefix)[2]
    bat = v[:4096].reshape(64, 64); t8 = pcegfx.tiles8(v)
    idx = ((bat >> 12)[:, :, None, None] * 16 + t8[bat & 0x7FF]).transpose(0, 2, 1, 3).reshape(512, 512)
    return p[idx], p        # couleurs 9 bits par pixel
def rgb(c9): g = (c9 >> 6) & 7; r = (c9 >> 3) & 7; b = c9 & 7; return (np.stack([r, g, b], -1) * 255 // 7).astype(np.uint8)
if __name__ == '__main__':
    from PIL import Image
    f = sys.argv[1]; c, p = render('dumps/end6b/w' + f, ('dumps/end6b/w' + sys.argv[3]) if len(sys.argv) > 3 else None)
    Image.fromarray(rgb(c)).save(sys.argv[2])
