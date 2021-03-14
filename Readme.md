Get armbian working on my h96 pro plus tv box (green pcb ver)

### Hardware Specs:

 * soc: amlogic s912
 * memory: 3gb ddr4
 * ethernet: RTL8211F
 * wifi: Fn-link 8223A-SR (QCA9377)
 

### Fix Wifi and Bluetooth:

With meson-gxm-q200.dtb included in armbian you can boot armbian just ok but there is no wifi/bluetooth, so I created meson-gxm-q200-mod.dtb that supports qca9377.
Compilable source code can be found in `amlogic_dts`. The actual modification can be seen in `amlogic_dts/qca9377_diff.patch`.
Also we need some firmware that exists in mainline linux but ignored by armbian build. copy `lib-firmware/*` to `/lib/firmware/` .

### Known Problems:

There are still some problems: no gpu acceleration, no hdmi audio. But it is enough to be used as a headless server.

### Convert EMMC Root Filesystem From Ext4 to Btrfs

 * Boot to usb drive or sd card with armbian installed
 * Convert root filesystem
   - `# btrfs-convert /dev/mmcblk1p2`
 * Mount emmc boot and root 
   - `# mkdir /tmp/boot`
   - `# mount /dev/mmcblk1p1 /tmp/boot`
   - `# mkdir /tmp/root`
   - `# mount /dev/mmcblk1p2 /tmp/root`
 * open `/tmp/boot/extlinux/extlinux.conf` in vim/nano and remove `data=writeback` from rootflags. After Editing the file should look like this:
```
LABEL Armbian
LINUX /zImage
INITRD /uInitrd
FDT /dtb/amlogic/meson-gxm-q200-mod.dtb
APPEND root=LABEL=ROOT_EMMC rootflags=rw console=ttyAML0,115200n8 console=tty0 no_console_suspend consoleblank=0 fsck.fix=yes fsck.repair=yes net.ifnames=0
```
 * open `/tmp/root/etc/fstab` in vim/nano and modify root filesystem type. After Editing the file should look like this:
```
#/var/swap none swap sw 0 0
#/dev/root      /               auto            noatime,errors=remount-ro       0 1
#proc           /proc           proc            defaults                                0 0
#/dev/root      /               ext4            defaults,noatime,errors=remount-ro      0 1
/dev/root      /               btrfs            rw,relatime,compress=zstd,space_cache   0 1
tmpfs           /tmp            tmpfs           defaults,nosuid                         0 0
LABEL=BOOT_EMMC /boot           vfat            defaults                                0 2
```
