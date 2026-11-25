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
from psgw import load_writes, load_frames, PSG
import numpy as np

SR = 44100
FRM = 735                       # échantillons VGM par frame NTSC
YM_CLK = 7670454
FM_BASE = 144 * 2**20 / YM_CLK  # fnum = f*FM_BASE/2^(block-1)
G_FM = float(os.environ.get('G_FM', '-5.5'))    # dB, gain global FM
G_PSG = float(os.environ.get('G_PSG', '6.0'))
G_PCM = float(os.environ.get('G_PCM', '-2.5'))
MB = float(os.environ.get('MB', '0'))              # dB, gain général (appliqué aux trois bus)
G_FM += MB; G_PSG += MB; G_PCM += MB
HMAX = int(os.environ.get('HMAX', '8'))        # harmonique maximale conservée
NH = int(os.environ.get('NH', '4'))            # nombre d'opérateurs utilisés
QUANT = int(os.environ.get('QUANT', '1'))     # hauteur arrondie au demi-ton (supprime vibrato et désaccord)
ONLY = os.environ.get('MUS_ONLY')   # ex '1' ou '4' : ne garde que ce canal PCE (test de calibration)
START = int(os.environ.get('START', '0'))       # 0 = auto : première frame où un canal est actif

# table d'amplitude PCE (0 = fort, 15 = faible) : huc6280_psg.h k_huc6280_psg_volume_scale
SCALE = [0x00, 0x03, 0x05, 0x07, 0x09, 0x0B, 0x0D, 0x0F,
         0x10, 0x13, 0x15, 0x17, 0x19, 0x1B, 0x1D, 0x1F]

def att_db(vol, pan, main):
    """atténuation PCE (dB) : 1,5 dB par cran du LUT, comme le mélangeur d'origine."""
    pl = SCALE[(pan >> 4) & 15]; pr = SCALE[pan & 15]
    ml = SCALE[(main >> 4) & 15]; mr = SCALE[main & 15]
    # on garde le côté le plus fort (atténuation la plus faible)
    p = min(pl, pr); m = min(ml, mr)
    temp = min(31, (31 - m) + (31 - p) + (31 - vol))
    return 1.5 * temp

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
    sel = [(h, amp / 15.5) for amp, h in cand[:NH] if amp > 0.04 * (cand[0][0] if cand else 1) and amp > 0.08]
    sel.sort()
    # normalise pour que la somme des opérateurs ait la RMS de l'onde PCE (2*sigma/15,5)
    rms_w = math.sqrt(2 * a.var()) / 15.5
    cur = math.sqrt(sum(x * x for _, x in sel) / 2) if sel else 0.0
    if cur > 0:
        k = rms_w / cur
        sel = [(h, x * k) for h, x in sel]
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
    """État par frame depuis l'instantané pcedump (onde complète, y compris les
    formes chargées avant le début du journal) + échantillons DDA du journal."""
    fr = load_frames(path)
    if START > 0:
        start = START
    else:
        start = fr[0]['f']
        for rec in fr:
            if any(ch['ctl'] & 0x80 for ch in rec['ch']):
                start = rec['f']
                break
    s = PSG(); rows = []; dda = []
    for rec in fr:
        n = len(rec['w']); vals = []
        for k, (cc, a, v) in enumerate(rec['w']):
            s.write(a, v)
            if a == 6 and s.sel == 4 and (s.ctl[4] & 0x40):
                vals.append((k / max(n, 1), s.dda[4]))
        if rec['f'] < start:
            continue
        snap = []
        for ch in range(6):
            d = rec['ch'][ch]
            snap.append(dict(on=1 if (d['ctl'] & 0x80) and not (d['ctl'] & 0x40) else 0,
                             f=d['freq'], vol=d['ctl'] & 31,
                             pan=(d['volL'] << 4) | d['volR'],
                             wave=list(d['wave']), noise=d['noise'],
                             dd=1 if (d['ctl'] & 0x40) else 0))
        rows.append((snap, rec['main']))
        c4 = rec['ch'][4]
        dda.append((vals, c4['ctl'] & 31, (c4['volL'] << 4) | c4['volR'], rec['main']))
    return rows, dda

P_FIX = {83: 1400, 91: 3614, 98: 3234, 103: 2420, 108: 1684, 113: 2257,
         123: 2234, 128: 3373, 135: 1271, 140: 1795}   # périodes validées (cf. NOTES.md)

def _tsig(r):
    out = []
    for c in range(1, 4):
        ch = r[0][c]
        out.append((int(ch['on'] and ch['vol'] > 0), int(round(12 * math.log2(111861 / max(ch['f'], 1)))) if ch['on'] and ch['vol'] > 0 else 0))
    out.append(int(r[0][4]['on'] and r[0][4]['vol'] > 0))
    return hash(tuple(out))

def loop_start(sig, P):
    """Première frame où la fenêtre de 300 frames coïncide à 80 % avec +P."""
    n = len(sig)
    eq = (sig[:n - P] == sig[P:]).astype(float)
    k = np.convolve(eq, np.ones(300) / 300, mode='valid')
    idx = np.flatnonzero(k >= 0.8)
    return int(idx[0]) if len(idx) else 0

def find_loop(rows):
    sig = np.array([_tsig(r) for r in rows], dtype=np.int64)
    n = len(sig)
    # période : meilleure similarité sur toute la plage (une boucle peut dépasser n/2)
    cand = []
    for L in range(300, n - 600):
        cand.append(((sig[:n - L] == sig[L:]).mean(), L))
    if not cand:
        return 0, n, 0
    m, P = max(cand)
    return loop_start(sig, P), P, m

