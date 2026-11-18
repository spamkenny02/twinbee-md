#!/usr/bin/env python3
"""Tirs ennemis génériques (objets 48..65, type 1) de toutes les traces de stage complet -> extract/ebul.pkl : liste (frame_pce, x, y, angle_obs, px, py)"""
import sys, glob, pickle, numpy as np
sys.path.insert(0, 'tools'); import pcetrace
out = {}
for path in sorted(glob.glob('dumps/*/*.trace')):
    try: fr, keys, sat, ram = pcetrace.load(path)
    except Exception as e: continue
    if len(fr) < 5000 or fr[0] > 3000: continue
    n = len(fr)
    # tronque à la première frame décroissante
    d = np.where(np.diff(fr) <= 0)[0]
    if len(d): n = d[0] + 1
    R = np.array(ram[:n]).astype(int)
    A = lambda base, k: R[:, base + k - 0x2000]
    cnt = 0
    for k in range(48, 66):
        ty = A(0x2F1C, k); on = np.where((ty[1:] != 0) & (ty[:-1] == 0))[0] + 1
        for t in on:
            x = int(A(0x2B47, k)[t]) + 256 * int(A(0x2ADA, k)[t]); y = int(A(0x2C8E, k)[t]) + 256 * int(A(0x2C21, k)[t])
            vx = (int(A(0x3063, k)[t]) << 8) | int(A(0x30D0, k)[t]); vy = (int(A(0x313D, k)[t]) << 8) | int(A(0x31AA, k)[t])
            vx -= 65536 * (vx >= 32768); vy -= 65536 * (vy >= 32768)
            if fr[t] > 18000: continue       # hors boss de fin (traité à part)
            key = (int(fr[t]), x, y, vx, vy)
            out.setdefault(key, (path, int(A(0x2B47, 0)[t]), int(A(0x2C8E, 0)[t]))); cnt += 1
    print(path, n, fr[0], fr[n - 1], cnt)
ev = sorted(out.items())
pickle.dump(ev, open('extract/ebul.pkl', 'wb'))
print(len(ev))
