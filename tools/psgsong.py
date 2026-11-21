"""Reconstruit des trames par frame depuis un journal .psg : par canal (on, freq, vol, wave_id, noise) + évènements DDA."""
import sys; sys.path.insert(0,'/home/claude/work/tools')
from psgw import *
import numpy as np
def build(path,f0=700):
    fr=load_writes(path); s=PSG(); waves={}; rows=[]; dda=[]
    for f,c,w in fr:
        ev=[]
        for k,(cc,a,v) in enumerate(w):
            s.write(a,v)
            if a==6 and (s.ctl[s.sel]&0x40) and s.sel==4: ev.append((k,len(w),s.dda[4]))
        if f<f0: continue
        row=[]
        for c in range(6):
            wb=bytes(s.wave[c]); wid=waves.setdefault(wb,len(waves))
            on=1 if (s.ctl[c]&0x80) and not (s.ctl[c]&0x40) else 0
            row.append((on,s.freq[c],s.ctl[c]&0x1f,s.pan[c],wid,s.noise[c]))
        rows.append((tuple(row),s.main,ev))
        dda.append(ev)
    return rows,waves
def key(r): return r[0]  # rows
def loop_len(rows,minl=300):
    sig=[hash((r[0],r[1])) for r in rows]
    n=len(sig); best=None
    for L in range(minl,n//2):
        # fraction de frames égales
        a=sig[:n-L]; b=sig[L:]
        m=sum(1 for x,y in zip(a,b) if x==y)/(n-L)
        if best is None or m>best[1]: best=(L,m)
    return best
