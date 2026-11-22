#!/usr/bin/env python3
"""mkmusic.py <id> [--out dir] : convertit une capture PSG HuC6280 (dumps/songs/g<ID>.psg, produit par pcedump psglog + snd)
en VGM Mega Drive (YM2612 additif 4 opérateurs + SN76489 + DAC PCM) prêt pour rescomp XGM2.

Modèle :
  - canaux PCE à onde (1,2,3 ; 0 dans le titre) -> FM, algo 7 (4 opérateurs en additif, MUL = harmoniques de la forme d'onde)
  - canal 5 -> PSG tone 0, canal 0 (titre) -> FM4 ; canal 4 bruit -> PSG bruit, canal 4 DDA -> PCM (DAC)
  - état échantillonné une fois par frame (60 Hz), volume = enveloppe du pilote d'origine.
"""
import sys, os, struct, math, collections, hashlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from psgw import load_writes, PSG
import numpy as np

SR = 44100
FRM = 735                       # échantillons VGM par frame NTSC
YM_CLK = 7670454
FM_BASE = 144 * 2**20 / YM_CLK  # fnum = f*FM_BASE/2^(block-1)
G_FM = float(os.environ.get('G_FM', '-5.5'))    # dB, gain global FM
G_PSG = float(os.environ.get('G_PSG', '4.6'))
G_PCM = float(os.environ.get('G_PCM', '-3'))
MB = float(os.environ.get('MB', '7'))             # dB, gain général (volume trop bas après simplification du timbre)
G_FM += MB; G_PSG += MB; G_PCM += MB
HMAX = int(os.environ.get('HMAX', '4'))       # harmonique maximale conservée (timbre plus doux)
NH = int(os.environ.get('NH', '3'))           # nombre d'opérateurs utilisés
QUANT = int(os.environ.get('QUANT', '1'))     # hauteur arrondie au demi-ton (supprime vibrato et désaccord)
ONLY = os.environ.get('MUS_ONLY')   # ex '1' ou '4' : ne garde que ce canal PCE (test de calibration)
START = 3560                    # première frame utile des captures g<ID>

def att_db(vol, pan, main):
    """atténuation PCE (dB) pour un volume canal 5 bits, panoramique et amplitude principale (octets L/R)"""
    p = max(pan >> 4, pan & 15)
    m = max(main >> 4, main & 15)
    return 1.5 * (31 - vol) + 3.0 * (15 - p) + 3.0 * (15 - m)

