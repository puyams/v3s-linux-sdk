# toolschain
export PATH="$PATH:/sdk_path/tools/external-toolchain/bin/"

# build u-boot

cd u-boot

sudo apt-get install device-tree-compiler

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LicheePi_Zero_defconfig

make ARCH=arm menuconfig

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

cp u-boot-sunxi-with-spl.bin ../pub/boot

# build Kernel

cd linux-3.4

make ARCH=arm sun8iw8p1smp_zero_diy_defconfig

make ARCH=arm menuconfig

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- uImage -j16

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j16 INSTALL_MOD_PATH=out modules

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j16 INSTALL_MOD_PATH=out modules_install

cp arch/arm/boot/uImage ../pub/boot

cp out/lib ../buildroot-2017.08/board/sunxi/rootfs-overlay -rf

# build sunxi-tools

cd tool/sunxi-tools

make

# build preboot-config

cd preboot-config

mkimage -C none -A arm -T script -d boot.cmd ../pub/boot/boot.scr

../tools/sunxi-tools/fex2bin sys_config.fex > ../pub/boot/script.bin

# buidl rootfs

cd buildroot-2017.08

make sunxi_v3s_zero_defconfig

make menuconfig

make

cp -rf output/target/* ../pub/rootfs

# build rootfs.jffs2

cd pub/

../tools/filesystem/mkfs.jffs2 -d rootfs -l -e 0x10000 -o rootfs.jffs2

# Boot

## SD card boot
cd pub

cp boot.scr script.bin uImage your_sdcard_1st_partion

sudo cp rootfs/* your_sdcard_2st_partion

## Nor Spi Flash Boot
# burning uboot
load mmc 0:1 0x41000000 u-boot-sunxi-with-spl.bin;sf probe 0;sf erase 0 0x80000;sf write 0x41000000 0 0x80000

# burning script.bin
load mmc 0:1 0x41000000 script.bin;sf probe 0;sf erase 0x80000 0x80000;sf write 0x41000000 0x80000 0x80000

# burning kernel
load mmc 0:1 0x41000000 uImage;sf probe 0;sf erase 0x100000 0x300000;sf write 0x41000000 0x100000 0x300000

# burning rootfs
load mmc 0:1 0x41000000 rootfs.jffs2;sf probe 0;sf erase 0x400000 0xC00000;sf write 0x41000000 0x400000 0xxx(rootfs.jff2实际大小)



