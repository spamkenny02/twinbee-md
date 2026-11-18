#!/usr/bin/env python3
"""Recolle le décor d'un niveau à défilement vertical à partir d'une série de dumps pcedump.
Pour chaque dump : rendu du BAT sans sprites, recherche du scroll Y par comparaison avec la capture,
puis écriture des lignes visibles dans une grande image (valeurs = couleurs PCE 9 bits).
usage: stitch.py dumpdir first last step out_prefix"""
import sys, numpy as np
from PIL import Image
sys.path.insert(0, 'tools'); import pcegfx

def render(prefix):
    vram, sat, pal, reg = pcegfx.load(prefix)
    bat = vram[:4096].reshape(64, 64); t8 = pcegfx.tiles8(vram)
    px = t8[bat & 0x7FF]
    idx = ((bat >> 12)[:, :, None, None] * 16 + px)
    idx = np.where(px == 0, 0, idx)                      # couleur 0 de tile = couleur de fond globale
    full = idx.transpose(0, 2, 1, 3).reshape(512, 512)
    return (pal & 0x1FF)[full], pal & 0x1FF              # image en couleurs 9 bits

def shot(prefix):
    m = dict(l.split(None, 1) for l in open(prefix + '.txt')); w, h = int(m['width']), int(m['height'])
    a = np.frombuffer(open(prefix + '.rgba', 'rb').read(), np.uint8).reshape(h, w, 4)[:, :, :3].astype(int)
    return (a[:, :, 1] >> 5 << 6) | (a[:, :, 0] >> 5 << 3) | (a[:, :, 2] >> 5)   # -> 9 bits GRB

def main():
    d, first, last, step, out = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]), sys.argv[5]
    R0, R1 = 24, 184                                      # lignes écran utilisées pour la mise en correspondance
    rows = {}; prev = None; P = 0; log = []; last_d = 0
    for f in range(first, last + 1, step):
        pre = '%s/s%05d' % (d, f); bg, pal = render(pre); sc = shot(pre)
        tall = np.vstack([bg[:, :256], bg[:256, :256]])
        score = np.array([(tall[y + R0:y + R1] == sc[R0:R1]).mean() for y in range(512)])
        q = float(score.max())
        if q < 0.55: log.append((f, int(score.argmax()), q, None)); continue
        cand = np.where(score >= q - 0.02)[0]             # décor répétitif : plusieurs positions possibles
        if prev is None: y0 = int(score.argmax()); dl = 0
        else:
            ds = ((cand - prev + 256) % 512) - 256
            k = int(np.abs(ds - last_d).argmin()); y0 = int(cand[k]); dl = int(ds[k]); P += dl
        last_d = dl
        prev = y0; log.append((f, y0, q, P))
        # lignes de l'aire de jeu : celles où la capture correspond au fond (hors sprites) à >50 %
        for r in range(0, 208):
            if (tall[y0 + r] == sc[r]).mean() > 0.5: rows[P + r] = tall[y0 + r]
    ys = sorted(rows); c = (P - prev) % 8
    top = ys[0] - ((ys[0] - c) % 8)                      # aligne le haut sur la grille de tiles
    H = ys[-1] - top + 1; H += (-H) % 8
    img = np.zeros((H, 256), np.int32) - 1
    for y in ys: img[y - top] = rows[y]
    np.save(out + '.npy', img)
    g = (img >> 6) & 7; r = (img >> 3) & 7; b = img & 7
    rgb = np.stack([r, g, b], -1) * 255 // 7; rgb[img < 0] = (255, 0, 255)
    Image.fromarray(rgb.astype(np.uint8)).save(out + '.png')
    with open(out + '_log.txt', 'w') as fo:
        for l in log: fo.write('%d y0=%d score=%.2f P=%s\n' % l)
    miss = int((img[:, 0] < 0).sum())
    print('image %dx%d, lignes manquantes %d, dumps rejetés %d/%d, P final %d' % (256, H, miss, sum(1 for l in log if l[3] is None), len(log), P))
main()