_wave_cache = {}
def wave_ops(wave, fhz):
    """4 harmoniques (mul, amplitude relative 0..1) pour une forme d'onde 32 x 5 bits"""
    key = (bytes(wave), int(fhz // 200))
    if key in _wave_cache: return _wave_cache[key]
    a = np.array(wave, float); a -= a.mean()
    sp = np.abs(np.fft.rfft(a))[1:16] * 2 / 32          # harmoniques 1..15
    cand = []
    for h in range(1, 16):
        if fhz * h > 9000 or h > HMAX: continue
        cand.append((sp[h - 1], h))
    cand.sort(reverse=True)
    sel = [(h, amp / 15.5) for amp, h in cand[:NH] if amp > 0.04 * (cand[0][0] if cand else 1) and amp > 0.15]
    sel.sort()
    _wave_cache[key] = sel
    return sel

def fm_freq(fhz):
    blk = 0
    while True:
        fn = fhz * FM_BASE / (2 ** (blk - 1))
        if fn < 2047.5 or blk == 7: break
        blk += 1
    fn = int(round(min(fn, 2047)))
    return blk, fn

class Vgm:
    def __init__(s):
        s.cmd = bytearray(); s.t = 0; s.n = 0; s.loop_off = None; s.loop_t = 0
    def wait_to(s, t):
        d = int(t) - s.t
        while d > 0:
            if d == FRM: s.cmd.append(0x62); s.t += d; d = 0
            elif d <= 16: s.cmd.append(0x70 + d - 1); s.t += d; d = 0
            else:
                w = min(d, 65535); s.cmd += bytes([0x61, w & 255, w >> 8]); s.t += w; d -= w
    def ym(s, port, reg, val): s.cmd += bytes([0x52 + port, reg, val & 255])
    def psg(s, val): s.cmd += bytes([0x50, val & 255])
    def mark_loop(s): s.loop_off = len(s.cmd); s.loop_t = s.t

    def build(s, bank):
        head = bytearray(0x100)
        head[0:4] = b'Vgm '
        struct.pack_into('<I', head, 0x08, 0x171)
        struct.pack_into('<I', head, 0x0C, 3579545)
        struct.pack_into('<I', head, 0x24, 60)
        struct.pack_into('<H', head, 0x28, 9)
        head[0x2A] = 16
        struct.pack_into('<I', head, 0x2C, YM_CLK)
        struct.pack_into('<I', head, 0x34, 0x100 - 0x34)
        data = bytearray()
        if len(bank):
            data += bytes([0x67, 0x66, 0x00]) + struct.pack('<I', len(bank)) + bytes(bank)
        body = bytes(data) + bytes(s.cmd) + b'\x66'
        total = s.t
        struct.pack_into('<I', head, 0x18, total)
        if s.loop_off is not None:
            struct.pack_into('<I', head, 0x1C, 0x100 + len(data) + s.loop_off - 0x1C)
            struct.pack_into('<I', head, 0x20, total - s.loop_t)
        struct.pack_into('<I', head, 0x04, 0x100 + len(body) - 4)
        return bytes(head) + body

def capture(path):
    fr = load_writes(path); s = PSG(); rows = []; dda = []
    cur = None
    for f, c, w in fr:
        n = len(w); vals = []
        for k, (cc, a, v) in enumerate(w):
            s.write(a, v)
            if a == 6 and (s.ctl[s.sel] & 0x40) and s.sel == 4:
                vals.append((k / max(n, 1), s.dda[4]))
        if f < START: continue
        snap = []
        for ch in range(6):
            wv = list(s.wave[ch])
            snap.append(dict(on=1 if (s.ctl[ch] & 0x80) and not (s.ctl[ch] & 0x40) else 0, f=s.freq[ch], vol=s.ctl[ch] & 31,
                             pan=s.pan[ch], wave=wv, noise=s.noise[ch], dd=1 if (s.ctl[ch] & 0x40) else 0))
        rows.append((snap, s.main))
        dda.append((vals, s.ctl[4] & 31, s.pan[4], s.main))
    return rows, dda

def find_loop(rows):
    def tsig(r):
        out = []
        for c in range(1, 4):
            ch = r[0][c]
            out.append((int(ch['on'] and ch['vol'] > 0), int(round(12 * math.log2(111861 / max(ch['f'], 1)))) if ch['on'] and ch['vol'] > 0 else 0))
        out.append(int(r[0][4]['on'] and r[0][4]['vol'] > 0))
        return hash(tuple(out))
    sig = np.array([tsig(r) for r in rows], dtype=np.int64)
    n = len(sig); best = (0, 0)
    for L in range(300, n // 2):
        m = (sig[:n - L] == sig[L:]).mean()
        if m > best[0]: best = (m, L)
    m, P = best
    eq = (sig[:n - P] == sig[P:]).astype(float)
    k = np.convolve(eq, np.ones(300) / 300, mode='valid')
    idx = np.flatnonzero(k >= 0.8)
    L0 = int(idx[0]) if len(idx) else 0
    return L0, P, m

def convert(sid, out, maxframes=None, noloop=False):
    rows, dda = capture(f'/home/claude/work/dumps/songs/g{sid}.psg')
    if noloop:
        L0, P, m = 0, len(rows), 0
        total = len(rows)
    else:
        L0, P, m = find_loop(rows)
        total = L0 + P
        if sid == 83: L0, P, m, total = 0, 1400, 1.0, 1400      # titre : toute la mélodie en boucle (la boucle détectée est un simple silence)
    if maxframes: total = min(total, maxframes)
    # silence final : chercher la dernière frame active pour songs sans boucle (jingles)
    act = [any(ch['on'] and ch['vol'] > 0 or ch['dd'] for ch in r[0]) for r in rows]
    last = max(i for i, a in enumerate(act) if a) if any(act) else 0
    if m < 0.4 or noloop: total = min(total, last + 30); loop = False
    else: loop = True
    # --- échantillons DDA
    hits = []; cur = None
    for fi in range(total):
        vals, vol, pan, main = dda[fi]
        if vals:
            if cur is None: cur = dict(f=fi, v=[], tt=[], vol=vol, pan=pan, main=main)
            n = len(vals)
            for (frac, v) in vals: cur['v'].append(v); cur['tt'].append(fi * FRM + frac * FRM)
        else:
            if cur is not None: hits.append(cur); cur = None
    if cur is not None: hits.append(cur)
    bank = bytearray(); masters = {}
    for h in hits:
        key = bytes(h['v'][:40])
        m_ = masters.get(key)
        if m_ is None or len(h['v']) > masters[key]['len']:
            pass
        masters.setdefault(key, dict(len=0, v=None))
        if len(h['v']) > masters[key]['len']: masters[key]['len'] = len(h['v']); masters[key]['v'] = h['v']
    for key, mm in masters.items():
        g = 10 ** ((G_PCM) / 20)
        data = bytes(max(0, min(255, int(round(128 + (v - 15.5) / 15.5 * 127 * g)))) for v in mm['v'])
        mm['off'] = len(bank); bank += data
        while len(bank) % 16: bank.append(128)
    vg = Vgm()
    # --- init YM
    vg.ym(0, 0x2B, 0x80)                         # DAC on
    vg.ym(0, 0x27, 0x00)
    FMCH = [0, 1, 2, 4, 5]                       # canaux FM utilisables (6 = DAC)
    def fmreg(ch, reg, val):
        vg.ym(1 if ch >= 3 else 0, reg + (ch % 3), val)
    for ch in range(5):
        c = FMCH[ch]
        for off in (0, 4, 8, 12):
            fmreg(c, 0x50 + off, 0x1F); fmreg(c, 0x60 + off, 0x00); fmreg(c, 0x70 + off, 0x00); fmreg(c, 0x80 + off, 0x0F); fmreg(c, 0x90 + off, 0x00)
            fmreg(c, 0x40 + off, 0x7F); fmreg(c, 0x30 + off, 0x01)
        fmreg(c, 0xB0, 0x07); fmreg(c, 0xB4, 0xC0)
    # attribution des canaux PCE
    fm_src = {0: 1, 1: 2, 2: 3, 3: 0}            # fm index -> canal PCE
    sc = [np.array([any(r[0][c]['on'] and r[0][c]['vol'] > 0 for _ in [0]) for r in rows[:total]]).mean() for c in range(6)]
    fm_state = [None] * 5
    qstate = [None] * 5
    psg_state = dict(tone=[None] * 3, vol=[15] * 4, noise=None)
    for p in range(4): vg.psg(0x90 | (p << 5) | 15)
    stats = collections.Counter()
    pending = []  # (t, kind, data) DDA
    # événements DDA -> liste triée par temps
    dac_events = []
    for h in hits:
        key = bytes(h['v'][:40]); mm = masters[key]
        # temps des écritures d'origine réparties ; on émet une écriture par échantillon maître
        n = len(h['v']); t0 = h['tt'][0]; t1 = h['tt'][-1] if n > 1 else t0 + 100
        step = (t1 - t0) / max(n - 1, 1)
        L = mm['len']
        dac_events.append((t0, 'seek', mm['off']))
        for i in range(L):
            dac_events.append((t0 + i * step, 'dac', mm['off'] + i))
    if ONLY and '4' not in ONLY: dac_events = []
    dac_events.sort(key=lambda e: e[0])
    di = 0
    def flush_dac(upto):
        nonlocal di
        while di < len(dac_events) and dac_events[di][0] <= upto:
            t, kind, d = dac_events[di]
            vg.wait_to(t)
            if kind == 'seek': vg.cmd += b'\xE0' + struct.pack('<I', d)
            else: vg.cmd.append(0x80)
            di += 1
    force = True
    for fi in range(total):
        if loop and fi == L0:
            flush_dac(fi * FRM - 1)
            vg.wait_to(fi * FRM); vg.mark_loop(); force = True
        snap, main = rows[fi]
        t_frame = fi * FRM
        flush_dac(t_frame)
        vg.wait_to(t_frame)
        # ---- FM
        for fi_ch in range(5):
            src = fm_src.get(fi_ch)
            if src is None or (ONLY and str(src) not in ONLY): continue
            ch = snap[src]
            c = FMCH[fi_ch]
            aud = ch['on'] and ch['vol'] > 0 and ch['f'] > 0
            prev = fm_state[fi_ch]
            if aud:
                fhz = 111861.0 / ch['f']
                if QUANT:
                    st = 12 * math.log2(fhz / 440.0)
                    cur = qstate[fi_ch]
                    if cur is None or abs(st - cur) > 0.75 or (prev is None or prev[0] is None): cur = round(st)
                    qstate[fi_ch] = cur
                    fhz = 440.0 * 2 ** (cur / 12)
                ops = wave_ops(ch['wave'], fhz)
                a_db = att_db(ch['vol'], ch['pan'], main) - G_FM - (2.0 if src == 2 else 0.0)
                if not ops: aud = False
            if aud:
                blk, fn = fm_freq(fhz)
                tls = [0x7F] * 4; muls = [1] * 4
                for k, (h, amp) in enumerate(ops):
                    lv = amp * 10 ** (-a_db / 20)
                    tls[k] = 0x7F if lv <= 0 else max(0, min(127, int(round(-20 * math.log10(max(lv, 1e-6)) / 0.75))))
                    muls[k] = h
                new = (blk, fn, tuple(tls), tuple(muls))
                if force or prev is None or prev[0] is None:
                    for k, off in enumerate((0, 4, 8, 12)):
                        fmreg(c, 0x30 + off, muls[k]); fmreg(c, 0x40 + off, tls[k])
                    fmreg(c, 0xA4, (blk << 3) | (fn >> 8)); fmreg(c, 0xA0, fn & 255)
                    vg.ym(0, 0x28, 0xF0 | (c if c < 3 else c + 1))
                    stats['fm_on'] += 1
                else:
                    pb, pf, ptl, pm = prev
                    for k, off in enumerate((0, 4, 8, 12)):
                        if pm[k] != muls[k]: fmreg(c, 0x30 + off, muls[k])
                        if ptl[k] != tls[k]: fmreg(c, 0x40 + off, tls[k])
                    if (pb, pf) != (blk, fn):
                        fmreg(c, 0xA4, (blk << 3) | (fn >> 8)); fmreg(c, 0xA0, fn & 255)
                fm_state[fi_ch] = new
            else:
                if prev is not None and prev[0] is not None:
                    vg.ym(0, 0x28, (c if c < 3 else c + 1))
                    stats['fm_off'] += 1
                fm_state[fi_ch] = (None,); qstate[fi_ch] = None
        # ---- PSG ton 0 <- canal 5
        def psg_tone(pi, ch):
            aud = ch['on'] and ch['vol'] > 0 and ch['f'] > 0
            if aud:
                n = ch['f']
                while n > 1023: n >>= 1
                n = max(n, 1)
                a_db = att_db(ch['vol'], ch['pan'], main) - G_PSG
                w = np.array(ch['wave'], float); pp = (w.max() - w.min()) / 31.0
                lv = max(pp, 0.05) * 10 ** (-a_db / 20)
                v4 = 15 if lv <= 0 else max(0, min(15, int(round(-20 * math.log10(lv) / 2))))
            else:
                n = None; v4 = 15
            st = psg_state['tone'][pi]
            if n is not None and (force or st != n):
                vg.psg(0x80 | (pi << 5) | (n & 15)); vg.psg((n >> 4) & 63); psg_state['tone'][pi] = n
            if force or psg_state['vol'][pi] != v4:
                vg.psg(0x90 | (pi << 5) | v4); psg_state['vol'][pi] = v4
        if not ONLY or '5' in ONLY: psg_tone(0, snap[5])
        # ---- bruit <- canal 4
        c4 = snap[4]
        naud = c4['on'] and c4['vol'] > 0 and (c4['noise'] & 0x80) and (not ONLY or '4' in ONLY)
        if naud:
            nf = c4['noise'] & 31
            rate_hz = 3579545 / (64.0 * (32 - nf))
            n2 = max(1, min(1023, int(round(3579545 / (32.0 * rate_hz)))))
            a_db = att_db(c4['vol'], c4['pan'], main) - G_PSG
            v4 = max(0, min(15, int(round(a_db / 2))))
            if force or psg_state['noise'] != 'on' or psg_state['tone'][2] != n2:
                vg.psg(0xE0 | 0x04 | 3)                      # bruit blanc, horloge = tone 3
                vg.psg(0xC0 | (n2 & 15)); vg.psg((n2 >> 4) & 63)
                vg.psg(0xDF)                                 # tone 3 muet
                psg_state['tone'][2] = n2; psg_state['noise'] = 'on'
            if force or psg_state['vol'][3] != v4:
                vg.psg(0xF0 | v4); psg_state['vol'][3] = v4
        else:
            if force or psg_state['vol'][3] != 15:
                vg.psg(0xFF); psg_state['vol'][3] = 15
            psg_state['noise'] = None
        force = False
    flush_dac(total * FRM)
    vg.wait_to(total * FRM)
    # fin : toutes les voix coupées
    for ch in range(5): vg.ym(0, 0x28, FMCH[ch] if FMCH[ch] < 3 else FMCH[ch] + 1)
    for p in range(4): vg.psg(0x90 | (p << 5) | 15)
    data = vg.build(bank)
    open(out, 'wb').write(data)
    print(f'id {sid}: {total} frames, boucle {"oui L0=%d P=%d (%.2f)" % (L0, P, m) if loop else "non"}, hits PCM {len(hits)} ({len(masters)} échantillons, {len(bank)} o), VGM {len(data)} o', dict(stats))
    return total, loop

if __name__ == '__main__':
    sid = int(sys.argv[1]); out = sys.argv[2] if len(sys.argv) > 2 else f'/home/claude/work/md/twinbee/res/music/s{sid}.vgm'
    os.makedirs(os.path.dirname(out), exist_ok=True)
    convert(sid, out, noloop=(sid in (11, 17, 71, 145, 157, 163, 77)))
