#!/usr/bin/env python3
"""Fruits laissés par les ennemis au sol (type 29 sous-type 0) : pêche (motif PCE 422, pal 7) et pomme (419, pal 4),
dumps/it1/m5700 et m10560, réduits sur la palette sprite PAL2 (spr_body.png)."""
import sys, numpy as np
sys.path.insert(0, 'tools')
import pcegfx, pcesprites
from PIL import Image
def rgb(c): return np.array([((c >> 3) & 7) * 36, ((c >> 6) & 7) * 36, (c & 7) * 36])
def build(RES):
    pp = Image.open(RES + 'spr_body.png').getpalette()
    pal2 = np.array([pp[i * 3:i * 3 + 3] for i in range(16)])
    out = Image.new('P', (32, 16), 0); out.putpalette(pp)
    for k, (dump, pat, pl) in enumerate((('dumps/it1/m5700', 422, 7), ('dumps/it1/m10560', 419, 4))):
        vram, sat, pal, reg = pcegfx.load(dump)
        s = pcesprites.sprite(vram, pal, pat, 16, 16, pl)
        for y in range(16):
            for x in range(16):
                if s[y, x] < 0: continue
                d = ((pal2[1:15] - rgb(int(s[y, x]))) ** 2).sum(1)
                out.putpixel((k * 16 + x, y), int(d.argmin()) + 1)
    out.save(RES + 'spr_item.png')
    return ['SPRITE spr_item "spr_item.png" 2 2 NONE 0']
