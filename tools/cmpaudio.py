"""cmpaudio.py ref.pcm md.pcm out.png : compare 2 captures s16 stéréo 44.1k (spectrogrammes, niveau, spectre moyen)"""
import sys, numpy as np
from PIL import Image
a=np.fromfile(sys.argv[1],dtype='<i2').reshape(-1,2).astype(float).mean(1)
b=np.fromfile(sys.argv[2],dtype='<i2').reshape(-1,2).astype(float).mean(1)
def env(x,h=441): 
    n=len(x)//h; return np.sqrt((x[:n*h].reshape(n,h)**2).mean(1))
ea,eb=env(a),env(b)
# alignement par corrélation des enveloppes (100 pas/s)
best=(-1,0)
for sh in range(0,300):
    m=min(len(ea),len(eb)-sh,1500)
    if m<500: break
    c=np.corrcoef(ea[:m],eb[sh:sh+m])[0,1]
    if c>best[0]: best=(c,sh)
print('alignement MD décalé de %d x10ms, corr %.3f'%(best[1],best[0]))
sh=best[1]*441; b=b[sh:]
n=min(len(a),len(b),44100*40); a=a[:n]; b=b[:n]
print('RMS ref %.0f md %.0f ratio %.2f dB'%(a.std(),b.std(),20*np.log10(b.std()/a.std())))
def spec(x,bands=[(30,80),(80,200),(200,500),(500,1200),(1200,3000),(3000,8000),(8000,20000)]):
    S=np.abs(np.fft.rfft(x*np.hanning(len(x))))**2; f=np.fft.rfftfreq(len(x),1/44100)
    return [10*np.log10(S[(f>=lo)&(f<hi)].sum()+1) for lo,hi in bands]
sa,sb=spec(a),spec(b)
print('bandes (dB) ref',np.round(sa,1)); print('bandes (dB) md ',np.round(sb,1)); print('diff', np.round(np.array(sb)-np.array(sa),1))
def sg(x,w=2048,h=1024,fmax=4000):
    fr=[np.abs(np.fft.rfft(x[i:i+w]*np.hanning(w)))[: int(fmax/44100*w)] for i in range(0,len(x)-w,h)]
    m=np.log10(np.array(fr).T+1)
    m=(m-m.min())/(m.max()-m.min()); return (255*m[::-1]).astype(np.uint8)
ga,gb=sg(a[:44100*20]),sg(b[:44100*20])
img=np.vstack([ga,np.full((4,ga.shape[1]),255,np.uint8),gb])
Image.fromarray(img).resize((min(img.shape[1],1400),img.shape[0]*2)).save(sys.argv[3])
