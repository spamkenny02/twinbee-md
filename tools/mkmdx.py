#!/usr/bin/env python3
"""mkmdx.py <n° MDX> <sortie.vgm> : convertit un .MDX (version X68000 de Detana!! TwinBee, voix OPM = voix YM2612) en VGM Mega Drive.
Pistes 0-5 -> FM (YM2612, 6 canaux, DAC coupé), 6-7 -> PSG (carré), piste ADPCM -> percussions PSG (bruit + ton 2)."""
import sys, os, math, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import mdx
from mkmusic import Vgm, fm_freq, FRM

OFF = 15                 # n° de note MDX -> MIDI (calé sur les captures PCE)
MTL = int(os.environ.get('MTL', '8'))        # atténuation TL supplémentaire (FM)
PSGV = int(os.environ.get('PSGV', '3'))      # atténuation PSG de base (pas de 2 dB)
SR = 44100
FMCH = [0, 1, 2, 4, 5, 6]
CARR = {0: [3], 1: [3], 2: [3], 3: [3], 4: [2, 3], 5: [1, 2, 3], 6: [1, 2, 3], 7: [0, 1, 2, 3]}
REG = [0, 4, 8, 12]

def att_of(v):
    if v >= 0x80: return v - 0x80
    if v < 16: return mdx.VOLTAB[v]
    return 0x20

