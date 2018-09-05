#!/bin/bash

echo "

http://10.84.172.107
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/testing
" >> /etc/apk/repositories

apk del chrony
apk del chronyd

setup-alpine -c /install/answer-file.txt

apk update

apk add openntpd opennode acct e2fsprogs

mount /dev/mmcblk0p2 /mnt

setup-disk -m sys /mnt

mount -o remount,rw /dev/mmcblk0p1

rm -f /media/mmcblk0p1/boot/*  

cd /mnt
rm boot/boot

mv boot/* /media/mmcblk0p1/boot/  

rm -Rf boot

mkdir media/mmcblk0p1

ln -s media/mmcblk0p1/boot boot

echo "/dev/mmcblk0p1 /media/mmcblk0p1 vfat defaults 0 0" >> etc/fstab

cd /media/mmcblk0p1

sed -i 's/^/root=\/dev\/mmcblk0p3 /' cmdline.txt  