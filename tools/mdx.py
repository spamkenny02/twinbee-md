#!/usr/bin/env python3
"""Lecteur MXDRV (.MDX) : titre, voix OPM, séquences par piste -> événements (début, durée, note, volume, voix) en clocks."""
import struct, sys

VOLTAB = [0x2A, 0x28, 0x25, 0x22, 0x20, 0x1D, 0x1A, 0x18, 0x15, 0x12, 0x10, 0x0D, 0x0A, 0x08, 0x05, 0x02]

class Mdx:
    def __init__(s, path, lfo_extra=4):
        d = open(path, 'rb').read(); s.d = d
        i = d.index(b'\x0d\x0a\x1a'); s.title = d[:i]
        j = d.index(b'\x00', i + 3); s.pdx = d[i + 3:j]
        s.base = j + 1
        b = s.base
        s.voice_off = struct.unpack('>H', d[b:b + 2])[0]
        t0 = struct.unpack('>H', d[b + 2:b + 4])[0]
        n = (t0 - 2) // 2
        s.trk = [struct.unpack('>H', d[b + 2 + 2 * k:b + 4 + 2 * k])[0] for k in range(n)]
        s.lfo_extra = lfo_extra
        s.voices = s.read_voices()

    def read_voices(s):
        d = s.d; p = s.base + s.voice_off; v = {}
        # chaque voix : 1 octet n° , 1 FB/ALG... = 27 octets : n, FL/CON, SLOT mask, puis 4x(DT1/MUL), 4xTL, 4xKS/AR, 4xAME/D1R, 4xDT2/D2R, 4xD1L/RR
        while p + 27 <= len(d) and p < s.base + s.trk[0] + 0 or False:
            break
        return v

    def parse_voices(s, start):
        d = s.d; p = start; v = {}
        while p + 27 <= len(d):
            num = d[p]; fl = d[p + 1]; sm = d[p + 2]; q = d[p + 3:p + 27]
            v[num] = dict(fl=fl, slot=sm, dt1mul=list(q[0:4]), tl=list(q[4:8]), ksar=list(q[8:12]), amd1r=list(q[12:16]), dt2d2r=list(q[16:20]), d1lrr=list(q[20:24]))
            p += 27
        return v

    def track(s, k):
        """événements d'une piste : liste de (t_clock, type, ...) ; types: 'n' (t,dur,note,vol,voice), 'tempo', 'loop'"""
        d = s.d; b = s.base
        p = b + s.trk[k]; end = len(d)
        # pas de borne simple : on lit jusqu'à F1
        t = 0; ev = []; vol = 0x7F; voice = 0; tie = False; q = 8; detune = 0
        pos2t = {}
        stack = []; loop_pos = None; steps = 0
        reps = []
        while p < end and steps < 200000:
            steps += 1
            pos2t.setdefault(p, t)
            c = d[p]; p += 1
            if c < 0x80:
                t += c + 1
            elif c < 0xE0:
                ln = d[p] + 1; p += 1
                ev.append(['n', t, ln, c - 0x80, vol, voice, tie, q]); tie = False; t += ln
            else:
                if c == 0xFF: ev.append(['tempo', t, d[p]]); p += 1
                elif c == 0xFE: ev.append(['opm', t, d[p], d[p + 1]]); p += 2
                elif c == 0xFD: voice = d[p]; p += 1
                elif c == 0xFC: ev.append(['pan', t, d[p]]); p += 1
                elif c == 0xFB: vol = d[p]; p += 1
                elif c == 0xFA: vol = max(0, vol - 1) if vol < 0x80 else vol - 1   # approx
                elif c == 0xF9: vol = vol + 1
                elif c == 0xF8: q = d[p]; p += 1
                elif c == 0xF7: tie = True
                elif c == 0xF6:
                    reps.append([p + 2, d[p], 0, None]); p += 2     # [adr début boucle, compteur, itération, adr fin]
                elif c == 0xF5:
                    off = struct.unpack('>h', d[p:p + 2])[0]; p += 2
                    r = reps[-1]
                    r[2] += 1
                    if r[2] < r[1]: p = p + off   # revient au début ; off relatif à l'adresse de l'offset
                    else: reps.pop()
                elif c == 0xF4:
                    off = struct.unpack('>h', d[p:p + 2])[0]; p += 2
                    r = reps[-1]
                    if r[2] == r[1] - 1:   # dernière itération : saute après le ]
                        p = p + off + 2
                        reps.pop()
                elif c == 0xF3: detune = struct.unpack('>h', d[p:p + 2])[0]; p += 2
                elif c == 0xF2: p += 2
                elif c == 0xF1:
                    off = struct.unpack('>h', d[p:p + 2])[0] if p + 2 <= end else 0
                    if d[p] == 0 and d[p + 1] == 0: ev.append(['end', t]); break
                    ev.append(['loop', t, p + off]); break
                elif c == 0xF0: p += 1
                elif c == 0xEF: p += 1
                elif c == 0xEE: pass
                elif c == 0xED: p += 1
                elif c in (0xEC, 0xEB, 0xEA):
                    b1 = d[p]; p += 1
                    if not (b1 & 0x80): p += s.lfo_extra
                elif c == 0xE9: p += 1
                elif c == 0xE8: p += 1
                else: ev.append(['unk', t, c]); 
        s.last_t = t; s.pos2t = pos2t
        return ev
