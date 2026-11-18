#!/usr/bin/env python3
"""Tirs ennemis génériques (objets 48..65, type 1) d'une trace : usage ext_ebul_n.py trace frame0 start end out.pkl -> [(frame, x, y)]"""
import sys, pickle, numpy as np
sys.path.insert(0, 'tools'); import pcetrace
TR, TF, S, E, OUT = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]), sys.argv[5]
fr, keys, sat, ram = pcetrace.load(TR); R = np.array(ram[S - TF:E - TF]).astype(int)
A = lambda b, k: R[:, b + k - 0x2000]; out = []
for k in range(48, 66):
    ty = A(0x2F1C, k)
    for t in np.where((ty[1:] != 0) & (ty[:-1] == 0))[0] + 1:
        out.append((S + t, int(A(0x2B47, k)[t]) + 256 * int(A(0x2ADA, k)[t]), int(A(0x2C8E, k)[t]) + 256 * int(A(0x2C21, k)[t])))
out.sort(); pickle.dump(out, open(OUT, 'wb')); print(len(out), out[:4])
