# HUD du joueur 2 : moitié droite de la ligne de HUD de la trace PCE avec les deux joueurs (dumps/tw/w3400, lignes 212-227)
# Le heart rose utilise l'entrée 15 (libre) de la palette HUD, les teintes claires sont ramenées au blanc.
import numpy as np
from PIL import Image

def build(RES):
    a = np.fromfile('dumps/tw/w3400.rgba', dtype=np.uint8).reshape(242, 256, 4)[212:228, 128:256, :3]
    hud = Image.open(RES + 'hud.png'); p = hud.getpalette()
    p[45:48] = [252, 108, 252]                      # entrée 15 : rose
    hud.putpalette(p); hud.save(RES + 'hud.png')
    pal = [tuple(p[k * 3:k * 3 + 3]) for k in range(16)]
    out = np.zeros((16, 128), np.uint8)
    pink_dark = (182, 0, 182)
    for y in range(16):
        for x in range(128):
            c = tuple(int(v) for v in a[y, x])
            if c == (0, 0, 0): out[y, x] = 1
            elif c in ((182, 0, 182), (255, 109, 255)): out[y, x] = 15
            elif c == (255, 182, 255): out[y, x] = 7
            else:
                q = tuple(min(252, (v >> 5) * 36) for v in c)
                best = min(range(1, 15), key=lambda k: sum((pal[k][i] - q[i]) ** 2 for i in range(3)))
                out[y, x] = best
    im = Image.fromarray(out, 'P'); im.putpalette(p); im.save(RES + 'hud2.png')
    # WinBee : mêmes sprites que TwinBee, bleus remplacés par les rouges déjà présents dans la palette sprites (pas de ligne de palette libre)
    MAP = {2: 1, 3: 7, 5: 4, 6: 4, 9: 8}
    lines = ['IMAGE hud2_image "hud2.png" NONE ALL']
    for n, w, h in (('spr_body', 2, 2), ('spr_arm', 2, 2), ('spr_orb', 2, 2)):
        im = Image.open(RES + n + '.png'); a = np.array(im)
        b = np.vectorize(lambda v: MAP.get(int(v), int(v)))(a).astype(np.uint8)
        o = Image.fromarray(b, 'P'); o.putpalette(im.getpalette()); o.save(RES + n + '2.png')
        lines.append('SPRITE %s2 "%s2.png" %d %d NONE 0' % (n, n, w, h))
    return lines
