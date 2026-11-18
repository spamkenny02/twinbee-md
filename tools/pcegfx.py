#!/usr/bin/env python3
"""pcegfx: convertit un dump pcedump (vram/sat/pal/vdcreg) en PNG : palettes, tiles, BAT complet, sprites.
usage: pcegfx.py <prefixe_dump> <dossier_sortie>"""
import sys, os, struct, json
import numpy as np
from PIL import Image

def load(prefix):
    rd=lambda ext,n: np.frombuffer(open(prefix+ext,'rb').read(),dtype='<u2')[:n].astype(np.int32)
    return rd('.vram',0x8000), rd('.sat',256), rd('.pal',512), rd('.vdcreg',20)

def rgb(pal):  # 9 bits GRB -> RGB888
    g=(pal>>6)&7; r=(pal>>3)&7; b=pal&7
    return np.stack([r,g,b],-1)*255//7

def tiles8(vram):  # -> (2048,8,8) index 0..15
    w=vram.reshape(2048,16)
    lo=w[:,:8]; hi=w[:,8:]
    bits=np.arange(7,-1,-1)
    p0=(lo[:,:,None]>>bits)&1; p1=(lo[:,:,None]>>(bits+8))&1
    p2=(hi[:,:,None]>>bits)&1; p3=(hi[:,:,None]>>(bits+8))&1
    return p0|(p1<<1)|(p2<<2)|(p3<<3)

def spr16(vram):  # -> (512,16,16)
    w=vram.reshape(512,4,16)
    bits=np.arange(15,-1,-1)
    px=(w[:,:,:,None]>>bits)&1
    return px[:,0]|(px[:,1]<<1)|(px[:,2]<<2)|(px[:,3]<<3)

def main(prefix,out):
    os.makedirs(out,exist_ok=True)
    vram,sat,pal,reg=load(prefix)
    col=rgb(pal).astype(np.uint8)
    info={}
    # palettes
    im=np.zeros((32,16,3),np.uint8); im[:]=col.reshape(32,16,3)
    Image.fromarray(im).resize((16*12,32*12),Image.NEAREST).save(out+'/palettes.png')
    # BAT
    mwr=reg[9]; bw=[32,64,128,128][(mwr>>4)&3]; bh=64 if mwr&0x40 else 32
    bat=vram[:bw*bh].reshape(bh,bw); tidx=bat&0xFFF; tpal=bat>>12
    t8=tiles8(vram)
    px=t8[tidx&0x7FF]                       # (bh,bw,8,8)
    full=(tpal[:,:,None,None]*16+px).transpose(0,2,1,3).reshape(bh*8,bw*8)
    Image.fromarray(col[full]).save(out+'/bat.png')
    info.update(bat_w=bw,bat_h=bh,bxr=int(reg[7]),byr=int(reg[8]),cr=int(reg[5]),
                bg_palettes_used=sorted(set(tpal.flatten().tolist())),
                bg_tiles_used=int(len(set((tidx&0x7FF).flatten().tolist()))))
    # planche de tiles bruts (palette = celle la plus utilisée par le BAT pour ce tile, sinon 0)
    best=np.zeros(2048,int)
    for t,p in zip(tidx.flatten()&0x7FF,tpal.flatten()): best[t]=p
    sheet=(best[:,None,None]*16+t8).reshape(32,64,8,8).transpose(0,2,1,3).reshape(256,512)
    Image.fromarray(col[sheet]).resize((1024,512),Image.NEAREST).save(out+'/vram_tiles8.png')
    s16=spr16(vram)
    sheet=(256+s16).reshape(16,32,16,16).transpose(0,2,1,3).reshape(256,512)
    Image.fromarray(col[sheet]).resize((1024,512),Image.NEAREST).save(out+'/vram_spr16_pal0.png')
    # sprites du SAT
    sprs=[]; canvas=np.zeros((1024,1024,4),np.uint8)
    for i in range(63,-1,-1):
        y,x,pat,at=sat[i*4:i*4+4]
        y=(y&0x3FF); x=(x&0x3FF)
        cgx=(at>>8)&1; cgy=(at>>12)&3; cgy=3 if cgy==2 else cgy
        w=32 if cgx else 16; h=[16,32,64,64][cgy]
        base=(pat>>1)&0x3FF
        if cgx: base&=~1
        if cgy>=1: base&=~2
        if cgy==3: base&=~4
        p=at&15
        img=np.zeros((h,w),int)
        for cy in range(h//16):
            for cx in range(w//16):
                img[cy*16:cy*16+16,cx*16:cx*16+16]=s16[(base+cy*2+cx)&511]
        if at&0x800: img=img[:,::-1]
        if at&0x8000: img=img[::-1]
        if not img.any(): continue
        rgba=np.dstack([col[256+p*16+img],(img>0).astype(np.uint8)*255])
        sprs.append(dict(i=i,x=int(x)-32,y=int(y)-64,w=w,h=h,pattern=int(base),pal=int(p),xflip=bool(at&0x800),yflip=bool(at&0x8000),prio=bool(at&0x80)))
        if x+w<=1024 and y+h<=1024:
            m=rgba[:,:,3]>0; canvas[y:y+h,x:x+w][m]=rgba[m]
    Image.fromarray(canvas[64:64+242,32:32+256]).save(out+'/sprites_screen.png')
    info['sprites']=sprs[::-1]; info['spr_palettes_used']=sorted({s['pal'] for s in sprs})
    json.dump(info,open(out+'/info.json','w'),indent=1)
    print(prefix,'BAT %dx%d'%(bw,bh),'pal BG',info['bg_palettes_used'],'pal SPR',info['spr_palettes_used'],'tiles BG',info['bg_tiles_used'],'sprites',len(sprs))

if __name__=='__main__': main(sys.argv[1],sys.argv[2])
