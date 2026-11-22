#!/usr/bin/env python3
"""Boss « sprites » rejoué depuis une trace PCE (SAT par frame).
usage : mkbossN.py N trace first_frame F0 F1 vram_dump "pat,pat,..." [x0,x1,y0,y1]
Produit res/bossN_<w>x<h>.png (feuilles de sprites, palette commune 15 couleurs), src/bossN_data.h, et ajoute les lignes à res/bossN.res
Les pièces du boss sont les sprites de la SAT dont le motif figure dans la liste ; leurs positions sont rejouées frame par frame."""
import sys, collections, numpy as np
sys.path.insert(0, 'tools'); import pcegfx, pcesprites, pcetrace
from PIL import Image
def rgb(c): return np.array([((c >> 3) & 7) * 36, ((c >> 6) & 7) * 36, (c & 7) * 36])
def md9(c):   # couleur PCE 9 bits GRB -> MD 0BGR
    g, r, b = (c >> 6) & 7, (c >> 3) & 7, c & 7
    return (b << 9) | (g << 5) | (r << 1)
def dist(cen, c):
    return ((np.asarray(cen, float) - c) ** 2).sum(-1)
def decode(a):
    cgx = (a >> 8) & 1; cgy = (a >> 12) & 3
    return (32 if cgx else 16), [16, 32, 64, 64][cgy], a & 15, bool(a & 0x800), bool(a & 0x8000)
