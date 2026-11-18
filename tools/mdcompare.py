#!/usr/bin/env python3
"""Compare des captures Mega Drive (ppm) au décor PCE recollé (npy, couleurs 9 bits).
usage: mdcompare.py stage.npy hauteur_terrain captures.ppm..."""
import sys, numpy as np
from PIL import Image
st = np.load(sys.argv[1]); PH = int(sys.argv[2])
for p in sys.argv[3:]:
    a = np.array(Image.open(p).convert('RGB')).astype(int)
    c9 = ((a[:, :, 1] >> 5) << 6) | ((a[:, :, 0] >> 5) << 3) | (a[:, :, 2] >> 5)
    pf = c9[:PH]; best = None
    # recherche de la position verticale par quelques lignes, puis comptage exact
    sig = pf[::16]
    d = np.array([int((st[y:y + PH:16] != sig).sum()) for y in range(0, st.shape[0] - PH + 1)])
    cand = np.where(d <= d.min() + 64)[0]               # décor répétitif : on départage par comparaison complète
    diff, y = min((int((st[y:y + PH] != pf).sum()), int(y)) for y in cand)
    print('%s %dx%d  position décor y=%d  pixels différents sur le terrain: %d / %d' % (p.split('/')[-1], a.shape[1], a.shape[0], y, diff, PH * 256))
