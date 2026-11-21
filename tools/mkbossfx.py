#!/usr/bin/env python3
"""Boss du stage 1 : débris de roche des parois (sprite 32x64, motif PCE 376, palette 15), anneaux bleus (motifs 282/284/286 en 16x16,
296/304/308/312 en 32x32, palette 13) et leurs tables de temps (trace dumps/cc puis dumps/ce, frame PCE - 2880 = frame de jeu).
Sorties : res/boss_rock.png, res/boss_ring.png, src/boss_fx.h"""
import sys, re
import numpy as np
from PIL import Image
sys.path.insert(0, 'tools')
import pcegfx, pcesprites, pcetrace as T

def rgb(c): return np.array([((c >> 3) & 7) * 36, ((c >> 6) & 7) * 36, (c & 7) * 36])
def mdrgb(m): return np.array([((m >> 1) & 7) * 36, ((m >> 5) & 7) * 36, ((m >> 9) & 7) * 36])

def build(RES, SRC):
    vram, sat, pal, reg = pcegfx.load('dumps/bs/b18400')
    cram = [0] * 64
    for m in re.finditer(r'\{(\d+), (\d+), (0x[0-9A-Fa-f]+)\}', open(SRC + 'stage1_pal.h').read()): cram[int(m.group(2))] = int(m.group(3), 16)
    hudp = Image.open(RES + 'hud.png').getpalette()
    def sheet(name, cells, w, h, p, fixed=False, lines=(0, 1)):
        best = None
        for line in ((3,) if fixed else lines):
            if fixed: pcol = np.array([hudp[i * 3:i * 3 + 3] for i in range(1, 8)])
            else: pcol = np.array([mdrgb(cram[line * 16 + i]) for i in range(1, 16)])
            err = 0
            for (pat, cw, ch, ox, oy) in cells:
                im = pcesprites.sprite(vram, pal, pat, cw, ch, p)
                for c in im[im >= 0].ravel(): err += ((pcol - rgb(int(c))) ** 2).sum(1).min()
            if best is None or err < best[0]: best = (err, line)
        line = best[1]
        if fixed: pcol = np.array([hudp[i * 3:i * 3 + 3] for i in range(1, 8)])
        else: pcol = np.array([mdrgb(cram[line * 16 + i]) for i in range(1, 16)])
        out = np.zeros((h, w * len(cells)), np.uint8)
        for k, (pat, cw, ch, ox, oy) in enumerate(cells):
            im = pcesprites.sprite(vram, pal, pat, cw, ch, p)
            for y in range(ch):
                for x in range(cw):
                    if im[y, x] >= 0: out[oy + y, k * w + ox + x] = 1 + int(((pcol - rgb(int(im[y, x]))) ** 2).sum(1).argmin())
        o = Image.fromarray(out, 'P'); pl = [255, 0, 255]
        for i in range(len(pcol)): pl += [int(v) for v in pcol[i]]
        pl += [0] * (768 - len(pl)); o.putpalette(pl); o.save(RES + name + '.png')
        print(name, ': palette BG ligne', line, 'erreur', best[0], 'pixels', int((out > 0).sum()))
        return line
    lr = sheet('boss_rock', [(376, 32, 64, 0, 0)], 32, 64, 15, False, (1,))
    # anneaux : images 0-2 (16x16 centrées dans une cellule 32x32), 3-6 : 296, 304, 308, 312
    cells = [(282, 16, 16, 8, 8), (284, 16, 16, 8, 8), (286, 16, 16, 8, 8), (296, 32, 32, 0, 0), (304, 32, 32, 0, 0), (308, 32, 32, 0, 0), (312, 32, 32, 0, 0)]
    lg = sheet('boss_ring', cells, 32, 32, 13, True)
    # temps : position y du premier débris (le suivant naît 128 px plus haut), frame PCE 16009 -> y = -64
    ys = {}
    for tr in ('dumps/cc/cc.trace', 'dumps/ce/ce.trace'):
        fr, k, sat_, ram = T.load(tr)
        for t in range(len(fr)):
            if fr[t] in ys or fr[t] < 16009 or fr[t] > 24800: continue
            r = sorted(s[1] for s in T.sprites(sat_[t]) if s[2] == 376 and s[0] == 0)
            if r: ys[int(fr[t])] = r
    # y du premier (plus bas) débris, déroulé : y0 = y_max(t) tant que continu
    f0, f1 = 16009, max(ys)
    y0 = []
    cur = -64
    for f in range(f0, f1 + 1):
        r = ys.get(f)
        if r:
            # le débris suivi est celui dont y est le plus proche de cur
            cand = [v for v in r] + [v + 128 * k for v in r for k in (1, 2, -1)]
            cur = min(cand, key=lambda v: abs(v - cur - 0.4))
        y0.append(cur)
    # lancers d'anneau : première frame où un sprite de palette 13 apparaît (trace bs)
    fr, k, sat_, ram = T.load('dumps/bs/bs.trace')
    starts = []; inr = False
    for t in range(len(fr)):
        sp = [s for s in sat_[t] if False]
        has = any(s[3] == 13 for s in T.sprites(sat_[t]))
        if has and not inr and 18000 <= fr[t] <= 24770: starts.append(int(fr[t]));
        inr = has
    print('lancers d\'anneau (frame PCE):', starts)
    with open(SRC + 'boss_fx.h', 'w') as f:
        f.write('// Généré par tools/mkbossfx.py : anneaux du boss du stage 1 (frame de jeu = frame PCE - 2880)\n#ifndef BOSS_FX_H\n#define BOSS_FX_H\n#include <genesis.h>\n')
        f.write('#define RING_PALETTE_LINE %d\n' % lg)
        f.write('#define RING_NUM %d\nstatic const s16 ring_t[RING_NUM] = {%s};       // frame de jeu du lancer\n#endif\n' % (len(starts), ','.join(str(s - 2880) for s in starts)))
    with open(SRC + 'boss_rock.h', 'w') as f:
        f.write('// Généré par tools/mkbossfx.py : débris de roche des parois (plan A, défilement vertical) ; y du premier débris par frame de jeu\n#ifndef BOSS_ROCK_H\n#define BOSS_ROCK_H\n#include <genesis.h>\n')
        f.write('#define ROCK_PALETTE_LINE %d\n#define ROCK_START %d\n#define ROCK_NUM %d\n' % (lr, f0 - 2880, len(y0)))
        f.write('static const s16 rock_y[ROCK_NUM] = {%s};\n#endif\n' % ','.join(str(v) for v in y0))
    return ['TILESET boss_rock_tiles "boss_rock.png" NONE NONE', 'SPRITE spr_ring "boss_ring.png" 4 4 NONE 0']

if __name__ == '__main__':
    print(build('md/twinbee/res/', 'md/twinbee/src/'))
