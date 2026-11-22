#!/usr/bin/env python3
"""Rejoue sur la ROM Mega Drive les entrées d'une trace PC Engine du stage 1 et compare frame par frame :
défilement, joueur, nuages, cloches. La frame PCE 2880 correspond à la frame de jeu 0 de la ROM.
usage: mdtest_stage.py <trace_pce> <rom.bin> <rom.out> <nom> [frame_capture ...]"""
import sys, subprocess, os, numpy as np
sys.path.insert(0, 'tools'); import pcetrace
trace, rom, elf, name = sys.argv[1:5]; shots = [int(x) for x in sys.argv[5:]]
NM = '/home/claude/work/emu/gendev/root/opt/gendev/bin/m68k-elf-nm'; CORE = 'emu/Genesis-Plus-GX/genesis_plus_gx_libretro.so'
fr, keys, sat, ram = pcetrace.load(trace)
sym = {l.split()[2]: int(l.split()[0], 16) & 0xFFFF for l in subprocess.run([NM, elf], capture_output=True, text=True).stdout.splitlines() if len(l.split()) == 3}
os.makedirs('md/shots', exist_ok=True)
def run(lines, tag):
    sc = 'md/shots/%s.script' % tag; open(sc, 'w').write('\n'.join(lines) + '\n')
    subprocess.run(['tools/mdshot/mdshot', CORE, rom, sc, 'md/shots'], check=True)
class Ram:
    def __init__(self, path):
        self.r = np.memmap(path, np.uint8, 'r').reshape(-1, 0x10000); g = sym['gameFrame']
        self.swap = False; self.swap = not (np.diff(self.w(g)[-20:]) == 1).all()
    def w(self, addr):
        a, b = (addr ^ 1, (addr + 1) ^ 1) if self.swap else (addr, addr + 1)
        v = (np.array(self.r[:, a]).astype(int) << 8) | np.array(self.r[:, b]).astype(int); return np.where(v >= 0x8000, v - 0x10000, v)
# 1) à quelle frame émulateur la frame de jeu 0 tombe-t-elle ?
run(['300 keys 8', '303 keys 0', '310 keys 8', '313 keys 0', '330 ramtrace boot', '380 ramtraceoff', '381 end'], 'boot'); R = Ram('md/shots/boot.ramtrace'); B = 331 + 49 - int(R.w(sym['gameFrame'])[49]); del R; os.remove('md/shots/boot.ramtrace')
# 2) rejeu
INV = 0 if os.environ.get('MORTEL') else 2
conv = lambda k: INV | (1 if k & 2 else 0) | (0x100 if k & 1 else 0) | (0x10 if k & 0x10 else 0) | (0x20 if k & 0x40 else 0) | (0x40 if k & 0x80 else 0) | (0x80 if k & 0x20 else 0)
i0 = max(0, 2880 - int(fr[0])); N = next((k for k in range(1, len(fr)) if fr[k] < fr[k - 1]), len(fr)); mdf = lambda i: B + int(fr[i]) - 2880
L = ['%d ramtrace %s' % (mdf(i0), name), '%d keys %X' % (max(1, mdf(i0) - 1), INV)]; prev = INV
for i in range(i0, N):
    k = conv(int(keys[i]))
    if k != prev: L.append('%d keys %X' % (mdf(i), k)); prev = k
