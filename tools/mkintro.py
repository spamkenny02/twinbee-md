#!/usr/bin/env python3
"""Sprites de l'intro (nuage 64x32, TwinBee 32x32 extraits de dumps/boot/f0660 et f0900, étoiles dessinées) + images fixes du logo Konami."""
import numpy as np
from PIL import Image
from scipy import ndimage
def snap(v): return round(v / 255 * 7) * 255 // 7
def frame(f): return np.array(Image.open('dumps/boot/f%04d.png' % f).convert('RGB'))[15:239]
def crop_sprite(im, bbox, w, h):
    x0, y0, x1, y1 = bbox
    cx, cy = (x0 + x1) // 2, (y0 + y1) // 2
    xs, ys = cx - w // 2, cy - h // 2
    sub = im[ys:ys + h, xs:xs + w].astype(int)
    bg = im[2, 2].astype(int)
    mask = np.abs(sub - bg).sum(2) > 12
    q = Image.fromarray(sub.astype(np.uint8)).quantize(15, method=Image.Quantize.MEDIANCUT, dither=Image.Dither.NONE)
    idx = np.array(q) + 1; idx[~mask] = 0
    pal = q.getpalette()[:45]
    out = Image.fromarray(idx.astype(np.uint8), 'P')
    out.putpalette([0, 0, 0] + [snap(v) for v in pal] + [0] * (768 - 48))
    return out
def bbox_of(im, region):
    x0, y0, x1, y1 = region
    sub = im[y0:y1, x0:x1].astype(int); bg = im[2, 2].astype(int)
    m = np.abs(sub - bg).sum(2) > 12
    ys, xs = np.where(m)
    return (x0 + xs.min(), y0 + ys.min(), x0 + xs.max() + 1, y0 + ys.max() + 1)
def build(RES):
    a = frame(660); b = frame(900)
    crop_sprite(a, bbox_of(a, (25, 10, 100, 55)), 64, 32).save(RES + 'intro_cloud.png')
    crop_sprite(b, bbox_of(b, (105, 135, 150, 180)), 32, 32).save(RES + 'intro_bee.png')
    st = Image.new('P', (24, 8), 0); st.putpalette([0, 0, 0, 255, 255, 255, 255, 109, 73, 109, 146, 255] + [0] * 756)
    pat = ['00100', '00100', '11111', '00100', '00100']
    for k in range(3):
        for y, row in enumerate(pat):
            for x, c in enumerate(row):
                if c == '1': st.putpixel((k * 8 + 1 + x, 1 + y), k + 1)
    st.save(RES + 'intro_star.png')
    return ['IMAGE intro_%s "intro_%s.png" NONE ALL' % (n, n) for n in ('k1', 'k2')] + ['SPRITE intro_cloud "intro_cloud.png" 8 4 NONE 0', 'SPRITE intro_bee "intro_bee.png" 4 4 NONE 0', 'SPRITE intro_star "intro_star.png" 1 1 NONE 0']
