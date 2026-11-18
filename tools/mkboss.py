"""Boss de fin (crabe) : sprites des pièces, poses et trajectoire relevées sur la trace PCE `dumps/ce` (joueur immobile).
Produit res/boss_l.png (32x32), res/boss_s.png (32x16), src/boss_data.h et renvoie les lignes resources.res."""
import sys, re, pickle, numpy as np
sys.path.insert(0, 'tools'); import pcegfx, pcesprites
from PIL import Image
def rgb(c): return np.array([((c >> 3) & 7) * 36, ((c >> 6) & 7) * 36, (c & 7) * 36])
def mdrgb(m): return np.array([((m >> 1) & 7) * 36, ((m >> 5) & 7) * 36, ((m >> 9) & 7) * 36])
def build(RES, SRC):
    poses, seq = pickle.load(open('extract/boss_poses.pkl', 'rb'))
    vram, sat, pal, reg = pcegfx.load('dumps/bs/b18100')
    # palettes MD (lignes 0 et 1) à la fin du niveau : on applique tous les événements de palette
    cram = [0] * 64
    for m in re.finditer(r'\{(\d+), (\d+), (0x[0-9A-Fa-f]+)\}', open(SRC + 'stage1_pal.h').read()): cram[int(m.group(2))] = int(m.group(3), 16)
    pats = sorted({e[0] for p in poses for e in p}); big = [p for p in pats if any(e[0] == p and e[3] == 32 for q in poses for e in q)]
    small = [p for p in pats if p not in big]
    best = None
    for line in (0, 1):
        pcol = np.array([mdrgb(cram[line * 16 + i]) for i in range(1, 16)])
        err = 0
        for p in pats:
            h = 32 if p in big else 16; im = pcesprites.sprite(vram, pal, p, 32, h, 12)
            for c in im[im >= 0].ravel(): err += ((pcol - rgb(int(c))) ** 2).sum(1).min()
        if best is None or err < best[0]: best = (err, line)
    line = best[1]; pcol = np.array([mdrgb(cram[line * 16 + i]) for i in range(1, 16)])
    print('boss : palette BG ligne', line, 'erreur', best[0])
    lines = []
    for name, plist, h in (('boss_l', big, 32), ('boss_s', small, 16)):
        sheet = np.zeros((h, 32 * len(plist)), np.uint8)
        for k, p in enumerate(plist):
            im = pcesprites.sprite(vram, pal, p, 32, h, 12)
            for y in range(h):
                for x in range(32):
                    if im[y, x] >= 0: sheet[y, k * 32 + x] = 1 + int(((pcol - rgb(int(im[y, x]))) ** 2).sum(1).argmin())
        o = Image.fromarray(sheet, 'P'); pl = [255, 0, 255]
        for i in range(15): pl += [int(v) for v in pcol[i]]
        pl += [0] * (768 - len(pl)); o.putpalette(pl); o.save(RES + name + '.png')
        lines.append('SPRITE spr_%s "%s.png" 4 %d NONE 0' % (name, name, h // 8))
    # pièces par pose : {classe(0 grand, 1 petit), image, flip, dx, dy}
    pl_ = [sorted(poses, key=lambda s: 0)]
    plist = list(poses)
    with open(SRC + 'boss_data.h', 'w') as f:
        f.write('// Généré par tools/mkboss.py : pièces du boss (sprites) et trajectoire relevée sur la trace PCE (frame PCE 17500 = frame de jeu 14620)\n#ifndef BOSS_DATA_H\n#define BOSS_DATA_H\n#include <genesis.h>\n')
        f.write('#define BOSS_PALETTE_LINE %d\n#define BOSS_START_FRAME 14620\n#define BOSS_NUM_FRAMES %d\n#define BOSS_NUM_POSES %d\n' % (line, len(seq), len(plist)))
        f.write('typedef struct { u8 small; u8 frame; u8 flip; s16 dx; s16 dy; } BossPiece;\ntypedef struct { u8 n; BossPiece p[12]; } BossPose;\n')
        f.write('static const BossPose boss_poses[BOSS_NUM_POSES] = {\n')
        mx = [0, 0]
        for sig in plist:
            f.write('    {%d, {' % len(sig)); cl = [0, 0]
            for (p, hf, w, h, dx, dy) in sig:
                small_ = 0 if p in big else 1; fr = (small if small_ else big).index(p); cl[small_] += 1
                f.write('{%d, %d, %d, %d, %d}, ' % (small_, fr, hf, dx, dy))
            mx = [max(mx[0], cl[0]), max(mx[1], cl[1])]
            f.write('}},\n')
        f.write('};\n#define BOSS_MAX_BIG %d\n#define BOSS_MAX_SMALL %d\n' % tuple(mx))
        f.write('static const u8 boss_pose[BOSS_NUM_FRAMES] = {%s};\n' % ','.join(str(255 if s[0] < 0 else s[0]) for s in seq))
        f.write('static const u8 boss_ax[BOSS_NUM_FRAMES] = {%s};\n' % ','.join(str(max(0, s[1])) for s in seq))
        f.write('static const s8 boss_ay[BOSS_NUM_FRAMES] = {%s};\n#endif\n' % ','.join(str(max(-128, min(127, s[2]))) for s in seq))
    lines.append('IMAGE boss_clear "boss_clear.png" BEST ALL')
    return lines
