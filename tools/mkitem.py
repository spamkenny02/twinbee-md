#!/usr/bin/env python3
"""Icône du bonus « vie » (16x16, palette HUD ligne 3) : capsule or avec « 1UP » (dessin MD, graphisme PCE non récupéré)."""
from PIL import Image, ImageDraw
def build(RES):
    hud = Image.open(RES + 'hud.png').getpalette()
    im = Image.new('P', (16, 16), 0); im.putpalette(hud)
    d = ImageDraw.Draw(im)
    d.rounded_rectangle((0, 3, 15, 12), 3, fill=2); d.rounded_rectangle((1, 4, 14, 11), 2, fill=3)
    glyph = {'1': ['010', '110', '010', '010', '111'], 'U': ['101', '101', '101', '101', '111'], 'P': ['111', '101', '111', '100', '100']}
    x = 2
    for ch in '1UP':
        for r, row in enumerate(glyph[ch]):
            for c, v in enumerate(row):
                if v == '1': im.putpixel((x + c, 5 + r), 1)
        x += 4
    im.save(RES + 'spr_item.png')
    return ['SPRITE spr_item "spr_item.png" 2 2 NONE 0']
