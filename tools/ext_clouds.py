#!/usr/bin/env python3
"""Nuages (objets 90..95, type 1) d'une trace : [frame, x, y, vitesse px/frame, durée]. usage: ext_clouds.py trace t0frame first last out.json"""
import sys, json, numpy as np
sys.path.insert(0, 'tools'); import pcetrace
fr, keys, sat, ram = pcetrace.load(sys.argv[1]); T0 = int(sys.argv[2]); first, last = int(sys.argv[3]), int(sys.argv[4])
R = np.array(ram[first - T0:last - T0]).astype(int)
def sg(v): return v - 65536 if v >= 32768 else v
out = []
for k in range(90, 96):
    ty = R[:, 0x2F1C + k - 0x2000]; x = R[:, 0x2B47 + k - 0x2000] + 256 * R[:, 0x2ADA + k - 0x2000]
    y = np.array([sg(int(a) + 256 * int(b)) for a, b in zip(R[:, 0x2C8E + k - 0x2000], R[:, 0x2C21 + k - 0x2000])])
    t = 0
    while t < len(ty):
        if ty[t] == 1:
            s = t
            while t < len(ty) and ty[t] == 1: t += 1
            n = t - s
            if n > 5: out.append([first + s, int(x[s]), int(y[s]), round(float((y[min(s + 100, t - 1)] - y[s]) / max(1, min(100, t - 1 - s))), 3), n])
        else: t += 1
out.sort(); json.dump(out, open(sys.argv[5], 'w')); print(len(out), out[:5])
