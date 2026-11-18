#!/bin/sh
# Compile un projet SGDK (src/*.c, res/*.res) avec m68k-elf-gcc + libmd/libgcc précompilées de SGDK
# usage: mdbuild.sh <dossier_projet> [chemin_SGDK]
set -e
P=$(cd "$1" && pwd); GDK=${2:-/home/claude/work/emu/SGDK}; TC=${TC:-/home/claude/work/emu/gendev/root/opt/gendev/bin/m68k-elf-}; CC=${TC}gcc; OC=${TC}objcopy
cd "$P"; rm -rf out; mkdir -p out
INC="-I$GDK/inc -Isrc -Ires -Iout"
DEF="-DSGDK_GCC -m68000 -Wall -Wno-shift-negative-value -Wno-main -Wno-unused-parameter -fno-builtin -ffunction-sections -fdata-sections -fms-extensions -ffreestanding"
CF="$INC $DEF -O2 -fomit-frame-pointer"
AF="-x assembler-with-cpp -Wa,--register-prefix-optional,--bitwise-or $INC $DEF"
OBJS=""
for r in res/*.res; do [ -f "$r" ] || continue; b=$(basename "$r" .res)
  java -jar "$GDK/bin/rescomp.jar" "$r" "out/$b.s" 2>&1 | grep -v "^Picked up" ; mv -f "res/$b.h" out/ 2>/dev/null || true
  $CC $AF -c "out/$b.s" -o "out/$b.o"; OBJS="$OBJS out/$b.o"; done
[ -f src/rom_header.c ] || cp "$GDK/src/boot/rom_header.c" src/
$CC $INC $DEF -c src/rom_header.c -o out/rom_header.o; $OC -O binary out/rom_header.o out/rom_header.bin
cp "$GDK/src/boot/sega.s" out/sega.s; $CC $AF -c out/sega.s -o out/sega.o
for c in src/*.c; do [ "$c" = src/rom_header.c ] && continue; o=out/$(basename "$c" .c).o; $CC $CF -c "$c" -o "$o"; OBJS="$OBJS $o"; done
$CC -m68000 -n -T "$GDK/md.ld" -nostdlib -fno-lto out/sega.o $OBJS "$GDK/lib/libmd.a" "$GDK/lib/libgcc.a" -o out/rom.out -Wl,--gc-sections
$OC -O binary out/rom.out out/rom.bin
java -jar "$GDK/bin/sizebnd.jar" out/rom.bin -sizealign 131072 -checksum 2>&1 | grep -v "^Picked up" || true
ls -l out/rom.bin
