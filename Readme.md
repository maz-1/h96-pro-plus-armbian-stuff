Get armbian working on my h96 pro plus tv box (green pcb ver)

## Hardware Specs:

 * soc: amlogic s912
 * memory: 3gb ddr4
 * ethernet: RTL8211F
 * wifi: Fn-link 8223A-SR (QCA9377)
 

## Fix Wifi/Bluetooth/HDMI Audio:

With `meson-gxm-q200.dtb` included in armbian we can boot armbian just ok but there is no wifi/bluetooth/hdmi audio, so I created meson-gxm-q200-mod.dtb that fixes these problems.<br/>
Source code can be found in `amlogic_dts/`, run `build.sh` to build dtb file. The actual modification can be viewed in `amlogic_dts/h96_pro_plus.patch`.<br/>
Also we need some firmware that exists in mainline linux firmware repo but ignored by armbian build system. copy `lib-firmware/*` to `<ARMBIAN_ROOT>/lib/firmware/`.

## What works and what does't:

### Working:
 * Wifi
 * Ethernet
 * Bluetooth
 * HDMI
 * HDMI Audio & SPDIF
 * IR Remote
 * OpenGL & Hardware Video Decoding

### Not Tested:
 * AV Out

## Known Problems:

OpenGL can be enabled via `Panfrost`. Hardware video decoding is available if firmware in `lib-firmware/meson/vdec` are present. However there are some tearing while playing videos, not sure if it is a problem with panfrost or x11 settings.

