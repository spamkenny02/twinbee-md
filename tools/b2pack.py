#!/usr/bin/env python3
"""Compresse en place les tableaux du boss 2 (keyFrame/dStart/dIdx/dVal/scrollX/scrollY) de src/boss2_data.h en un seul flux séquentiel
(par frame : scrollX, scrollY, nombre de keyframes consommées, puis pour chacune n et n paires idx,val ; mots u16 big-endian),
LZ4 par blocs de 256 octets (u16 BE de longueur compressée, 0 = fin). Lu par src/boss2.c. Idempotent."""
import re, sys
sys.path.insert(0, 'tools'); from lzspack import lz4_block
fn = 'md/twinbee/src/boss2_data.h'; s = open(fn).read()
if 'boss2_scrollX' not in s: sys.exit(0)
def arr(name):
    m = re.search(r'static const u(?:16|32) %s\[\d+\] = \{([^}]*)\};\n' % name, s, re.S)
    return m, [int(x) for x in m.group(1).replace('\n', '').split(',') if x.strip()]
mk, kf = arr('boss2_keyFrame'); md, ds = arr('boss2_dStart'); mi, di = arr('boss2_dIdx'); mv, dv = arr('boss2_dVal'); mx, sx = arr('boss2_scrollX'); my, sy = arr('boss2_scrollY')
w = []; kp = 0
for t in range(len(sx)):
    w += [sx[t], sy[t]]; keys = []
    while kp < len(kf) and kf[kp] <= t: keys.append(kp); kp += 1
    w.append(len(keys))
    for k in keys:
        a, b = ds[k], ds[k + 1]; w.append(b - a)
        for j in range(a, b): w += [di[j], dv[j]]
raw = b''.join(v.to_bytes(2, 'big') for v in w); out = bytearray()
for p in range(0, len(raw), 256):
    c = lz4_block(raw[p:p + 256]); out += len(c).to_bytes(2, 'big') + c
out += b'\0\0'; print('boss2', len(raw), '->', len(out))
for m in (mk, md, mi, mv, mx, my): s = s.replace(m.group(0), '')
s = s.replace('#endif', '/*B2Z*/static const u8 boss2_stream[%d] = {%s};\n#endif' % (len(out), ','.join(map(str, out))))
open(fn, 'w').write(s)
