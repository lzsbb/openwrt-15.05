#!/bin/sh

adb devices | grep -v "List of devices attached" | grep -v grep | sed -e 's/\t//g;s/device//g;s/ //g;/^$/d' > /tmp/adbtmp.devices.list
adblist="/tmp/adbtmp.devices.list"

while read LINE
do
	adb -s $LINE tcpip 5555 &
	sleep 3
	kill -9 $(ps | grep -i adb  | grep "tcpip 5555" | grep -v grep | cut -d 'r' -f 1)  > /dev/null 2>&1
	kill -9 $(ps | grep -i adb  | grep "tcpip 5555" | grep -v grep | cut -d ' ' -f 1)  > /dev/null 2>&1
done < $adblist

rm /tmp/adbtmp.devices.list
