#!/usr/bin/env python3
"""Barrière de la cloche rouge : quart de dôme 32x32 (motif PCE 428) et 16x16 (431), palette HUD (ligne 3)."""
import sys, numpy as np
sys.path.insert(0, 'tools')
import pcesprites
from PIL import Image
def rgb(c): return np.array([((c >> 3) & 7) * 36, ((c >> 6) & 7) * 36, (c & 7) * 36])
def build(RES, SRC):
    vram = np.fromfile('dumps/rb/rbd.vram', dtype='<u2'); pal = np.fromfile('dumps/rb/rbd.pal', dtype='<u2').astype(np.int32)
    hudp = Image.open(RES + 'hud.png').getpalette()
    IDX = [7, 10, 12, 13]
    pcol = np.array([hudp[i * 3:i * 3 + 3] for i in IDX])
    res = []
    for name, pat, w in (('spr_bar_big', 428, 32), ('spr_bar_small', 431, 16)):
        im = pcesprites.sprite(vram, pal, pat, w, w, 5)
        out = np.zeros((w, w), np.uint8)
        for y in range(w):
            for x in range(w):
                if im[y, x] >= 0: out[y, x] = IDX[int(((pcol - rgb(int(im[y, x]))) ** 2).sum(1).argmin())]
        o = Image.fromarray(out, 'P'); pl = [255, 0, 255] + [0] * 45
        for i in range(16): pl[i * 3:i * 3 + 3] = [int(v) for v in hudp[i * 3:i * 3 + 3]] if i else [255, 0, 255]
        pl += [0] * (768 - len(pl)); o.putpalette(pl); o.save(RES + name + '.png')
        res.append('SPRITE %s "%s.png" %d %d NONE 0' % (name, name, w // 8, w // 8))
    return res
if __name__ == '__main__': print(build('md/twinbee/res/', 'md/twinbee/src/'))
