#!/usr/bin/env python3
"""Stage 2 : extrait les instances d'ennemis (objets 66..83 et 96..107, types >= 16) de la trace sans tir (dumps/s2i) :
trajectoire par frame + pièces de sprite -> extract/s2_inst.pkl"""
import sys, collections, pickle, numpy as np
sys.path.insert(0, 'tools'); import pcetrace
fr, keys, sat, ram = pcetrace.load('dumps/s2i/s2t.trace')
R = np.array(ram).astype(int)
A = lambda b, k: R[:, b + k - 0x2000]
T0 = 25541 - 25000; T1 = min(len(fr), 38000 - 25000)
slots = list(range(66, 84)) + list(range(96, 108))
def sg(v): return v - 65536 if v >= 32768 else v
X = {k: np.array([sg(int(a) + 256 * int(b)) for a, b in zip(A(0x2B47, k), A(0x2ADA, k))]) for k in slots}
Y = {k: np.array([sg(int(a) + 256 * int(b)) for a, b in zip(A(0x2C8E, k), A(0x2C21, k))]) for k in slots}
TY = {k: A(0x2F1C, k) for k in slots}; ST = {k: A(0x2F89, k) for k in slots}
HW = {k: A(0x335E, k) for k in slots}; HH = {k: A(0x33CB, k) for k in slots}; AN = {k: A(0x2A6D, k) for k in slots}
inst = []; cur = {}
for t in range(T0, T1):
    objs = []
    for k in slots:
        ty = int(TY[k][t])
        if ty == 0:
            if k in cur: cur[k]['t1'] = t; inst.append(cur.pop(k))
            continue
        if k in cur and cur[k]['ty'] != ty: cur[k]['t1'] = t; inst.append(cur.pop(k))
        if k not in cur: cur[k] = dict(slot=k, ty=ty, t0=t, pts=[], hw=int(HW[k][t]), hh=int(HH[k][t]), an=[], pieces=[])
        o = cur[k]; o['pts'].append((int(X[k][t]), int(Y[k][t]))); o['an'].append(int(AN[k][t])); o['pieces'].append([])
        objs.append((k, int(X[k][t]), int(Y[k][t])))
    for s in pcetrace.sprites(sat[t]):
        sx, sy, pat, pal, hf, w, h, i = s
        cx, cy = sx + w / 2, sy + h / 2; best = None
        for (k, x, y) in objs:
            d = abs(cx - x) + abs(cy - y)
            if d < 28 + max(w, h) / 2 and (best is None or d < best[0]): best = (d, k, x, y)
        if best: cur[best[1]]['pieces'][-1].append((pat, w, h, hf, pal, sx - best[2], sy - best[3]))
for k in list(cur): cur[k]['t1'] = T1; inst.append(cur.pop(k))
for o in inst: o['t0'] += 25000; o['t1'] += 25000
print(len(inst), collections.Counter(o['ty'] for o in inst))
pickle.dump(inst, open('extract/s2_inst.pkl', 'wb'))
