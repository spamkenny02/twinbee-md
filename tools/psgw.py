"""Lecture du journal PSG (.psg) produit par pcedump psglog : écritures exactes + instantané par frame."""
import struct, numpy as np
def load_writes(path):
    d=open(path,'rb').read(); o=0; frames=[]
    while o+12<=len(d):
        f,cyc,nb=struct.unpack_from('<III',d,o); o+=12
        # derniere frame possiblement tronquee (psgoff au milieu d'une frame) : l'ignorer
        if o+6*nb>len(d): break
        w=[]
        for i in range(nb):
            c,a,v=struct.unpack_from('<IBB',d,o+6*i); w.append((c,a&15,v))
        o+=6*nb
        if o+246>len(d): break
        o+=246
        frames.append((f,cyc,w))
    return frames
def load_frames(path):
    """Comme load_writes mais renvoie aussi l'instantané complet de fin de frame.

    Chaque frame : dict(f, cyc, w, main, lfo, ch[6]) avec pour chaque canal
    freq, ctl, volL, volR, noise, dda, dda_en, wave[32].
    """
    d = open(path, 'rb').read(); o = 0; frames = []
    while o + 12 <= len(d):
        f, cyc, nb = struct.unpack_from('<III', d, o); o += 12
        if o + 6 * nb > len(d): break
        w = []
        for i in range(nb):
            c, a, v = struct.unpack_from('<IBB', d, o + 6 * i); w.append((c, a & 15, v))
        o += 6 * nb
        if o + 246 > len(d): break
        s = d[o:o + 246]; o += 246
        ch = []
        for c in range(6):
            r = s[6 + c * 40:6 + c * 40 + 8]
            ch.append(dict(freq=r[0] | (r[1] << 8), ctl=r[2], volL=r[3], volR=r[4],
                           noise=r[5], dda=r[6], dda_en=r[7],
                           wave=list(s[6 + c * 40 + 8:6 + c * 40 + 40])))
        frames.append(dict(f=f, cyc=cyc, w=w, main=s[4], lfo=s[5], ch=ch))
    return frames

class PSG:
    def __init__(s):
        s.sel=0; s.freq=[0]*6; s.ctl=[0]*6; s.pan=[0]*6; s.noise=[0]*6; s.wave=[[0]*32 for _ in range(6)]; s.widx=[0]*6; s.main=0; s.lfof=0; s.lfoc=0; s.dda=[0]*6
    def write(s,a,v,ev=None):
        c=s.sel
        if a==0: s.sel=v&7
        elif a==1: s.main=v
        elif a==2 and c<6: s.freq[c]=(s.freq[c]&0xF00)|v
        elif a==3 and c<6: s.freq[c]=(s.freq[c]&0xFF)|((v&15)<<8)
        elif a==4 and c<6:
            if (s.ctl[c]&0x40) and not (v&0x40): s.widx[c]=0
            s.ctl[c]=v
        elif a==5 and c<6: s.pan[c]=v
        elif a==6 and c<6:
            if s.ctl[c]&0x40: s.dda[c]=v&31
            elif not (s.ctl[c]&0x80):
                s.wave[c][s.widx[c]]=v&31; s.widx[c]=(s.widx[c]+1)&31
            else: pass
        elif a==7 and c<6: s.noise[c]=v
        elif a==8: s.lfof=(s.lfof&0xF00)|v
        elif a==9: s.lfoc=v
