import sys,glob,os
from PIL import Image
for d in sys.argv[1:]:
    for r in sorted(glob.glob(d+'/*.rgba')):
        meta=dict(l.split(None,1) for l in open(r[:-5]+'.txt'))
        w,h=int(meta['width']),int(meta['height'])
        Image.frombytes('RGBA',(w,h),open(r,'rb').read()).convert('RGB').save(r[:-5]+'.png')
