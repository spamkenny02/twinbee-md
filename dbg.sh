#!/bin/sh
# usage: dbg.sh  -> build + run m7.script, print whether crashed (address error text in h900)
cd /home/claude/work
tools/mdbuild.sh md/twinbee 2>&1 | grep " error"
rm -f m2/h*.ppm
timeout 500 tools/mdshot/mdshot emu/Genesis-Plus-GX/genesis_plus_gx_libretro.so md/twinbee/out/rom.bin ${1:-m7.script} m2
python3 - <<'PY'
from PIL import Image
im=Image.open('/home/claude/work/m2/h900.ppm').convert('RGB')
# l'écran d'erreur a un fond noir et du texte jaune/cyan en haut à gauche
print('ERR?', im.getpixel((20,8)), sum(1 for x in range(0,120) for y in range(0,12) if im.getpixel((x,y))[0]>200 and im.getpixel((x,y))[2]<100))
PY
