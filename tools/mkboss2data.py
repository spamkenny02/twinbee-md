#!/usr/bin/env python3
"""Génère src/boss2_data.h (tilemap initial, diffs par keyframe, scroll par frame, palette) pour le boss du stage 2."""
import sys, pickle, numpy as np
sys.path.insert(0, 'tools'); import pcetrace
F0, F1, T0, S0 = 37400, 47760, 25000, 25541
E, N, bgc = pickle.load(open('extract/boss2_E.pkl', 'rb'))
line = np.array(open('extract/boss2_md_pal.txt').read().split(), int)
keys = list(range(37400, 37600, 40)) + list(range(37600, F1 + 1, 8))
M = [(e & 0xFFF) | (line[e] << 12) for e in E]
fr, kk, sat, ram = pcetrace.load('dumps/s2t/s2t.trace'); R = np.array(ram).astype(int)
def lo(f):
    r = R[f - T0]; b = r[0x3DB6 - 0x2000]; yb = r[0x3DBA - 0x2000]; yb = yb - 256 if yb > 127 else yb
    return (b - 8) & 255, (yb - 3) & 255
# scroll : octet bas depuis la RAM, bit 8 par continuité (départ : X=0, Y<256)
X = []; Y = []; px = 0; py = None
for f in range(F0, F1):
    xl, yl = lo(f)
    if py is None: py = yl; X.append(xl); Y.append(yl); px = xl; continue
    dx = ((xl - (px & 255) + 128) & 255) - 128; dy = ((yl - (py & 255) + 128) & 255) - 128
    px += dx; py += dy; X.append(px & 511); Y.append(py & 511)
# vérification par rapport aux ancres (recherche d'image)
try:
    path = pickle.load(open('/tmp/path.pkl', 'rb')); bad = 0; n = 0
    for f, (sc, x, y) in path.items():
        if sc >= 0.7 and F0 <= f < F1:
            n += 1
            if (X[f - F0] - x) % 512 > 3 and (x - X[f - F0]) % 512 > 3 or (Y[f - F0] - y) % 512 > 3 and (y - Y[f - F0]) % 512 > 3: bad += 1; print('écart', f, X[f - F0], x, Y[f - F0], y)
    print('ancres', n, 'écarts', bad)
except Exception as ex: print(ex)
dI = []; dV = []; dS = [0]; kf = []
for k in range(1, len(keys)):
    d = np.where(M[k] != M[k - 1])[0]; dI += d.tolist(); dV += M[k][d].tolist(); dS.append(len(dI)); kf.append(keys[k] - F0)
print('diffs', len(dI), 'keyframes', len(kf))
def arr(name, t, a, per=16):
    s = 'static const %s %s[%d] = {\n' % (t, name, len(a))
    for i in range(0, len(a), per): s += '    ' + ','.join(str(int(x)) for x in a[i:i + per]) + ',\n'
    return s + '};\n'
ev = [l.split() for l in open('extract/boss2_md_events.txt')][1:]
with open('md/twinbee/src/boss2_data.h', 'w') as f:
    f.write('// Généré par tools/mkboss2data.py : boss du stage 2 (galion), plan B rejoué depuis la PCE\n#ifndef BOSS2_DATA_H\n#define BOSS2_DATA_H\n')
    f.write('#define BOSS2_START %d\n#define BOSS2_FRAMES %d\n#define BOSS2_NKEYS %d\n#define BOSS2_NCOL %d\n' % (F0 - S0, F1 - F0, len(kf), len(ev)))
    f.write('#define BOSS2_BACKDROP 0x%s\n' % open('extract/boss2_md_events.txt').readline().split()[1])
    f.write('static const u16 boss2_colors[%d][2] = {%s};\n' % (len(ev), ','.join('{%d,0x%s}' % (int(a), b) for a, b in ev)))
    f.write(arr('boss2_bat0', 'u16', M[0]))
    f.write(arr('boss2_keyFrame', 'u16', kf)); f.write(arr('boss2_dStart', 'u32', dS)); f.write(arr('boss2_dIdx', 'u16', dI)); f.write(arr('boss2_dVal', 'u16', dV))
    f.write(arr('boss2_scrollX', 'u16', X)); f.write(arr('boss2_scrollY', 'u16', Y)); f.write('#endif\n')
