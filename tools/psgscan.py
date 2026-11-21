import sys; sys.path.insert(0,'/home/claude/work/tools')
from psgw import *
import numpy as np
def analyze(path,f0=700):
    fr=load_writes(path); s=PSG(); out=[]
    for f,c,w in fr:
        for cc,a,v in w: s.write(a,v)
        act=[ (s.ctl[k]&0x80) and (s.ctl[k]&0x1f)>0 and (s.pan[k]!=0) for k in range(6)]
        out.append((f,act,[s.ctl[k]&0x40 for k in range(6)]))
    return out
if __name__=='__main__':
    for i in range(1,170):
        try: o=analyze(f'i{i}.psg')
        except Exception as e: continue
        a=[(f,act,dd) for f,act,dd in o if f>=700]
        if not a: continue
        on=[f for f,act,dd in a if any(act)]
        chs=sorted({k for f,act,dd in a for k in range(6) if act[k]})
        dda=sorted({k for f,act,dd in a for k in range(6) if dd[k]})
        print(i, (on[0],on[-1],len(on)) if on else None, chs, dda)
