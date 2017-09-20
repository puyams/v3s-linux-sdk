#########################################################################
# File Name: mkjffs2.sh
# Author: Juven
# mail: yeashenlee@163.com
# Created Time: 2017年09月16日 星期六 14时28分03秒
#########################################################################
#!/bin/bash
../tools/filesystem/mkfs.jffs2 -d rootfs -l -e 0x10000 -o rootfs.jffs2