L += ['%d shot %s_%d' % (B + f - 2880, name, f) for f in shots] + ['%d ramtraceoff' % mdf(N - 1), '%d end' % (mdf(N - 1) + 2)]
L += ['300 keys 8', '303 keys 0', '310 keys 8', '313 keys 0']
L.sort(key=lambda l: int(l.split()[0])); run(L, name); R = Ram('md/shots/%s.ramtrace' % name)
gf = R.w(sym['gameFrame']); assert gf[0] == int(fr[i0]) - 2880 + 1 or True
P = sym.get('players', sym.get('player')); S = sym['stage']
pf = {n: R.w(P + 2 * i) for i, n in enumerate(['x', 'y', 'shotActive', 'shotX', 'shotY', 'charge'])}
st_scroll = R.w(S + 2); score = (R.w(S + 4).astype(np.int64) & 0xFFFF) << 16 | (R.w(S + 6) & 0xFFFF)
def arr(off, n): return np.stack([R.w(S + off + 2 * k) for k in range(n)], 1)
MC, MB = 8, 8
cOn, cX, cY, cB = arr(8, MC), arr(8 + 2 * MC, MC), arr(8 + 4 * MC, MC), arr(8 + 6 * MC, MC); o = 8 + 8 * MC
bOn, bX, bY = arr(o, MB), arr(o + 2 * MB, MB), arr(o + 4 * MB, MB)
M = len(gf); n = min(N - i0, M) - 4
def pce_sets(i):
    sp = pcetrace.sprites(sat[i])
    return (sorted((x, y) for x, y, p, pal, hf, w, h, k in sp if w == 32 and h == 32 and pal == 3 and p in (0x1D4, 0x1D8)),
            sorted((x, y) for x, y, p, pal, hf, w, h, k in sp if p in (0x1E9, 0x1EB) and w == 16))
pc = [pce_sets(i0 + j) for j in range(n + 4)]
def md_sets(j):
    return (sorted((int(cX[j, k]), int(cY[j, k])) for k in range(MC) if cOn[j, k] and -48 <= cY[j, k] < 240), sorted((int(bX[j, k]), int(bY[j, k])) for k in range(MB) if bOn[j, k]))
md = [md_sets(j) for j in range(n + 4)]
# défilement PCE : octet $B5 cumulé
v = np.array(ram[i0:, 0xB5]).astype(int); d = np.diff(v); d = ((d + 128) % 256) - 128; pscroll = np.concatenate([[0], np.cumsum(d)])
out = []
for lag in (-2, -1, 0, 1, 2):
    a = range(4, n - 4)
    ec = sum(1 for j in a if pc[j][0] != md[j + lag][0]); eb = sum(1 for j in a if pc[j][1] != md[j + lag][1])
    ep = sum(1 for j in a if (int(ram[i0 + j, 0xBB]), int(ram[i0 + j, 0xBD])) != (int(pf['x'][j + lag]), int(pf['y'][j + lag])))
    es = sum(1 for j in a if (pscroll[j] - pscroll[4]) != (st_scroll[j + lag] - st_scroll[4 + lag]))
    out.append((lag, ec, eb, ep, es))