def main():
    N = int(sys.argv[1]); trace = sys.argv[2]; first = int(sys.argv[3]); F0 = int(sys.argv[4]); F1 = int(sys.argv[5])
    vram, sat0, pal, reg = pcegfx.load(sys.argv[6]); pats = {int(x) for x in sys.argv[7].split(',')}
    box = [int(x) for x in sys.argv[8].split(',')] if len(sys.argv) > 8 else None
    fr, k, sat, ram = pcetrace.load(trace)
    frames = []   # par frame : liste (x, y, pat, w, h, pal, hf, vf)
    for F in range(F0, F1 + 1):
        t = F - first
        L = []
        for i in range(64):
            y, x, pat, at = [int(v) for v in sat[t][i]]
            if pat == 0 and at == 0: continue
            w, h, p, hf, vf = decode(at); base = (pat >> 1) & 0x3FF
            if base not in pats and (base & ~1) not in pats and (base & ~3) not in pats: continue
            sx, sy = (x & 0x3FF) - 32, (y & 0x3FF) - 64
            L.append((sx, sy, base, w, h, p, hf, vf))
        frames.append(L)
    # images distinctes (motif, w, h, pal)
    keys = sorted({(e[2], e[3], e[4], e[5]) for L in frames for e in L})
    cols = collections.Counter()
    ims = {}
    for kk in keys:
        im = pcesprites.sprite(vram, pal, kk[0], kk[1], kk[2], kk[3]); ims[kk] = im
        for c in im[im >= 0].ravel(): cols[int(c)] += 1
    print('images', len(keys), 'couleurs PCE', len(cols))
    # palette de 15 couleurs : k-means pondéré (initialisé sur les plus fréquentes)
    allc = list(cols); wts = np.array([cols[c] for c in allc], float); pts = np.array([rgb(c) for c in allc], float)
    order = np.argsort(-wts); cen = pts[order[:min(15, len(allc))]].copy()
    for _ in range(30):
        d = ((pts[:, None, :] - cen[None]) ** 2).sum(2); a = d.argmin(1)
        for j in range(len(cen)):
            m = a == j
            if m.any(): cen[j] = (pts[m] * wts[m, None]).sum(0) / wts[m].sum()
    import os
    PAL2 = bool(os.environ.get('PAL2'))
    if PAL2:
        pp = Image.open('md/twinbee/res/spr_body.png').getpalette(); cen = np.array([pp[i * 3:i * 3 + 3] for i in range(1, 16)], float)
    # arrondi à la grille MD (multiples de 36)
    cen = np.round(cen / 36).clip(0, 7) * 36
    mdcols = [(int(c[2] // 36) << 9) | (int(c[1] // 36) << 5) | (int(c[0] // 36) << 1) for c in cen]
    # classes de taille
    classes = sorted({(kk[1], kk[2]) for kk in keys}); lines = []; fidx = {}
    for (w, h) in classes:
        ks = [kk for kk in keys if (kk[1], kk[2]) == (w, h)]
        sheet = np.zeros((h, w * len(ks)), np.uint8)
        for j, kk in enumerate(ks):
            im = ims[kk]; fidx[kk] = j
            for y in range(h):
                for x in range(w):
                    if im[y, x] >= 0: sheet[y, j * w + x] = 1 + int(dist(cen, rgb(int(im[y, x]))).argmin())
        o = Image.fromarray(sheet, 'P'); pl = [255, 0, 255]
        for i in range(len(cen)): pl += [int(v) for v in cen[i]]
        pl += [0] * (768 - len(pl)); o.putpalette(pl); o.save('md/twinbee/res/boss%d_%dx%d.png' % (N, w, h))
        lines.append('SPRITE spr_b%d_%dx%d "boss%d_%dx%d.png" %d %d NONE 0' % (N, w, h, N, w, h, w // 8, h // 8))
    # flux binaire : par frame  n, masque (1 bit/pièce : forme changée), puis pièces ; forme inchangée = dx,dy (s8), sinon cls/flip, image, x, y (s16)
    prev = []; out = bytearray(); offs = []; classMax = [0] * len(classes); full = delta = 0
    for L in frames:
        cur = [(classes.index((e[3], e[4])), fidx[(e[2], e[3], e[4], e[5])], int(e[6]) | (int(e[7]) << 1), e[0], e[1]) for e in L]
        c = collections.Counter(e[0] for e in cur)
        for j, v in c.items(): classMax[j] = max(classMax[j], v)
        offs.append(len(out)); out.append(len(cur))
        mask = bytearray((len(cur) + 7) // 8); body = bytearray()
        for i, e in enumerate(cur):
            if i < len(prev) and prev[i][:3] == e[:3] and -128 <= e[3] - prev[i][3] <= 127 and -128 <= e[4] - prev[i][4] <= 127:
                body += bytes([(e[3] - prev[i][3]) & 255, (e[4] - prev[i][4]) & 255]); delta += 1
            else:
                mask[i >> 3] |= 1 << (i & 7)
                body += bytes([e[0] | (e[2] << 4), e[1]]) + (e[3] & 0xFFFF).to_bytes(2, 'big') + (e[4] & 0xFFFF).to_bytes(2, 'big'); full += 1
        out += mask + body; prev = cur
    offs.append(len(out))
    print('flux', len(out), 'octets ; pièces delta', delta, 'complètes', full, 'frames', len(frames))
    with open('md/twinbee/src/boss%d_data.h' % N, 'w') as f:
        f.write('// Généré par tools/mkbossN.py : boss du stage %d rejoué (frames PCE %d..%d) ; format : n, masque, pièces (voir bossn.c)\n#ifndef BOSS%d_DATA_H\n#define BOSS%d_DATA_H\n#include <genesis.h>\n' % (N, F0, F1, N, N))
        f.write('#define BOSS%d_FRAMES %d\n#define BOSS%d_NCLASS %d\n' % (N, len(frames), N, len(classes)))
        f.write('#define BOSS%d_PALLINE %d\n' % (N, 2 if PAL2 else 1))
        f.write('static const u16 boss%d_colors[15] = {%s};\n' % (N, ','.join('0x%04X' % c for c in mdcols)))
        f.write('static const u8 boss%d_classMax[%d] = {%s};\n' % (N, len(classes), ','.join(str(v) for v in classMax)))
        f.write('#define BOSS%d_DEFS {%s}\n' % (N, ','.join('&spr_b%d_%dx%d' % (N, w, h) for (w, h) in classes)))
        f.write('static const u8 boss%d_flux[%d] = {%s};\n#endif\n' % (N, len(out), ','.join(str(v) for v in out)))
    open('extract/boss%d.res' % N, 'w').write('\n'.join(lines) + '\n')
    print('\n'.join(lines))
main()
