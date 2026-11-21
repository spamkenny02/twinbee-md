#!/bin/sh
# calibration par canal : muscal.sh <id> <canal> (nécessite dumps/songs/r<id>c<canal>.pcm)
cd /home/claude/work
MUS_ONLY=$2 python3 tools/mkmusic.py $1 md/musictest/res/s$1.vgm >/dev/null || exit 1
tools/mdbuild.sh md/musictest 2>&1 | grep -i " error"
printf "60 wav c$2\n1300 wavoff x\n1301 end\n" > /tmp/mo/t.script
tools/mdshot/mdshot emu/Genesis-Plus-GX/genesis_plus_gx_libretro.so md/musictest/out/rom.bin /tmp/mo/t.script /tmp/mo
python3 - <<P
import numpy as np
a=np.fromfile('dumps/songs/r$1c$2.pcm',dtype='<i2').reshape(-1,2).astype(float).mean(1)
b=np.fromfile('/tmp/mo/c$2.pcm',dtype='<i2').reshape(-1,2).astype(float).mean(1)
def env(x,h=441): n=len(x)//h; return np.sqrt((x[:n*h].reshape(n,h)**2).mean(1))
ea,eb=env(a),env(b); best=(-1,0)
for sh in range(0,300):
    m=min(len(ea),len(eb)-sh,900)
    c=np.corrcoef(ea[:m],eb[sh:sh+m])[0,1] if m>300 else -1
    if c>best[0]: best=(c,sh)
sh=best[1]*441; b=b[sh:]; n=min(len(a),len(b),44100*20); a=a[:n]; b=b[:n]
print('canal $2: ref rms %.0f md rms %.0f -> %.1f dB (corr env %.2f)'%(a.std(),b.std(),20*np.log10((b.std()+1)/(a.std()+1)),best[0]))
P