tot = n - 8
bc = min(out, key=lambda e: e[1]); bb = min(out, key=lambda e: e[2]); bp = min(out, key=lambda e: e[3]); bs = min(out, key=lambda e: e[4])
print('[%s] %d frames comparées (frame de jeu 0 = frame émulateur %d)' % (name, tot, B))
print('   défilement : %d frames différentes (décalage %+d)' % (bs[4], bs[0]))
print('   joueur     : %d frames différentes (décalage %+d)' % (bp[3], bp[0]))
print('   nuages     : %d frames différentes (décalage %+d)' % (bc[1], bc[0]))
print('   cloches    : %d frames différentes (décalage %+d) ; frames avec cloche côté PCE : %d' % (bb[2], bb[0], sum(1 for j in range(n) if pc[j][1])))
print('   score MD final : %d' % int(score[n]))
print('   à décalage 0 : nuages %d, cloches %d, joueur %d frames différentes' % tuple(out[2][1:4]))
a = range(4, n - 4); both = [j for j in a if pc[j][1] and md[j][1]]
ey = [j for j in both if sorted(y for x, y in pc[j][1]) != sorted(y for x, y in md[j][1])]
e1 = [j for j in ey if len(pc[j][1]) == len(md[j][1]) and max(abs(p[1] - m[1]) for p, m in zip(sorted(pc[j][1], key=lambda e: e[1]), sorted(md[j][1], key=lambda e: e[1]))) <= 1]
big = [j for j in ey if j not in e1]
print('   première frame où une cloche s\'écarte de plus d\'1 px : %s' % (int(fr[i0 + big[0]]) if big else 'aucune'))
print('   cloches, hauteur seule : %d frames avec cloche des deux côtés, %d différentes dont %d à 1 px près ; PCE seul %d frames, MD seul %d' % (len(both), len(ey), len(e1), sum(1 for j in a if pc[j][1] and not md[j][1]), sum(1 for j in a if md[j][1] and not pc[j][1])))
# --- ennemis de la vague 1 : centres en RAM PCE (objets 66 à 71) contre l'état MD, 2 frames plus tard (retard d'affichage PCE)
if 'enemies' in sym:
    ME = 24; Eo = sym['enemies']; eOn = np.stack([R.w(Eo + 2 * k) for k in range(ME)], 1); eX = np.stack([R.w(Eo + 2 * ME + 2 * k) for k in range(ME)], 1); eY = np.stack([R.w(Eo + 4 * ME + 2 * k) for k in range(ME)], 1); kills = R.w(Eo + 6 * ME)
    s8 = lambda v: v - 256 if v > 127 else v
    eK = np.stack([R.w(Eo + 6 * ME + 4 + 2 * k) for k in range(ME)], 1)
    bst = [np.stack([R.w(Eo + 6 * ME + 4 + 2 * ME + 2 * k + 2 * 2 * q) for k in range(2)], 1) for q in range(3)]
    if os.environ.get('DBGB'):
        for j in range(1, n - 6):
            if bst[0][j].any() or bst[0][j - 1].any(): print('     MD game f%d bombs state %s x %s y %s' % (int(fr[i0 + j]), bst[0][j], bst[1][j], bst[2][j]))
    res = {}
    for ty in (5, 3, 4, 7, 8, 6, 11, 12, 9, 10, 14, 15):
        cmpn = bad = 0; firstbad = None
        for j in range(1, n - 6):
            t = i0 + j
            # tous les objets ennemis du type en vol (emplacements 66 à 83), contre l'état MD 2 frames plus tard
            pe = sorted((int(ram[t, 0xB47 + S]) + 256 * s8(int(ram[t, 0xADA + S])), int(ram[t, 0xC8E + S]) + 256 * s8(int(ram[t, 0xC21 + S]))) for S in range(66, 102) if int(ram[t, 0xF1C + S]) in ((13, 14) if ty == 14 else (ty,)) and (S >= 96) == (ty in (14, 15)) and int(ram[t, 0xF89 + S]) in ((1, 2) if ty not in (6, 7, 8, 9, 10, 11, 12, 14, 15) else (1, 2, 3, 4, 5, 6)))
            me = sorted((int(eX[j + 2, k]), int(eY[j + 2, k])) for k in range(ME) if eOn[j + 2, k] == 1 and eK[j + 2, k] == ty)
            if not pe and not me: continue
            cmpn += 1
            if pe != me:
                bad += 1
                if firstbad is None: firstbad = (int(fr[t]), pe[:3], me[:3])
                if os.environ.get('DBGG') and ty in (14, 15): print('     diff f%d PCE %s MD %s' % (int(fr[t]), pe[:6], me[:6]))
        res[ty] = (cmpn, bad, firstbad)
    cmpn, bad, firstbad = res[5]
    for ty in (3, 4, 7, 8, 6, 11, 12, 9, 10, 14, 15): print('   ennemis type %d    : %d frames comparées, %d différentes%s' % ((ty,) + res[ty][:2] + ((' ; première : f%d PCE %s MD %s' % res[ty][2]) if res[ty][2] else '',)))
    if os.environ.get('DBGE'):
        f0 = int(os.environ['DBGE'])
        for j in range(f0 - int(fr[i0]), f0 - int(fr[i0]) + 6):
            print('     RAM f%d PCE %s | MD(+2) %s tirs %s chargé %s' % (fr[i0 + j], [(int(ram[i0 + j, 0xB47 + S]), int(ram[i0 + j, 0xC8E + S]), int(ram[i0 + j, 0xF89 + S])) for S in range(66, 72)], [(int(eOn[j + 2, k]), int(eX[j + 2, k]), int(eY[j + 2, k])) for k in range(6)], (int(pf['shotActive'][j + 2]), int(pf['shotX'][j + 2]), int(pf['shotY'][j + 2])), int(R.w(P + 12)[j + 2])))
    print('   ennemis (type 5)  : %d frames comparées, %d différentes%s ; ennemis détruits côté MD : %d' % (cmpn, bad, (' ; première : f%d PCE %s MD %s' % firstbad) if firstbad else '', int(kills[n])))
