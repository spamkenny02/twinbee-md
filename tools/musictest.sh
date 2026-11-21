#!/bin/sh
# usage: musictest.sh <id> <resnom> [frames]  -> convertit, compile le banc musictest, rend l'audio MD et compare au PCE (dumps/songs/r<id>.pcm)
cd /home/claude/work
python3 tools/mkmusic.py $1 md/musictest/res/s$1.vgm || exit 1
echo "XGM2 mus$1 \"s$1.vgm\"" > md/musictest/res/music.res
sed -i "s/XGM2_play(mus[0-9]*)/XGM2_play(mus$1)/" md/musictest/src/main.c
tools/mdbuild.sh md/musictest 2>&1 | grep -i " error" 
printf "60 wav t$1\n${3:-2500} wavoff x\n$(( ${3:-2500}+1 )) end\n" > /tmp/mo/t.script
tools/mdshot/mdshot emu/Genesis-Plus-GX/genesis_plus_gx_libretro.so md/musictest/out/rom.bin /tmp/mo/t.script /tmp/mo
python3 tools/cmpaudio.py dumps/songs/r$1.pcm /tmp/mo/t$1.pcm /tmp/cmp$1.png
