#!/usr/bin/env python3
"""Rejoue sur la ROM Mega Drive les entrées d'une trace PC Engine (pcedump .trace) et compare frame par frame :
position du joueur, compteur de charge, tirs. usage: mdtest_player.py <trace_pce> <rom.bin> <rom.out> <nom>"""
import sys, subprocess, os, numpy as np
trace, rom, elf, name = sys.argv[1:5]
NM = '/home/claude/work/emu/gendev/root/opt/gendev/bin/m68k-elf-nm'; CORE = 'emu/Genesis-Plus-GX/genesis_plus_gx_libretro.so'
REC = 4 + 512 + 8192
d = np.frombuffer(open(trace, 'rb').read(), np.uint8).reshape(-1, REC)
keys = d[:, 2:4].copy().view('<u2')[:, 0].astype(int); sat = d[:, 4:516].copy().view('<u2').reshape(-1, 64, 4).astype(int); ram = d[:, 516:].astype(int)
N = len(keys); F0 = 300
INV = 0 if os.environ.get('MORTEL') else 2   # bit 1 = bouton A tenu : invincible (les traces PCE le sont aussi)
conv = lambda k: INV | (1 if k & 2 else 0) | (0x10 if k & 0x10 else 0) | (0x20 if k & 0x40 else 0) | (0x40 if k & 0x80 else 0) | (0x80 if k & 0x20 else 0)
os.makedirs('md/shots', exist_ok=True); sc = 'md/shots/%s.script' % name
with open(sc, 'w') as f:
    f.write('%d keys %X\n%d ramtrace %s\n' % (F0 - 12, INV, F0 - 10, name)); prev = None
    for i in range(N):
        k = conv(keys[i])
        if k != prev: f.write('%d keys %X\n' % (F0 + i, k)); prev = k
    for i in range(0, N, max(1, N // 12)): f.write('%d shot %s_%04d\n' % (F0 + i, name, i))
    f.write('%d keys 0\n%d end\n' % (F0 + N, F0 + N + 20))
subprocess.run(['tools/mdshot/mdshot', CORE, rom, sc, 'md/shots'], check=True)
sym = {l.split()[2]: int(l.split()[0], 16) & 0xFFFF for l in subprocess.run([NM, elf], capture_output=True, text=True).stdout.splitlines() if len(l.split()) == 3}
r = np.frombuffer(open('md/shots/%s.ramtrace' % name, 'rb').read(), np.uint8).reshape(-1, 0x10000)
def w16(addr, swap):   # mots 16 bits big-endian ; Genesis Plus GX stocke la RAM avec les octets échangés par paires
    a = r[:, addr ^ 1].astype(int) if swap else r[:, addr].astype(int); b = r[:, (addr + 1) ^ 1].astype(int) if swap else r[:, addr + 1].astype(int)
    v = (a << 8) | b; return np.where(v >= 0x8000, v - 0x10000, v)
gf = sym['gameFrame']; swap = not (np.diff(w16(gf, False)[-50:]) == 1).all()
assert (np.diff(w16(gf, swap)[-50:]) == 1).all(), 'gameFrame introuvable'
P = sym['player']; fld = ['x', 'y', 'shotActive', 'shotX', 'shotY', 'charge', 'chargedLevel', 'chargedX', 'chargedY']
md = {n: w16(P + 2 * i, swap)[10:] for i, n in enumerate(fld)}    # index 0 = frame F0 (début des entrées)
os.remove('md/shots/%s.ramtrace' % name)
# --- position : PCE RAM $BB/$BD
px, py = ram[:, 0xBB], ram[:, 0xBD]; best = None
for lag in range(-3, 6):
    a = slice(max(0, -lag), N - 6)
    e = int(((md['x'][a.start + lag:a.stop + lag] != px[a]) | (md['y'][a.start + lag:a.stop + lag] != py[a])).sum())
    if best is None or e < best[0]: best = (e, lag)
print('[%s] position joueur : %d frames comparées, %d différentes (décalage constant %+d frame)' % (name, N - 6, best[0], best[1])); lag = best[1]
# --- compteur de charge : PCE RAM $A6
a = slice(4, N - 6); e = int((md['charge'][a.start + lag:a.stop + lag] != ram[a, 0xA6]).sum()); el = None
for l2 in range(-3, 6):
    e2 = int((md['charge'][a.start + l2:a.stop + l2] != ram[a, 0xA6]).sum())
    if el is None or e2 < el[0]: el = (e2, l2)
print('[%s] compteur de charge : %d frames différentes (meilleur décalage %+d)' % (name, el[0], el[1]))
# --- tirs : sprites PCE (1E2 normal ; 1E8 niveau 1 ; 1F9 niveau 2), coordonnées écran
def pce_spr(t, pat, hf=None):
    for i in range(64):
        y, x, p, at = sat[t, i]
        if (p or at) and ((p >> 1) & 0x3FF) == pat and (hf is None or bool(at & 0x800) == hf): return (int((x & 0x3FF) - 32), int((y & 0x3FF) - 64))
    return None
for label, pat, hf, act, fx, fy, dx in (('tir normal', 0x1E2, None, lambda t: md['shotActive'][t] != 0, 'shotX', 'shotY', 0),
                                         ('tir chargé niv.1', 0x1E8, False, lambda t: md['chargedLevel'][t] == 1, 'chargedX', 'chargedY', -16),
                                         ('tir chargé niv.2', 0x1F9, None, lambda t: md['chargedLevel'][t] == 2 and md['chargedY'][t] >= -62, 'chargedX', 'chargedY', -8)):
    res = None
    for l2 in range(-3, 6):
        both = same = only_p = only_m = 0
        for t in range(4, N - 8):
            p = pce_spr(t, pat, hf); m = (int(md[fx][t + l2]) + dx, int(md[fy][t + l2])) if act(t + l2) else None
            if p and m: both += 1; same += (p == m)
            elif p: only_p += 1
            elif m: only_m += 1
        sc_ = (both - same) * 3 + only_p + only_m
        if res is None or sc_ < res[0]: res = (sc_, l2, both, same, only_p, only_m)
    print('[%s] %s : présent des deux côtés %d frames dont %d à la même position ; PCE seul %d, MD seul %d (décalage %+d)' % ((name, label) + res[2:] + (res[1],)))
if os.environ.get('DBG'):
    for t in list(range(0, 12)) + list(range(56, 70)) + list(range(int(os.environ['DBG']), int(os.environ['DBG']) + 30)):
        print(t, 'k=%02X' % keys[t], 'PCE', px[t], py[t], ram[t, 0xA6], pce_spr(t, 0x1E2), pce_spr(t, 0x1E8, False), '| MD', {n: int(md[n][t]) for n in fld})
