setenv bootargs console=ttyS0,115200 panic=5 rootwait root=/dev/mmcblk0p2 earlyprintk rw
setenv bootm_boot_mode sec
setenv machid 1029
load mmc 0:1 0x41000000 uImage
load mmc 0:1 0x41d00000 script.bin
bootm 0x41000000
