#!/usr/bin/env python3
"""Réduction de palettes PCE -> Mega Drive : répartit les tiles 8x8 d'une image (couleurs 9 bits)
sur K palettes de 15 couleurs + 1 couleur de fond commune, puis écrit un PNG indexé pour rescomp.
usage: mdpal.py image.npy K out_prefix [premiere_palette]"""
import sys, random, numpy as np
from PIL import Image

def rgb3(c): return np.array([(c >> 3) & 7, (c >> 6) & 7, c & 7])   # 9 bits GRB -> (r,g,b) sur 3 bits

def solve(sets, weights, K, backdrop, tries=300, seed=1):
    """sets: liste de frozenset de couleurs (hors fond). Cherche K palettes de <=15 couleurs couvrant un max de pixels."""
    rnd = random.Random(seed); best = None
    order0 = sorted(range(len(sets)), key=lambda i: (-len(sets[i]), -weights[i]))
    for t in range(tries):
        order = order0[:] if t == 0 else sorted(order0, key=lambda i: (-len(sets[i]) + rnd.random() * 2.5, rnd.random()))
        pals = [set() for _ in range(K)]; assign = {}; lost = 0
        for i in order:
            s = sets[i]; opts = [(len(s - p), len(p), k) for k, p in enumerate(pals) if len(p | s) <= 15]
            if opts:
                k = min(opts)[2]; pals[k] |= s; assign[i] = k
            else:
                assign[i] = None; lost += weights[i]
        if best is None or lost < best[0]: best = (lost, [set(p) for p in pals], dict(assign))
        if lost == 0: break
    return best

def main():
    img = np.load(sys.argv[1]); K = int(sys.argv[2]); out = sys.argv[3]; first = int(sys.argv[4]) if len(sys.argv) > 4 else 0
    H, W = img.shape; tiles = img.reshape(H // 8, 8, W // 8, 8).transpose(0, 2, 1, 3).reshape(-1, 64)
    vals, cnt = np.unique(img, return_counts=True); backdrop = int(vals[cnt.argmax()])
    uniq, inv = np.unique(tiles, axis=0, return_inverse=True); inv = inv.reshape(-1); tcount = np.bincount(inv)
    usets = [frozenset(u.tolist()) - {backdrop} for u in uniq]
    setlist = sorted(set(usets), key=lambda s: sorted(s)); sidx = {s: i for i, s in enumerate(setlist)}
    w = [0] * len(setlist)
    for u, s in enumerate(usets): w[sidx[s]] += int(tcount[u])
    lost, pals, assign = solve(setlist, w, K, backdrop)
    pals = [sorted(p) for p in pals]
    lut = {c: rgb3(c) for c in vals.tolist()}
    def nearest(c, pal):  # couleur de la palette (ou fond) la plus proche
        cs = [backdrop] + pal; d = [int(((lut[c] - rgb3(x)) ** 2).sum()) for x in cs]; j = int(np.argmin(d)); return j, d[j]
    # index par tile unique
    uidx = np.zeros((len(uniq), 64), np.uint8); upal = np.zeros(len(uniq), int); err_px = 0; err_tiles = 0
    for u in range(len(uniq)):
        k = assign[sidx[usets[u]]]
        if k is None:   # pas de palette exacte : on prend celle qui minimise l'erreur
            costs = [sum(nearest(int(c), pals[kk])[1] for c in uniq[u]) for kk in range(K)]; k = int(np.argmin(costs)); err_tiles += int(tcount[u])
        upal[u] = k
        for i, c in enumerate(uniq[u]):
            j, d = nearest(int(c), pals[k]); uidx[u, i] = (first + k) * 16 + j
            if d: err_px += int(tcount[u])
    full = uidx[inv].reshape(H // 8, W // 8, 8, 8).transpose(0, 2, 1, 3).reshape(H, W)
    palette = np.zeros((256, 3), np.uint8)
    for k in range(4):
        palette[k * 16] = rgb3(backdrop) * 36
        if first <= k < first + K:
            for j, c in enumerate(pals[k - first]): palette[k * 16 + 1 + j] = rgb3(c) * 36
    im = Image.fromarray(full, 'P'); im.putpalette(palette.flatten().tolist()); im.save(out + '.png')
    print('K=%d : palettes de %s couleurs (+fond %03X) ; tiles sans palette exacte : %d/%d (%.2f%%) ; pixels modifiés : %d/%d (%.3f%%)'
          % (K, [len(p) for p in pals], backdrop, err_tiles, len(tiles), 100 * err_tiles / len(tiles), err_px, H * W, 100 * err_px / (H * W)))
    return pals

main()
