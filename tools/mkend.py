#!/usr/bin/env python3
"""Fond de la fin (stage 6) -> md/twinbee/src/end_data.h
Pour chaque scène : tuiles uniques (identifiants de « chronologie de couleur » = valeurs successives d'une entrée de palette PCE
dans les dumps de la scène), répartition sur K palettes MD de 15 couleurs + fond commun, carte 64x64, chronologie des couleurs
(un échantillon tous les 20 frames, interpolé à l'exécution : les fondus de la PCE)."""
import sys, collections, numpy as np
sys.path.insert(0, 'tools')
import pcegfx, mdpal
D = 'dumps/end6b/w%d'
# (nom, frame de la carte, première frame, dernière frame, K)
SCENES = [('a', [(126340, 126400), (126660, 126700), (127480, 127480), (128520, 128520)], 126340, 128760, 2), ('b', [(128780, 128780)], 128780, 133360, 2), ('c', [(133380, 133380)], 133380, 136040, 3)]
def md9(c):
    g, r, b = (c >> 6) & 7, (c >> 3) & 7, c & 7
    return (b << 9) | (g << 5) | (r << 1)
out = ['// Généré par tools/mkend.py : fond de la fin (scènes a, b, c)\n#ifndef END_DATA_H\n#define END_DATA_H\n#include <genesis.h>\n']
for name, maps, f0, f1, K in SCENES:
    v, s, p, r = pcegfx.load(D % maps[0][1])
    steps = list(range(f0 - f0 % 20 + (20 if f0 % 20 else 0), f1 + 1, 20))
    pals = [pcegfx.load(D % f)[2] for f in steps]
    # entrées de palette utilisées : (pal*16+idx) -> chronologie
    ent = {}
    def tl(e): return tuple(int(pp[e]) for pp in pals)
    tiles = {}; tlist = []; tmaps = []
    for mf, md_ in maps:
        v, s_, p_, r_ = pcegfx.load(D % md_)
        bat = v[:4096].reshape(64, 64); t8 = pcegfx.tiles8(v); tmap = np.zeros((64, 64), int)
        for ty in range(64):
            for tx in range(64):
                bb = int(bat[ty, tx]); t = t8[bb & 0x7FF]; pl = bb >> 12
                key = (t.tobytes(), pl)
                if key not in tiles: tiles[key] = len(tlist); tlist.append((t, pl))
                tmap[ty, tx] = tiles[key]
        tmaps.append(tmap)
    KSS = [23, len(steps) // 2] if name == 'a' else [len(steps) - 1]
    def KY(t): return tuple(t[q] for q in KSS)
    merged = {}          # couleur finale -> couleur finale représentante (fusion des couleurs proches si le tassement échoue)
    def run(merged):
        ids = {}; idlist = []
        def tid(e):
            t = tl(e); k = merged.get(KY(t), KY(t))
            if k not in ids: ids[k] = len(idlist); idlist.append(t)
            return ids[k]
        px = [np.array([tid(pl * 16 + int(i)) for i in t.ravel()]) for t, pl in tlist]
        allid = np.concatenate(px); vals, cnt = np.unique(allid, return_counts=True); back = int(vals[cnt.argmax()])
        sets = [frozenset(set(a.tolist()) - {back}) for a in px]
        setlist = sorted(set(sets), key=lambda x: sorted(x)); sidx = {x: i for i, x in enumerate(setlist)}
        w = [0] * len(setlist)
        for k, x in enumerate(sets): w[sidx[x]] += sum(int((m == k).sum()) for m in tmaps)
        lost, ps, assign = mdpal.solve(setlist, w, K, back, tries=3000)
        return lost, ps, assign, ids, idlist, px, sets, sidx, back
    def rgb3(c): return np.array([(c >> 3) & 7, (c >> 6) & 7, c & 7])
    while True:
        lost, ps, assign, ids, idlist, px, sets, sidx, back = run(merged)
        if lost == 0: break
        cur = sorted(set(merged.get(KY(t), KY(t)) for t in (tl(pl * 16 + int(i)) for t, pl in tlist for i in set(t.ravel().tolist()))))
        use = collections.Counter()
        for k_, (t_, pl_) in enumerate(tlist):
            nuse = sum(int((m_ == k_).sum()) for m_ in tmaps)
            for i_ in t_.ravel().tolist():
                kk_ = KY(tl(pl_ * 16 + int(i_))); use[merged.get(kk_, kk_)] += nuse
        best = None
        for i in range(len(cur)):
            for j in range(i + 1, len(cur)):
                d = sum(int(((rgb3(a_) - rgb3(b_)) ** 2).sum()) for a_, b_ in zip(cur[i], cur[j]))
                d = (d + 1) * min(use[cur[i]], use[cur[j]])      # fusionne d'abord les couleurs proches ET rares
                if best is None or d < best[0]: best = (d, cur[i], cur[j])
        merged = {k: (best[1] if v == best[2] else v) for k, v in merged.items()}; merged[best[2]] = best[1]
    ps = [sorted(x) for x in ps]
    print(name, 'tuiles', len(tlist), 'ids', len(idlist), 'palettes', [len(x) for x in ps], 'perdu', lost)
    rawt = bytearray(); attr = np.zeros(len(tlist), int)
    for k, a in enumerate(px):
        pk = assign[sidx[sets[k]]]
        if pk is None:
            raise SystemExit('tuile sans palette')
        attr[k] = pk
        m = {back: 0}; m.update({c: 1 + j for j, c in enumerate(ps[pk])})
        for row in range(8):
            wv = 0
            for x in range(8): wv = (wv << 4) | m[int(a[row * 8 + x])]
            rawt += wv.to_bytes(4, 'big')
    n = len(steps)
    out.append('#define END_%s_TILES %d\n#define END_%s_STEPS %d\n#define END_%s_STEP0 %d\n' % (name.upper(), len(tlist), name.upper(), n, name.upper(), steps[0]))
    out.append('static const u32 end_%s_tiles[%d] = {%s};\n' % (name, len(rawt) // 4, ','.join('0x%08X' % int.from_bytes(rawt[i:i + 4], 'big') for i in range(0, len(rawt), 4))))
    out.append('#define END_%s_NMAPS %d\nstatic const s32 end_%s_mapf[%d] = {%s};\n' % (name.upper(), len(maps), name, len(maps), ','.join(str(m[0]) for m in maps)))
    for mi, tm in enumerate(tmaps):
        out.append('static const u16 end_%s_map%d[4096] = {%s};\n' % (name, mi, ','.join(str((int(tm[y, x]) + 0) | (int(attr[tm[y, x]]) << 13)) for y in range(64) for x in range(64))))
    # chronologie : pour chaque palette MD k, 16 entrées (fond + 15) x steps
    cols = []
    for k in range(K):
        line = [back] + ps[k] + [back] * (15 - len(ps[k]))
        for e in line: cols.append([md9(c) for c in idlist[e]] if False else None)
    # idlist[e] est un tuple de valeurs par step
    tabl = []
    for st in range(n):
        for k in range(K):
            line = [back] + ps[k] + [back] * (15 - len(ps[k]))
            for e in line: tabl.append(md9(idlist[e][st]))
    out.append('static const u16 end_%s_pal[%d] = {%s};\n' % (name, len(tabl), ','.join('0x%04X' % c for c in tabl)))
    out.append('#define END_%s_NPAL %d\n' % (name.upper(), K))
out.append('#endif\n')
open('md/twinbee/src/end_data.h', 'w').write(''.join(out))
