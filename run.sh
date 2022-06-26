#!/bin/sh

sudo ./build.sh

qemu-system-i386 -fda BinOS/FrigoOS.flp

echo '>>> Done!'
