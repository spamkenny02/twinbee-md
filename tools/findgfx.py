# cherche les tiles/sprites présents en VRAM tels quels dans la ROM (graphismes non compressés ?)
import sys, collections, glob
rom=open(sys.argv[1],'rb').read()
for v in sys.argv[2:]:
    vram=open(v,'rb').read()
    hit=collections.Counter(); tot=0; found=0
    for t in range(0x40,2048):            # après la zone BAT 64x64 = $1000 mots
        if t<0x100: continue
        b=vram[t*32:t*32+32]
        if len(set(b))<4: continue
        tot+=1; i=rom.find(b)
        if i>=0: found+=1; hit[i>>13]+=1
    print(v,'tiles non vides: %d, trouvés tels quels en ROM: %d (%.0f%%)'%(tot,found,100*found/max(tot,1)))
    print('   banques:',' '.join('%02X:%d'%(b,c) for b,c in sorted(hit.items())))