def convert(num, out):
    m = mdx.Mdx(f'/home/claude/work/extract/mdx/DTWNB{num:02d}.MDX')
    vo = m.parse_voices(m.base + m.voice_off)
    tracks = []; pos2t0 = None; end0 = 0
    for k in range(9):
        tracks.append(m.track(k))
        if k == 0: pos2t0 = dict(m.pos2t); end0 = m.last_t
    # boucle
    tl = None; end_t = 0; looping = False
    NOLOOP = (7,)
    for k in range(9):
        ev = tracks[k]
        if k == 0:
            end_t = end0
            lp = [e for e in ev if e[0] == 'loop']
            if lp and num not in NOLOOP: looping = True; tl = pos2t0.get(lp[0][2], 0)
    for k in range(9): pass
    # carte de tempo
    tev = sorted(set((e[1], e[2]) for k in range(9) for e in tracks[k] if e[0] == 'tempo'))
    if not tev or tev[0][0] != 0: tev.insert(0, (0, 224))
    def sec(t):
        acc = 0.0; ct = 0; T = tev[0][1]
        for (tt, TT) in tev:
            if tt >= t: break
            acc += (tt - ct) * 1024 * (256 - T) / 4e6; ct = tt; T = TT
        return acc + (t - ct) * 1024 * (256 - T) / 4e6
    smp = lambda t: int(round(sec(t) * SR))
    # segments par piste
    def segments(ev):
        segs = []; ns = [e for e in ev if e[0] == 'n']
        pan_ev = [(e[1], e[2]) for e in ev if e[0] == 'pan']
        for e in ns:
            _, t, ln, n, vol, voice, tie, q = e
            if tie and segs and segs[-1]['end'] == t:
                segs[-1]['end'] = t + ln
                if n != segs[-1]['cur']: segs[-1]['bends'].append((t, n)); segs[-1]['cur'] = n
            else:
                pan = 3
                for (pt, pv) in pan_ev:
                    if pt <= t: pan = pv
                segs.append(dict(t=t, end=t + ln, n=n, cur=n, att=att_of(vol), voice=voice, bends=[], pan=pan))
        return segs
    FS = {}
    vg = Vgm()
    acts = []     # (sample, ordre, fonction)
    vg_ym = vg.ym
    ymreg = lambda ch, reg, val: vg.ym(1 if ch >= 3 else 0, reg + (ch % 3), val)
    state = {}
    def keycode(c): return c if c < 3 else c + 1 - 0   # 0..2 ; 4..6 (c = 3..5 -> 4..6)
    # chaque canal FM : liste d'actions
    for k in range(min(6, 8)):
        segs = segments(tracks[k]); c = FMCH[k]; kc = c if c < 3 else c + 1 - 0
        kc = [0, 1, 2, 4, 5, 6][k]
        chp = [0, 1, 2, 0, 1, 2][k]; port = 0 if k < 3 else 1
        forced = False
        cur = [None]
        for sgi, sg in enumerate(segs):
            def on(sg=sg, k=k, port=port, chp=chp, kc=kc, first_after=(tl is not None and sg['t'] >= tl)):
                v = vo.get(sg['voice'])
                if v is None: return
                if first_after and not state.get(('f', k)):
                    state[('f', k)] = True; cur[0] = None
                if cur[0] != sg['voice']:
                    cur[0] = sg['voice']
                    for i, off in enumerate(REG):
                        vg.ym(port, 0x30 + off + chp, v['dt1mul'][i]); vg.ym(port, 0x50 + off + chp, v['ksar'][i] & 0xDF)
                        vg.ym(port, 0x60 + off + chp, v['amd1r'][i] & 0x9F); vg.ym(port, 0x70 + off + chp, v['dt2d2r'][i] & 0x1F)
                        vg.ym(port, 0x80 + off + chp, v['d1lrr'][i])
                    vg.ym(port, 0xB0 + chp, v['fl'] & 0x3F)
                alg = v['fl'] & 7
                for i, off in enumerate(REG):
                    tl_ = v['tl'][i] & 0x7F
                    if i in CARR[alg]: tl_ = min(127, tl_ + sg['att'] + MTL)
                    vg.ym(port, 0x40 + off + chp, tl_)
                vg.ym(port, 0xB4 + chp, ((sg['pan'] & 3) or 3) << 6)
                fh = 440.0 * 2 ** ((sg['n'] + OFF - 69) / 12.0)
                blk, fn = fm_freq(fh); vg.ym(port, 0xA4 + chp, (blk << 3) | (fn >> 8)); vg.ym(port, 0xA0 + chp, fn & 255)
                vg.ym(0, 0x28, 0xF0 | kc)
            acts.append((smp(sg['t']), 1, on))
            for (bt, bn) in sg['bends']:
                def bend(bn=bn, port=port, chp=chp):
                    fh = 440.0 * 2 ** ((bn + OFF - 69) / 12.0)
                    blk, fn = fm_freq(fh); vg.ym(port, 0xA4 + chp, (blk << 3) | (fn >> 8)); vg.ym(port, 0xA0 + chp, fn & 255)
                acts.append((smp(bt), 1, bend))
            def off_(kc=kc): vg.ym(0, 0x28, kc)
            acts.append((smp(sg['end']), 0, off_))
    # PSG tons : pistes 6, 7 -> tons 0, 1
    for k in (6, 7):
        if k >= len(tracks): continue
        segs = segments(tracks[k]); pi = k - 6
        for sg in segs:
            def pon(sg=sg, pi=pi):
                fh = 440.0 * 2 ** ((sg['n'] + OFF - 69) / 12.0)
                n = int(round(3579545 / (32 * fh)))
                while n > 1023: n //= 2
                n = max(1, n)
                vg.psg(0x80 | (pi << 5) | (n & 15)); vg.psg((n >> 4) & 63)
                v4 = max(0, min(15, PSGV + int(round(sg['att'] * 0.75 / 2.0))))
                vg.psg(0x90 | (pi << 5) | v4)
            acts.append((smp(sg['t']), 1, pon))
            for (bt, bn) in sg['bends']:
                def pb(bn=bn, pi=pi):
                    fh = 440.0 * 2 ** ((bn + OFF - 69) / 12.0); n = max(1, int(round(3579545 / (32 * fh))))
                    while n > 1023: n //= 2
                    vg.psg(0x80 | (pi << 5) | (n & 15)); vg.psg((n >> 4) & 63)
                acts.append((smp(bt), 1, pb))
            def poff(pi=pi): vg.psg(0x90 | (pi << 5) | 15)
            acts.append((smp(sg['end']), 0, poff))
    # percussions (piste ADPCM = index 8)
    if len(tracks) > 8:
        ns = [e for e in tracks[8] if e[0] == 'n']
        hid = [0]
        pcur = {'noise': -1, 'tone': -1}
        def sched(t0, res, hit, steps):
            for (dt, fn) in steps:
                def f(hit=hit, res=res, fn=fn):
                    if pcur[res] == hit: fn()
                acts.append((t0 + int(dt * SR / 60), 1, f))
        def psgfreq(hz):
            n = max(1, min(1023, int(round(3579545 / (32 * hz)))))
            vg.psg(0xC0 | (n & 15)); vg.psg((n >> 4) & 63)
        for e in ns:
            _, t, ln, dn, vol, voice, tie, q = e
            t0 = smp(t); hid[0] += 1; hit = hid[0]
            if dn == 0 or dn == 2:             # grosse caisse : ton 2 descendant
                def start(hit=hit): pcur['tone'] = hit
                acts.append((t0, 1, start))
                steps = [(0, lambda: (psgfreq(140), vg.psg(0xD0 | 1)))] + [(i, (lambda i=i: (psgfreq(140 - 13 * i), vg.psg(0xD0 | min(15, 1 + i))))) for i in range(1, 7)] + [(7, lambda: vg.psg(0xDF))]
                sched(t0, 'tone', hit, steps)
            elif dn == 1 or dn == 10 or dn == 11:                # caisse claire : bruit blanc
                def start(hit=hit): pcur['noise'] = hit
                acts.append((t0, 1, start))
                steps = [(0, lambda: (vg.psg(0xE7), vg.psg(0xF0 | 2)))] + [(i, (lambda i=i: vg.psg(0xF0 | min(15, 2 + 2 * i)))) for i in range(1, 6)] + [(6, lambda: vg.psg(0xFF))]
                sched(t0, 'noise', hit, steps)
            elif dn == 9:                       # cymbale : bruit long
                def start(hit=hit): pcur['noise'] = hit
                acts.append((t0, 1, start))
                steps = [(0, lambda: (vg.psg(0xE4), vg.psg(0xF0 | 4)))] + [(i, (lambda i=i: vg.psg(0xF0 | min(15, 4 + i // 2)))) for i in range(1, 22)] + [(22, lambda: vg.psg(0xFF))]
                sched(t0, 'noise', hit, steps)
            elif dn in (3, 4, 5, 6, 7, 8):      # toms : ton 2 pitché
                base = {3: 220, 4: 180, 5: 150, 6: 125, 7: 105, 8: 90}[dn]
                def start(hit=hit): pcur['tone'] = hit
                acts.append((t0, 1, start))
                steps = [(i, (lambda i=i, b=base: (psgfreq(b * (1 - 0.06 * i)), vg.psg(0xD0 | min(15, 1 + i))))) for i in range(0, 9)] + [(9, lambda: vg.psg(0xDF))]
                sched(t0, 'tone', hit, steps)
            else:                                # autres : charleston, bruit court
                def start(hit=hit): pcur['noise'] = hit
                acts.append((t0, 1, start))
                steps = [(0, lambda: (vg.psg(0xE4), vg.psg(0xF0 | 5)))] + [(2, lambda: vg.psg(0xFF))]
                sched(t0, 'noise', hit, steps)
    # init
    vg.ym(0, 0x2B, 0x00); vg.ym(0, 0x27, 0x00)
    for p in range(4): vg.psg(0x90 | (p << 5) | 15)
    # le ton 2 sert aux percussions : fréquence initiale
    total = smp(end_t)
    acts.sort(key=lambda a: (a[0], a[1]))
    loop_s = smp(tl) if looping else None
    marked = False
    for (sp, o, fn) in acts:
        if sp > total: continue
        if looping and not marked and sp >= loop_s:
            vg.wait_to(loop_s); vg.mark_loop(); marked = True
        vg.wait_to(sp); fn()
    if looping and not marked: vg.wait_to(loop_s); vg.mark_loop()
    vg.wait_to(total)
    for kc in (0, 1, 2, 4, 5, 6): vg.ym(0, 0x28, kc)
    for pp in range(4): vg.psg(0x90 | (pp << 5) | 15)
    data = vg.build(bytearray())
    open(out, 'wb').write(data)
    print(f'MDX {num}: {total / SR:.1f} s, boucle {"à " + str(round(smp(tl) / SR, 1)) + " s" if looping else "non"}, VGM {len(data)} o')

if __name__ == '__main__':
    convert(int(sys.argv[1]), sys.argv[2])
