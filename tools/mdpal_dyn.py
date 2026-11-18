#!/usr/bin/env python3
"""Réduction de palettes PCE -> Mega Drive avec palettes glissantes pour un niveau à défilement vertical.
On parcourt le niveau dans le sens du défilement (du bas de l'image vers le haut). Chaque couleur occupe un
emplacement (palette, index) tant qu'une ligne de tiles visible s'en sert ; un emplacement libéré peut être
réattribué, ce qui produit un événement « à la ligne R, écrire la couleur C dans l'emplacement E ».
usage: mdpal_dyn.py image.npy K out_prefix [premiere_palette] [fenetre_en_lignes_de_tiles]
sorties: out.png (indexé, pour rescomp), out_events.txt (ligne index couleurMD), statistiques"""
import sys, numpy as np
from PIL import Image

def rgb3(c): return np.array([(c >> 3) & 7, (c >> 6) & 7, c & 7])
def mdcol(c): r, g, b = rgb3(c); return (int(b) << 9) | (int(g) << 5) | (int(r) << 1)

def main():
    img = np.load(sys.argv[1]); K = int(sys.argv[2]); out = sys.argv[3]
    first = int(sys.argv[4]) if len(sys.argv) > 4 else 0; WIN = int(sys.argv[5]) if len(sys.argv) > 5 else 32
    H, W = img.shape; TH, TW = H // 8, W // 8
    tiles = img.reshape(TH, 8, TW, 8).transpose(0, 2, 1, 3).reshape(TH, TW, 64)
    vals, cnt = np.unique(img, return_counts=True); backdrop = int(vals[cnt.argmax()])
    slot = [[None] * 15 for _ in range(K)]          # couleur dans chaque emplacement
    last = [[10 ** 9] * 15 for _ in range(K)]       # dernière ligne de tiles qui s'en est servie
    home = {}
    outidx = np.zeros((H, W), np.uint8); events = []; bad_tiles = 0; bad_px = 0
    for r in range(TH - 1, -1, -1):
        def free(k, j): return slot[k][j] is None or last[k][j] >= r + WIN
        groups = {}
        for x in range(TW): groups.setdefault(frozenset(tiles[r, x].tolist()) - {backdrop}, []).append(x)
        for s in sorted(groups, key=lambda s: -len(s)):
            best = None
            for k in range(K):
                have = set(slot[k]); new = [c for c in s if c not in have]
                nfree = sum(1 for j in range(15) if free(k, j) and slot[k][j] not in s)
                if len(new) <= nfree:
                    cand = (len(new), -sum(1 for c in new if home.get(c, (None,))[0] == k), -nfree, k)
                    if best is None or cand < best: best = cand
            if best is None:
                # aucun emplacement : palette dont les couleurs sont les plus proches
                def cost(k):
                    cs = [backdrop] + [c for c in slot[k] if c is not None]
                    return sum(min(int(((rgb3(c) - rgb3(x)) ** 2).sum()) for x in cs) for c in s)
                k = min(range(K), key=cost); bad_tiles += len(groups[s])
            else:
                k = best[3]
                for c in s:
                    if c in slot[k]: continue
                    # emplacement libre le plus anciennement inutilisé (les vides d'abord)
                    cands = [j for j in range(15) if free(k, j) and slot[k][j] not in s]
                    j = max(cands, key=lambda j: (home.get(c) == (k, j), slot[k][j] is None, last[k][j]))
                    home[c] = (k, j)
                    slot[k][j] = c; last[k][j] = r; events.append((r, (first + k) * 16 + 1 + j, mdcol(c)))
            m = {backdrop: (first + k) * 16}
            for c in s:
                if c in slot[k]:
                    j = slot[k].index(c); last[k][j] = r; m[c] = (first + k) * 16 + 1 + j
                else:
                    cs = [(backdrop, 0)] + [(x, 1 + j) for j, x in enumerate(slot[k]) if x is not None]
                    x, j = min(cs, key=lambda e: int(((rgb3(c) - rgb3(e[0])) ** 2).sum())); m[c] = (first + k) * 16 + j
                    if j: last[k][j - 1] = r
                    bad_px += sum(int((tiles[r, xx] == c).sum()) for xx in groups[s])
            for x in groups[s]:
                outidx[r * 8:r * 8 + 8, x * 8:x * 8 + 8] = np.vectorize(m.get)(tiles[r, x]).reshape(8, 8)
    palette = np.zeros((256, 3), np.uint8)
    for i in range(64): palette[i] = (i * 4, 255 - i * 4, (i * 37) % 256)      # couleurs arbitraires (fixées à l'exécution)
    im = Image.fromarray(outidx, 'P'); im.putpalette(palette.flatten().tolist()); im.save(out + '.png')
    np.save(out + '_idx.npy', outidx)
    with open(out + '_events.txt', 'w') as f:
        f.write('backdrop %04X\n' % mdcol(backdrop))
        for e in events: f.write('%d %d %04X\n' % e)
    t = outidx.reshape(TH, 8, TW, 8).transpose(0, 2, 1, 3).reshape(-1, 64)
    print('K=%d fenêtre=%d : %d événements de palette ; tiles sans palette exacte %d/%d ; pixels modifiés %d/%d (%.4f%%) ; tiles uniques (index) %d'
          % (K, WIN, len(events), bad_tiles, TH * TW, bad_px, H * W, 100 * bad_px / (H * W), len(np.unique(t, axis=0))))
main()
