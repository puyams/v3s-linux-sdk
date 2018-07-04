#########################################################################
# File Name: led.sh
# Author: Juven
# mail: yeashenlee@163.com
# Created Time: 2018年07月04日 星期三 11时49分17秒
#########################################################################
#!/bin/bash

# gpio_num = (7-1)*32+num
# EX. PG0 is (7-1)*32+0=192
# when gpio set 0, led turn on; set 1, led turn off
# PG0->green, PG1->blue, PG2->red

GPIOPATH=/sys/class/gpio
echo 192 > $GPIOPATH/export
echo 193 > $GPIOPATH/export
echo 194 > $GPIOPATH/export

echo "out" >$GPIOPATH/gpio192/direction 
echo "out" >$GPIOPATH/gpio193/direction 
echo "out" >$GPIOPATH/gpio194/direction 

num=1
while true
do
	case $num in
		1)
		echo 0 > $GPIOPATH/gpio192/value
		sleep 0.1
		echo 1 > $GPIOPATH/gpio192/value
		echo 1 > $GPIOPATH/gpio193/value
		echo 1 > $GPIOPATH/gpio194/value;;
		2)
		echo 1 > $GPIOPATH/gpio192/value
		echo 0 > $GPIOPATH/gpio193/value
		sleep 0.1
		echo 1 > $GPIOPATH/gpio193/value
		echo 1 > $GPIOPATH/gpio194/value;;
		3)
		echo 1 > $GPIOPATH/gpio192/value
		echo 1 > $GPIOPATH/gpio193/value
		echo 0 > $GPIOPATH/gpio194/value
		sleep 0.1
		echo 1 > $GPIOPATH/gpio194/value;;
	esac
	if [ $num -eq 3 ]
	then
		num=0
	fi
	num=`expr $num + 1`
	sleep 1
done
