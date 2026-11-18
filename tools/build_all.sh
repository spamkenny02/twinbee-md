#!/bin/sh
# Chaîne complète : ressources, données des stages, compilation (les extractions lourdes sont déjà faites)
set -e
cd /home/claude/work
python3 tools/mkassets.py > /dev/null
python3 tools/mkstageN.py 2 dumps/s2i/s2t.trace 25000 25541 37667 4304 > /dev/null
python3 tools/mkstageN.py 3 dumps/s3i/s3i.trace 47000 48142 63226 5216 > /dev/null
python3 tools/mkstageN.py 4 dumps/s4i/s4i.trace 72000 72663 91682 6512 > /dev/null
python3 tools/mkenemiesN.py 2 extract/s2_inst.pkl extract/ebul2.pkl dumps/s2d 25541 37700 16 27 > /dev/null
python3 tools/mkenemiesN.py 3 extract/s3_inst.pkl extract/ebul3.pkl dumps/s3s 48142 63226 3 38 > /dev/null
python3 tools/mkenemiesN.py 4 extract/s4_inst.pkl extract/ebul4.pkl dumps/s3s 72663 90600 39 47 > /dev/null
tools/mdbuild.sh md/twinbee 2>&1 | grep -i "error\|warning" || true
ls -la md/twinbee/out/rom.bin