def convert(sid, out, maxframes=None, noloop=False):
    rows, dda = capture(os.environ.get('PSGFILE') or f'/home/claude/work/dumps/songs/g{sid}.psg')
    if noloop:
        L0, P, m = 0, len(rows), 0
        total = len(rows)
    else:
        sig = np.array([_tsig(r) for r in rows], dtype=np.int64)
        if sid in P_FIX and len(sig) > P_FIX[sid] + 400:
            P = P_FIX[sid]
            L0 = 0 if sid == 83 else loop_start(sig, P)
            m = (sig[:len(sig) - P] == sig[P:]).mean()
        else:
            L0, P, m = find_loop(rows)
        total = L0 + P
    # silence final : dernière frame active
    act = [any(ch['on'] and ch['vol'] > 0 or ch['dd'] for ch in r[0]) for r in rows]
    last = max(i for i, a in enumerate(act) if a) if any(act) else 0
    loop = (not noloop) and m >= 0.4
    if not loop:
        total = min(len(rows), last + 30)
        if not noloop:
            # pas de boucle détectée : on boucle le morceau entier, sans coupure
            L0, P, total, m = 0, total, total, 1.0
            loop = True
    if maxframes: total = min(total, maxframes)
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
        masters.setdefault(key, dict(len=0, v=None, t0=0, t1=0))
        if len(h['v']) > masters[key]['len']:
            masters[key]['len'] = len(h['v']); masters[key]['v'] = h['v']
            masters[key]['t0'] = h['tt'][0]; masters[key]['t1'] = h['tt'][-1]
    g = 10 ** (G_PCM / 20)
    for key, mm in masters.items():
        # un octet DAC par écriture DDA ; xgm2tool déduit le débit (~1,9 kHz) et
        # rééchantillonne lui-même vers 6,65 kHz (aucune perte, contenu < 960 Hz)
        data = bytes(max(0, min(255, int(round(128 + (v - 15.5) / 15.5 * 127 * g)))) for v in mm['v'])
        mm['off'] = len(bank); bank += data
        while len(bank) % 16: bank.append(128)
    vg = Vgm()
    # --- init YM
    vg.ym(0, 0x2B, 0x80)                         # DAC on
    vg.ym(0, 0x27, 0x00)
    FMCH = [0, 1, 2, 3, 4]                       # 5 canaux FM (index 5 = canal 6 = DAC PCM)
    def fmreg(ch, reg, val):
        # index XGM2 0..4 : port = ch//3, offset = ch%3 (cf. VGMCommand.getYM2612Channel)
        vg.ym(1 if ch >= 3 else 0, reg + (ch % 3), val)
    for ch in range(5):
        c = FMCH[ch]
        for off in (0, 4, 8, 12):
            fmreg(c, 0x50 + off, 0x1F); fmreg(c, 0x60 + off, 0x00); fmreg(c, 0x70 + off, 0x00); fmreg(c, 0x80 + off, 0x0F); fmreg(c, 0x90 + off, 0x00)
            fmreg(c, 0x40 + off, 0x7F); fmreg(c, 0x30 + off, 0x01)
        fmreg(c, 0xB0, 0x07); fmreg(c, 0xB4, 0xC0)
    # attribution des canaux PCE
    fm_src = {0: 1, 1: 2, 2: 3, 3: 0, 4: 5}      # fm index -> canal PCE (5 voix mélodiques)
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
        # une écriture DAC par écriture DDA, aux instants d'origine
        n = len(h['v']); t0 = h['tt'][0]; t1 = h['tt'][-1] if n > 1 else t0 + 100
        step = (t1 - t0) / max(n - 1, 1)
        dac_events.append((t0, 'seek', mm['off']))
        for i in range(n):
            dac_events.append((t0 + i * step, 'dac', mm['off'] + i))
    if ONLY and '4' not in ONLY: dac_events = []
    if os.environ.get('NOPCM'): dac_events = []
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
                a_db = att_db(ch['vol'], ch['pan'], main) - G_FM
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
                    vg.ym(0, 0x28, c if c < 3 else c + 1)
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
        # ---- PSG ton 1 <- canal 4 (mode tonalité : ni DDA ni bruit)
        c4 = snap[4]
        tone4 = c4['on'] and c4['vol'] > 0 and c4['f'] > 0 and not (c4['noise'] & 0x80) and (not ONLY or '4' in ONLY) and not os.environ.get('NOTONE')
        psg_tone(1, c4 if tone4 else dict(on=0, vol=0, f=0, wave=[16] * 32))
        # ---- bruit <- canal 4
        naud = c4['on'] and c4['vol'] > 0 and (c4['noise'] & 0x80) and (not ONLY or '4' in ONLY) and not os.environ.get('NONOISE')
        if naud:
            nf = c4['noise'] & 31
            rate_hz = 3579545 / (64.0 * (32 - nf))
            n2 = max(1, min(1023, int(round(3579545 / (32.0 * rate_hz)))))
            # le PSG Mega Drive est filtré passe-bas (~3,4 kHz) : une horloge de bruit
            # trop élevée (55 kHz sur PCE) perd l'essentiel de sa puissance audible.
            # On plafonne l'horloge à ~11 kHz pour retrouver le niveau du bruit PCE.
            n2 = max(n2, 10)
            a_db = att_db(c4['vol'], c4['pan'], main) - G_PSG - 4.0
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
    convert(sid, out, maxframes=int(os.environ.get('MAXF', 0)) or None, noloop=(sid in (11, 17, 71, 145, 157, 163, 77)))
