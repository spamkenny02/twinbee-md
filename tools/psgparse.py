import numpy as np
def load(p):
    d=np.fromfile(p,dtype=np.uint8).reshape(-1,246)
    n=len(d)
    fr=d[:,0:4].copy().view('<u4')[:,0]
    ch=d[:,6:].reshape(n,6,40)
    freq=ch[:,:,0].astype(int)|(ch[:,:,1].astype(int)<<8)
    ctl=ch[:,:,2]; vl=ch[:,:,3]; vr=ch[:,:,4]; noise=ch[:,:,5]; dda=ch[:,:,6]; ddae=ch[:,:,7]
    wave=ch[:,:,8:]
    return dict(n=n,fr=fr,main=d[:,4],lfo=d[:,5],freq=freq,ctl=ctl,vl=vl,vr=vr,noise=noise,dda=dda,ddae=ddae,wave=wave)
