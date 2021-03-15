#!/bin/sh
LINUX_HEADER="$(pwd)/include"


cpp -nostdinc -I $LINUX_HEADER -I arch -undef -x assembler-with-cpp meson-gxm-q200.dts meson-gxm-q200-mod-preprocessed.dts || exit
dtc -I dts -O dtb -p 0x1000 meson-gxm-q200-mod-preprocessed.dts -o meson-gxm-q200-mod.dtb || exit
rm meson-gxm-q200-mod-preprocessed.dts
#dtc -I dtb -O dts meson-gxm-q200-mod.dtb -o meson-gxm-q200-mod-decompiled.dts
