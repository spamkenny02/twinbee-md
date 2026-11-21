#!/usr/bin/env python3
"""mksfx.py : rendus PCE (dumps/sfx/x<id>.pcm, s16 stéréo 44.1k) -> WAV mono 13300 Hz recadrés dans md/twinbee/res/sfx/ ; écrit res/sfx.res"""
import numpy as np, os, wave, sys
SRC='/home/claude/work/dumps/sfx'; DST='/home/claude/work/md/twinbee/res/sfx'
os.makedirs(DST,exist_ok=True)
IDS=[int(a) for a in sys.argv[1:]] or list(range(1,65))
MAXS=float(os.environ.get('SFX_MAX','1.6'))    # durée max (s)
lines=[]; info=[]
for i in IDS:
    p=f'{SRC}/x{i}.pcm'
    if not os.path.exists(p): continue
    a=np.fromfile(p,dtype='<i2').reshape(-1,2).astype(float).mean(1)
    a-=np.median(a)
    thr=max(300,np.abs(a).max()*0.03)
    nz=np.flatnonzero(np.abs(a)>thr)
    if len(nz)<200: continue
    s,e=nz[0],nz[-1]
    a=a[max(0,s-50):e+1][:int(MAXS*44100)]
    # sous-échantillonnage 44100 -> 13300 (filtre moyenne simple + interpolation linéaire)
    n=int(len(a)*13300/44100); idx=np.linspace(0,len(a)-1,n)
    k=np.ones(3)/3; af=np.convolve(a,k,mode='same')
    b=np.interp(idx,np.arange(len(a)),af)
    pk=np.abs(b).max()
    b=b/32768.0
    g=min(1.0,0.9/ max(np.abs(b).max(),1e-3)) if pk<4000 else 1.0
    b=np.clip(b*g*2.0,-1,1)      # +6 dB : les effets sont bien plus faibles que la musique
    w=wave.open(f'{DST}/s{i}.wav','wb'); w.setnchannels(1); w.setsampwidth(2); w.setframerate(13300)
    w.writeframes((b*32767).astype('<i2').tobytes()); w.close()
    lines.append(f'WAV sfx_{i:02X} "sfx/s{i}.wav" XGM2 13300')
    info.append((i,round(n/13300,2),int(pk)))
open('/home/claude/work/md/twinbee/res/sfx.res','w').write('\n'.join(lines)+'\n')
print(len(lines),'effets');print(info)
