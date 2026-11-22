#!/bin/sh
# Chaîne complète : ressources, données des stages, compilation (les extractions lourdes sont déjà faites)
set -e
cd /home/claude/work
# boss 2 (données déjà générées, lourd) : python3 tools/mkboss2.py atlas && python3 tools/mkboss2pal.py extract/boss2_atlas.npy extract/boss2_md && python3 tools/mkboss2data.py && cp extract/boss2_md.png md/twinbee/res/boss2.png
# boss 3-6 (données déjà générées ; régénération, nécessite dumps/) :
# python3 tools/mkbossN.py 3 dumps/s3i/s3i.trace 47000 63229 71842 dumps/s3/u66000 228,229,240,241,272,276,296,298,360,362,364,368,369,376,380,382
# PAL2=1 python3 tools/mkbossN.py 4 dumps/s4i/s4i.trace 72000 82900 91268 dumps/s3/u87000 284,285,286,288,296,304,308,312,316,352,360,362,364,366,368,376,377,378,380,382
# PAL2=1 python3 tools/mkbossN.py 5 dumps/s5/s5.trace 92000 101380 112640 dumps/s5/u106000 256,260,264,272,276,288,292,296,298,301,304,308,312,316,360,368
# PAL2=1 python3 tools/mkbossN.py 6 dumps/s4i/s4i.trace 72000 122273 130400 dumps/s5/u123000 285,287,288,296,304,312,336,352,353,355,357,361,368,376,380
python3 tools/mkassets.py > /dev/null
python3 tools/mkstageN.py 2 dumps/s2i/s2t.trace 25000 25541 37667 4304 > /dev/null
python3 tools/mkstageN.py 3 dumps/s3i/s3i.trace 47000 48142 63226 5216 > /dev/null
python3 tools/mkstageN.py 4 dumps/s4i/s4i.trace 72000 72663 91682 6512 > /dev/null
python3 tools/mkstageN.py 5 dumps/s5/s5.trace 92000 92067 112946 7152 > /dev/null
python3 tools/mkstageN.py 6 dumps/s5/s5.trace 92000 113337 122656 3296 > /dev/null
python3 tools/mkenemiesN.py 2 extract/s2f_inst.pkl extract/ebul2f.pkl dumps/s2d 25541 47754 2 28 > /dev/null
python3 tools/mkenemiesN.py 3 extract/s3_inst.pkl extract/ebul3.pkl dumps/s3s 48142 63226 3 38 > /dev/null
python3 tools/mkenemiesN.py 4 extract/s4_inst.pkl extract/ebul4.pkl dumps/s3s 72663 90600 39 47 > /dev/null
python3 tools/mkenemiesN.py 5 extract/s5_inst.pkl extract/ebul5.pkl dumps/s5s 92067 112946 48 58 > /dev/null
python3 tools/mkenemiesN.py 6 extract/s6_inst.pkl extract/ebul6.pkl dumps/s5s 113337 122656 60 76 > /dev/null
python3 tools/lzspack.py md/twinbee/src/boss3_data.h md/twinbee/src/boss4_data.h md/twinbee/src/boss5_data.h md/twinbee/src/boss6_data.h md/twinbee/src/end_sprd.h
python3 tools/rapack.py md/twinbee/src/stage2_enemies.h md/twinbee/src/stage3_enemies.h md/twinbee/src/stage4_enemies.h md/twinbee/src/stage5_enemies.h md/twinbee/src/stage6_enemies.h
tools/mdbuild.sh md/twinbee 2>&1 | grep -i "error\|warning" || true
ls -la md/twinbee/out/rom.bin