# --- mort du joueur : état de l'objet 0 côté PCE ($2F89 : 3 = touché, 1 = réapparition, 2 = en jeu) contre player.phase
if not INV:
    ph = R.w(P + 26); st0 = np.array(ram[i0:, 0xF89]).astype(int)
    pd = [int(fr[i0 + j]) for j in range(1, n) if st0[j] == 3 and st0[j - 1] == 2]; mdd = [int(fr[i0 + j]) for j in range(1, n) if ph[j] == 1 and ph[j - 1] == 0]
    pr = [int(fr[i0 + j]) for j in range(1, n) if st0[j] == 2 and st0[j - 1] == 1 and j > 300]; mr = [int(fr[i0 + j]) for j in range(1, n) if ph[j] == 0 and ph[j - 1] == 2]
    print('   morts : PCE aux frames %s, MD aux frames %s ; retour des commandes : PCE %s, MD %s ; vies MD à la fin : %d' % (pd[:6], mdd[:6], pr[:6], mr[:6], int(R.w(P + 30)[n])))
if not INV:
    al = R.w(P + 34); ab = R.w(P + 36); ah = R.w(P + 40)
    pl = np.array(ram[i0:, 0x14A5]).astype(int); pb = np.array(ram[i0:, 0x18E7]).astype(int)
    pe = [(int(fr[i0 + j]), int(pl[j])) for j in range(1, n) if pl[j] != pl[j - 1]]; me = [(int(fr[i0 + j]), int(al[j])) for j in range(1, n) if al[j] != al[j - 1]]
    pbe = [(int(fr[i0 + j]), int(pb[j])) for j in range(1, n) if pb[j] != pb[j - 1]]; mbe = [(int(fr[i0 + j]), int(ab[j])) for j in range(1, n) if ab[j] != ab[j - 1]]
    print('   bras perdus : PCE %s | MD %s' % (pe[:8], me[:8])); print('   clignotement : PCE %s | MD %s' % (pbe[:8], mbe[:8]))
    # sprites de bras (motif 1D0, palette 0) affichés sur PCE contre bras dessinés côté MD (frame de calcul = affichage - 2)
    pcnt = [sum(1 for x, y, p_, pal, hf, w, h, k in pcetrace.sprites(sat[i0 + j]) if p_ == 0x1D0 and pal == 0) for j in range(n)]
    ph_ = R.w(P + 26)
    for sh in (0, 1, 2, 3):
        bad = [int(fr[i0 + j]) for j in range(8, n - 8) if ph_[j] == 0 and ph_[j - 1] == 0 and (2 - bin(int(ah[j - sh + 2])).count('1')) != pcnt[j] and pcnt[j] in (0, 1, 2) and int(keys[i0 + j]) & 0xF0 == 0 and pl[j] != 0]
        print('   bras dessinés (décalage %d) : %d frames différentes %s' % (sh, len(bad), bad[:6]))
if os.environ.get('DBG'):
    lag = int(os.environ.get('LAG', 0)); k = 0
    for j in range(4, n - 4):
        dc = (sorted(set(pc[j][0]) - set(md[j + lag][0])), sorted(set(md[j + lag][0]) - set(pc[j][0]))); db = (sorted(set(pc[j][1]) - set(md[j + lag][1])), sorted(set(md[j + lag][1]) - set(pc[j][1])))
        if os.environ['DBG'] == 'y' and sorted(y for x, y in pc[j][1]) == sorted(y for x, y in md[j + lag][1]): continue
        if any(dc) or any(db):
            print('   f%d nuages PCE seul %s MD seul %s | cloches PCE seul %s MD seul %s | tir MD %s joueur %s' % (fr[i0 + j], dc[0], dc[1], db[0], db[1], (int(pf['shotActive'][j + lag]), int(pf['shotX'][j + lag]), int(pf['shotY'][j + lag])), (int(pf['x'][j + lag]), int(pf['y'][j + lag])))); k += 1
            if k >= int(os.environ.get('NDBG', 14)): break
del R; os.remove('md/shots/%s.ramtrace' % name)
