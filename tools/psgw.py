"""Lecture du journal PSG (.psg) produit par pcedump psglog : écritures exactes + instantané par frame."""
import struct, numpy as np
def load_writes(path):
    d=open(path,'rb').read(); o=0; frames=[]
    while o+12<=len(d):
        f,cyc,nb=struct.unpack_from('<III',d,o); o+=12
        w=[]
        for i in range(nb):
            c,a,v=struct.unpack_from('<IBB',d,o+6*i); w.append((c,a&15,v))
        o+=6*nb
        if o+246>len(d): break
        o+=246
        frames.append((f,cyc,w))
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
