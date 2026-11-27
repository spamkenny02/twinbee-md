#!/usr/bin/env python3
"""Genere md/twinbee/src/end_data_z.h : les tableaux du fond de la fin
(tuiles, cartes, palettes) compresses en LZS (blocs de 2048 o, voir tools/lzspack.py)
plus les constantes et la chronologie des cartes (mapf) laissee brute.
Lu par src/end.c via un second contexte LZS (LZSB)."""
import re, sys
sys.path.insert(0, 'tools')
from lzspack import pack

SRC = 'md/twinbee/src/end_data.h'
DST = 'md/twinbee/src/end_data_z.h'

s = open(SRC, encoding='utf-8', errors='replace').read()
defines = re.findall(r'#define END_\w+\s+\d+', s)
arrays = {}
for m in re.finditer(r'static const (u16|u32|s32) (\w+)\[(\d+)\] = \{([^}]*)\};', s, re.S):
    t, name, n, body = m.group(1), m.group(2), int(m.group(3)), m.group(4)
    vals = [int(x, 0) for x in body.replace('\n', '').split(',') if x.strip()]
    assert len(vals) == n, (name, len(vals), n)
    arrays[name] = (t, vals)

PACK = [n for n in arrays if n.endswith('tiles') or n.endswith('_pal') or ('_map' in n and not n.endswith('mapf'))]
out = ['// Genere par tools/lzend.py depuis end_data.h (ne pas editer)\n',
       '#ifndef END_DATA_Z_H\n#define END_DATA_Z_H\n#include <genesis.h>\n']
out += [d + '\n' for d in defines]
tot_raw = tot_z = 0
for name, (t, vals) in arrays.items():
    if name not in PACK:
        out.append('static const %s %s[%d] = {%s};\n' % (t, name, len(vals), ','.join(str(v) for v in vals)))
        continue
    sz = 4 if t == 'u32' else 2
    raw = b''.join(v.to_bytes(sz, 'big') for v in vals)
    z = pack(raw)
    tot_raw += len(raw); tot_z += len(z)
    print('%-14s %7d -> %6d (%3d%%)' % (name, len(raw), len(z), 100 * len(z) // len(raw)))
    out.append('/*LZS*/static const u8 %s[%d] = {%s};\n' % (name, len(z), ','.join(str(b) for b in z)))
out.append('#endif\n')
open(DST, 'w', encoding='utf-8', newline='\n').write(''.join(out))
print('TOTAL %d -> %d  economie %.0f Ko' % (tot_raw, tot_z, (tot_raw - tot_z) / 1024))
