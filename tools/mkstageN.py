#!/usr/bin/env python3
"""Stage N : génère md/twinbee/src/stageN_data.h (défilement, palettes glissantes, nuages) ; le fond est res/stageN.png
usage: mkstageN.py N trace frame0_trace start end map_h"""
import sys, json, numpy as np
sys.path.insert(0, 'tools'); import pcetrace
SRC = 'md/twinbee/src/'; N = int(sys.argv[1]); TR, TF, START, END, MAPH = sys.argv[2], int(sys.argv[3]), int(sys.argv[4]), int(sys.argv[5]), int(sys.argv[6])
fr, keys, sat, ram = pcetrace.load(TR)
R = np.array(ram).astype(int); sc = R[:, 0x20B4 - 0x2000] * 256 + R[:, 0x20B5 - 0x2000]
i0 = START - TF; i1 = END - TF
cum = sc[i0:i1] - sc[i0]; cum = np.maximum.accumulate(cum); d = np.diff(cum); assert d.max() <= 15 and d.min() >= 0, (d.max(), d.min())
if len(d) % 2: d = np.append(d, 0)
packed = [int(d[i]) | (int(d[i + 1]) << 4) for i in range(0, len(d), 2)]
ev = [l.split() for l in open('extract/stage%d_md_events.txt' % N)]
backdrop = ev[0][1]; ev = [(int(a) + 2, int(b), c) for a, b, c in ev[1:]]       # +2 lignes de tiles : 16 px ajoutés en haut de l'image
clouds = json.load(open('extract/clouds_stage%d.json' % N))
if N == 2: clouds = [c for c in clouds if c[0] < 37400]       # fenêtre du boss : objets de type 1 qui ne sont pas des nuages (fumées, boulets)
P = 'stage%d' % N; U = 'STAGE%d' % N
with open(SRC + P + '_data.h', 'w') as f:
    f.write('// Généré par tools/mkstageN.py : %s (fond res/%s.png, défilement, palettes glissantes, nuages)\n#ifndef %s_DATA_H\n#define %s_DATA_H\n' % (P, P, U, U))
    f.write('#define %s_BACKDROP 0x%s\n#define %s_MAP_H %d\n#define %s_NUM_PAL_EVENTS %d\n' % (U, backdrop, U, MAPH, U, len(ev)))
    f.write('static const PalEvent %s_pal_events[%s_NUM_PAL_EVENTS] = {\n' % (P, U))
    for r, i, c in ev: f.write('    {%d, %d, 0x%s},\n' % (r, i, c))
    f.write('};\n#define %s_NUM_CLOUDS %d\nstatic const CloudSpawn %s_clouds[%s_NUM_CLOUDS] = {\n' % (U, len(clouds), P, U))
    for fr_, x, y, sp, n in clouds: f.write('    {%d, %d, %d, 0x%02X},\n' % (fr_ - START, x - 16, y - 16, round(sp * 256)))
    f.write('};\n#define %s_SCROLL_FRAMES %d\nstatic const u8 %s_scroll[%d] = {\n' % (U, len(d), P, len(packed)))
    for i in range(0, len(packed), 24): f.write('    ' + ','.join(map(str, packed[i:i + 24])) + ',\n')
    f.write('};\n#endif\n')
print(P, ':', len(d), 'frames de défilement,', int(cum[-1]), 'px,', len(ev), 'événements de palette,', len(clouds), 'nuages')
