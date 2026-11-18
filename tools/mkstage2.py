#!/usr/bin/env python3
"""Stage 2 : génère md/twinbee/src/stage2_data.h (défilement, palettes glissantes, nuages) ; le fond est res/stage2.png"""
import sys, json, numpy as np
sys.path.insert(0, 'tools'); import pcetrace
SRC = 'md/twinbee/src/'; START = 25541
fr, keys, sat, ram = pcetrace.load('dumps/s2i/s2t.trace')
R = np.array(ram).astype(int); sc = R[:, 0x20B4 - 0x2000] * 256 + R[:, 0x20B5 - 0x2000]
i0 = START - int(fr[0]); i1 = 37667 - int(fr[0])
cum = sc[i0:i1] - sc[i0]; cum = np.maximum.accumulate(cum); d = np.diff(cum); assert d.max() <= 15 and d.min() >= 0, (d.max(), d.min())
if len(d) % 2: d = np.append(d, 0)
packed = [int(d[i]) | (int(d[i + 1]) << 4) for i in range(0, len(d), 2)]
ev = [l.split() for l in open('extract/stage2_md_events.txt')]
backdrop = ev[0][1]; ev = [(int(a) + 2, int(b), c) for a, b, c in ev[1:]]       # +2 lignes de tiles : 16 px ajoutés en haut de l'image
clouds = json.load(open('extract/clouds_stage2.json'))
with open(SRC + 'stage2_data.h', 'w') as f:
    f.write('// Généré par tools/mkstage2.py : stage 2 (fond res/stage2.png, défilement, palettes glissantes, nuages)\n#ifndef STAGE2_DATA_H\n#define STAGE2_DATA_H\n')
    f.write('#define STAGE2_BACKDROP 0x%s\n#define STAGE2_MAP_H 4304\n#define STAGE2_NUM_PAL_EVENTS %d\n' % (backdrop, len(ev)))
    f.write('static const PalEvent stage2_pal_events[STAGE2_NUM_PAL_EVENTS] = {\n')
    for r, i, c in ev: f.write('    {%d, %d, 0x%s},\n' % (r, i, c))
    f.write('};\n')
    f.write('#define STAGE2_NUM_CLOUDS %d\nstatic const CloudSpawn stage2_clouds[STAGE2_NUM_CLOUDS] = {\n' % len(clouds))
    for fr_, x, y, sp, n in clouds:
        f.write('    {%d, %d, %d, 0x%02X},\n' % (fr_ - START, x - 16, y - 16, round(sp * 256)))
    f.write('};\n#define STAGE2_SCROLL_FRAMES %d\nstatic const u8 stage2_scroll[%d] = {\n' % (len(d), len(packed)))
    for i in range(0, len(packed), 24): f.write('    ' + ','.join(map(str, packed[i:i + 24])) + ',\n')
    f.write('};\n#endif\n')
print('stage 2 :', len(d), 'frames de défilement,', int(cum[-1]), 'px,', len(ev), 'événements de palette,', len(clouds), 'nuages')
