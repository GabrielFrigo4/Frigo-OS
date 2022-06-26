#!/bin/sh

./build.sh

echo '>>> Run!'

qemu-system-i386 -fda BinOS/FrigoOS.flp