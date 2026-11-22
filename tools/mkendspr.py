#!/usr/bin/env python3
"""Sprites de la fin rejoués depuis la trace PCE (dumps/end6b/en.trace, SAT par frame ; motifs lus dans le dump le plus proche).
Une scène = un jeu de feuilles (une par taille) + une palette de 15 couleurs (PAL3) + un flux (voir end.c). Sortie : src/end_spr.h, res/end_<s>_<w>x<h>.png, extract/end_spr.res"""
import sys, collections, numpy as np, hashlib
sys.path.insert(0, 'tools'); import pcegfx, pcesprites, pcetrace
from PIL import Image
T0 = 125700
SC = [('a', 126340, 128780), ('b', 128780, 133380), ('c', 133380, 136040), ('i', 530, 1745)]
def rgb3(c): return np.array([((c >> 3) & 7), ((c >> 6) & 7), (c & 7)]) * 36
fr, k_, sat, ram = pcetrace.load('dumps/end6b/en.trace')
fri, k_i, sati, rami = pcetrace.load('dumps/intro/in.trace')      # intro : dumps toutes les 2 frames (530-1178) puis toutes les frames
dumpcache = {}
def dump(F, intro=False):
    if intro:
        d = F if F >= 1180 else (F + 1) // 2 * 2
        d = min(max(300, d), 1744)
        key = ('i', d); path = 'dumps/intro/v%04d' % d
    else:
        d = min(max(125800, (F + 10) // 20 * 20), 136040); key = d; path = 'dumps/end6b/w%d' % d
    if key not in dumpcache:
        v, s, p, r = pcegfx.load(path); dumpcache[key] = (v, p, pcegfx.spr16(v))
    return dumpcache[key]
def spr(v, p, s16, pat, w, h, pl):
    base = pat
    if w == 32: base &= ~1
    if h >= 32: base &= ~2
    if h == 64: base &= ~4
    img = np.zeros((h, w), int)
    for cy in range(h // 16):
        for cx in range(w // 16): img[cy * 16:cy * 16 + 16, cx * 16:cx * 16 + 16] = s16[(base + cy * 2 + cx) & 511]
    return np.where(img == 0, -1, (p & 0x1FF)[256 + pl * 16 + img])
res_lines = []; hdr = ['// Généré par tools/mkendspr.py : sprites de la fin\n#ifndef END_SPRD_H\n#define END_SPRD_H\n#include <genesis.h>\n']
infos = []
for name, f0, f1 in SC:
    frames = []; ims = {}; cols = collections.Counter(); use = collections.Counter()
    for F in range(f0, f1):
        INTRO = (name == 'i')
        v, p, s16 = dump(F, INTRO); L = []
        SATF = sati[F - fri[0]] if INTRO else sat[F - T0]
        for (x, y, pat, pl, hf, w, h, i) in pcetrace.sprites(SATF):
            vf = bool(SATF[i][3] & 0x8000)
            if x <= -w or x >= 256 or y <= -h - 12 or y >= 224 + 12: continue          # hors écran
            im = spr(v, p, s16, pat, w, h, pl)
            if (im >= 0).sum() == 0: continue
            key = (hashlib.md5(im.tobytes()).hexdigest()[:12], w, h)
            if key not in ims: ims[key] = im
            use[key] += 1
            L.append((x, y - 12, key, hf, vf))
        frames.append(L)
    for key, im in ims.items():
        for c in im[im >= 0].ravel(): cols[int(c)] += 1
    NG = 2 if name in 'ai' else 1
    def kmeans(pts, wts, k, it=40, init=None):
        if init is None:
            cen = [pts[int(np.argmax(wts))]]
            while len(cen) < min(k, len(pts)):
                d = ((pts[:, None, :] - np.array(cen)[None]) ** 2).sum(2).min(1)
                cen.append(pts[int(np.argmax(d * wts))])          # k-means++ déterministe : garde les couleurs rares (yeux, bouche)
            cen = np.array(cen, float)
        else: cen = init.copy()
        for _ in range(it):
            d = ((pts[:, None, :] - cen[None]) ** 2).sum(2); a_ = d.argmin(1)
            for j in range(len(cen)):
                m = a_ == j
                if m.any(): cen[j] = (pts[m] * wts[m, None]).sum(0) / wts[m].sum()
        return np.round(cen / 36).clip(0, 7) * 36
    keys = sorted(ims)
    def pix(kk):
        im = ims[kk]; v = im[im >= 0]; u, n = np.unique(v, return_counts=True); return u, n
    img_cols = {kk: pix(kk) for kk in keys}
    import random
    best = None
    for seed in range(6 if NG > 1 else 1):
        rnd = random.Random(seed); grp = {kk: (rnd.randrange(NG) if NG > 1 else 0) for kk in keys}
        for _ in range(8):
            cens = []
            for g in range(NG):
                cc = collections.Counter()
                for kk in keys:
                    if grp[kk] == g:
                        for c, n in zip(*img_cols[kk]): cc[int(c)] += int(n)
                if not cc: cc[0] = 1
                al = list(cc); w = np.sqrt(np.array([cc[c] for c in al], float)); pt = np.array([rgb3(c) for c in al], float)
                cens.append(kmeans(pt, w, 15))
            err = 0; new = {}
            for kk in keys:
                u, n = img_cols[kk]; pt = np.array([rgb3(int(c)) for c in u], float)
                es = [(n * ((pt[:, None, :] - cn[None]) ** 2).sum(2).min(1)).sum() for cn in cens]
                new[kk] = int(np.argmin(es)); err += min(es)
            if new == grp: break
            grp = new
        if best is None or err < best[0]: best = (err, dict(grp), [c.copy() for c in cens])
    err, grp, cens = best
    mdcols = []
    for g in range(NG):
        cn = cens[g] if g < len(cens) else np.zeros((0, 3))
        mdcols += [(int(c[2] // 36) << 9) | (int(c[1] // 36) << 5) | (int(c[0] // 36) << 1) for c in cn] + [0] * (15 - len(cn))
    classes = sorted({(k[1], k[2], grp[k]) for k in ims}); fidx = {}
    for (w, h, g) in classes:
        ks = sorted([k for k in ims if (k[1], k[2], grp[k]) == (w, h, g)]); sheet = np.zeros((h, w * len(ks)), np.uint8); cen = cens[g]
        for j, kk in enumerate(ks):
            fidx[kk] = j; im = ims[kk]
            for y in range(h):
                for x in range(w):
                    if im[y, x] >= 0: sheet[y, j * w + x] = 1 + int(((cen - rgb3(int(im[y, x]))) ** 2).sum(1).argmin())
        o = Image.fromarray(sheet, 'P'); pl_ = [255, 0, 255]
        for c in cen: pl_ += [int(t) for t in c]
        pl_ += [0] * (768 - len(pl_)); o.putpalette(pl_); o.save('md/twinbee/res/end_%s_%dx%d_%d.png' % (name, w, h, g))
        res_lines.append('SPRITE spr_end_%s_%dx%d_%d "end_%s_%dx%d_%d.png" %d %d NONE 0' % (name, w, h, g, name, w, h, g, w // 8, h // 8))
    prev = []; out = bytearray(); classMax = [0] * len(classes)
    for L in frames:
        cur = [(classes.index((e[2][1], e[2][2], grp[e[2]])), fidx[e[2]], int(e[3]) | (int(e[4]) << 1), e[0], e[1]) for e in L]
        c = collections.Counter(e[0] for e in cur)
        for j, v_ in c.items(): classMax[j] = max(classMax[j], v_)
        out.append(len(cur)); mask = bytearray((len(cur) + 7) // 8); body = bytearray()
        for i, e in enumerate(cur):
            if i < len(prev) and prev[i][:3] == e[:3] and -128 <= e[3] - prev[i][3] <= 127 and -128 <= e[4] - prev[i][4] <= 127:
                body += bytes([(e[3] - prev[i][3]) & 255, (e[4] - prev[i][4]) & 255])
            else:
                mask[i >> 3] |= 1 << (i & 7)
                body += bytes([e[0] | (e[2] << 4)]) + bytes([e[1] & 255, e[1] >> 8]) + (e[3] & 0xFFFF).to_bytes(2, 'big') + (e[4] & 0xFFFF).to_bytes(2, 'big')
        out += mask + body; prev = cur
    print(name, 'images', len(ims), 'couleurs', len(cols), 'flux', len(out), 'classMax', classMax, 'max sprites', max(len(l) for l in frames))
    N = name.upper()
    hdr.append('#define ENDS_%s_NCLASS %d\n#define ENDS_%s_FRAMES %d\n#define ENDS_%s_START %d\n' % (N, len(classes), N, len(frames), N, f0))
    hdr.append('#define ENDS_%s_NG %d\n#define ENDS_%s_CPAL {%s}\n' % (N, NG, N, ','.join(str(4 - NG + g) for (w, h, g) in classes)))
    hdr.append('static const u16 ends_%s_colors[%d] = {%s};\n' % (name, 15 * NG, ','.join('0x%04X' % c for c in mdcols)))
    hdr.append('static const u8 ends_%s_classMax[%d] = {%s};\n' % (name, len(classes), ','.join(map(str, classMax))))
    hdr.append('#define ENDS_%s_DEFS {%s}\n' % (N, ','.join('&spr_end_%s_%dx%d_%d' % (name, w, h, g) for (w, h, g) in classes)))
    hdr.append('static const u8 ends_%s_flux[%d] = {%s};\n' % (name, len(out), ','.join(map(str, out))))
hdr.append('#endif\n')
open('md/twinbee/src/end_sprd.h', 'w').write(''.join(hdr))
open('md/twinbee/res/end_spr.res', 'w').write('\n'.join(res_lines) + '\n')
