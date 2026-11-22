#!/usr/bin/env python3
"""Compresse en place les tableaux des ennemis rejoués (eN_frames/pi/rf/rl) de src/stageN_enemies.h : blocs de 256 o LZ4 indépendants,
accès aléatoire par src/ra.c. Les E2Frame sont écrits sur 64 octets (4 par bloc). Idempotent."""
import re, sys
sys.path.insert(0, 'tools'); from lzspack import lz4_block
BLK = 64
IDS = {'frames': 1, 'pi': 2, 'run': 3}
def emit(name, raw, ctype_comment):
    aid = int(name[1]) * 8 + IDS[name.split('_')[1]]
    nb = (len(raw) + BLK - 1) // BLK; z = bytearray(); offs = []
    for b in range(nb):
        offs.append(len(z)); z += lz4_block(raw[b * BLK:(b + 1) * BLK])
    offs.append(len(z)); print(name, len(raw), '->', len(z) + 4 * len(offs))
    return ('static const u8 %s_z[%d] = {%s};\nstatic const u32 %s_o[%d] = {%s};\nstatic const RAArr %s_ra = {%s_z, %s_o, %d, %d};\n'
            % (name, len(z), ','.join(map(str, z)), name, len(offs), ','.join(map(str, offs)), name, name, name, len(raw), aid))
def main(fn):
    s = open(fn).read()
    def rep_arr(m):
        name, kind, body = m.group(2), m.group(1), m.group(3)
        vals = [int(x) for x in body.replace('\n', '').split(',') if x.strip()]
        raw = bytearray()
        for v in vals: raw += (v & 255).to_bytes(1, 'big') if kind == 'u8' else (v & 0xFFFF).to_bytes(2, 'big')
        return emit(name, bytes(raw), kind)
    s = re.sub(r'static const u8 (e\d_pi)\[\d+\] = \{([0-9,\-]*)\};\n', lambda m: emit(m.group(1), bytes(int(x) & 255 for x in m.group(2).split(',') if x.strip()), 'u8'), s)
    mrf = re.search(r'static const u16 (e\d)_rf\[\d+\] = \{([0-9,\-]*)\};\n', s); mrl = re.search(r'static const u8 e\d_rl\[\d+\] = \{([0-9,\-]*)\};\n', s)
    if mrf and mrl:
        rf = [int(x) for x in mrf.group(2).split(',') if x.strip()]; rl = [int(x) for x in mrl.group(1).split(',') if x.strip()]
        raw = bytearray()
        pairs = list(zip(rf, rl))
        for g in range(0, len(pairs), 16):
            grp = pairs[g:g + 16]; grp += [(0, 0)] * (16 - len(grp))
            raw += bytes((a >> 8) & 255 for a, b in grp) + bytes(a & 255 for a, b in grp) + bytes(b & 255 for a, b in grp) + bytes(16)
        s = s.replace(mrl.group(0), '').replace(mrf.group(0), emit(mrf.group(1) + '_run', bytes(raw), 'run'))
    def rep_fr(m):
        name = m.group(1); raw = bytearray()
        for fm in re.finditer(r'\{(\d+), \{((?:\{[^{}]*\},? ?)*)\}\},', m.group(2)):
            n = int(fm.group(1)); ps = [[int(x) for x in p.split(',')] for p in re.findall(r'\{([^{}]*)\}', fm.group(2))]
            assert n == len(ps) and n <= 12
            rec = bytearray([n])
            for p in ps: rec += bytes(v & 255 for v in p)
            rec += bytes(64 - len(rec)); raw += rec
        return emit(name, bytes(raw), 'fr')
    s = re.sub(r'static const E2Frame (e\d_frames)\[\d+\] = \{\n(.*?)\n\};\n', rep_fr, s, flags=re.S)
    s = re.sub(r'(static const E2Data e2data_\d = \{)(e\d_frames), (e\d_tpl), (e\d_pdx), (e\d_pdy), (e\d_pi), (e\d)_rf, (e\d)_rl,',
               lambda m: '%s&%s_ra, %s, %s, %s, &%s_ra, &%s_run_ra,' % (m.group(1), m.group(2), m.group(3), m.group(4), m.group(5), m.group(6), m.group(7)), s)
    open(fn, 'w').write(s)
if __name__ == '__main__':
    for f in sys.argv[1:]: main(f)
