#!/usr/bin/env python3
"""Compresse en place les flux séquentiels (bossN_flux, ends_X_flux) des en-têtes générés : blocs de 2048 octets, format LZ4,
chaque bloc précédé de sa longueur compressée (u16 BE), 0 = fin. Lu par src/lzs.c. Idempotent (marqueur /*LZS*/)."""
import re, sys
BLK = 2048
def lz4_block(d):
    out = bytearray(); n = len(d); i = 0; anchor = 0; ht = {}
    def emit(lit_end, mlen, off):
        ll = lit_end - anchor; tok = (min(ll, 15) << 4) | (min(mlen - 4, 15) if mlen else 0); out.append(tok)
        if ll >= 15:
            r = ll - 15
            while r >= 255: out.append(255); r -= 255
            out.append(r)
        out.extend(d[anchor:lit_end])
        if mlen:
            out.extend((off & 255, off >> 8))
            if mlen - 4 >= 15:
                r = mlen - 4 - 15
                while r >= 255: out.append(255); r -= 255
                out.append(r)
    while i + 4 <= n - 5:
        key = bytes(d[i:i + 4]); j = ht.get(key); ht[key] = i
        if j is not None and i - j < 65536:
            m = 4
            while i + m < n - 5 and d[j + m] == d[i + m]: m += 1
            emit(i, m, i - j); i += m; anchor = i
        else: i += 1
    emit(n, 0, 0)
    return bytes(out)
def pack(raw):
    out = bytearray()
    for p in range(0, len(raw), BLK):
        c = lz4_block(raw[p:p + BLK]); out += len(c).to_bytes(2, 'big') + c
    return bytes(out) + b'\0\0'
def main(files):
    for fn in files:
        s = open(fn).read()
        def rep(m):
            raw = bytes(int(x) for x in m.group(3).split(','))
            z = pack(raw)
            print(fn, m.group(2), len(raw), '->', len(z))
            return '/*LZS*/static const u8 %s[%d] = {%s};' % (m.group(2), len(z), ','.join(map(str, z)))
        s2 = re.sub(r'(?<!/\*LZS\*/)(static const u8 ((?:boss\d_flux|ends_\w_flux))\[\d+\] = \{([0-9,]*)\};)', rep, s)
        if s2 != s: open(fn, 'w').write(s2)
if __name__ == '__main__': main(sys.argv[1:])
