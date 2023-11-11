#!/bin/sh
./build.sh
echo 'FrigoOS Run!'
qemu-system-i386 -fda BinOS/FrigoOS.flp
./trash.sh
