#!/bin/sh

if test "`whoami`" != "root" ; then
	echo "You must be logged in as root to build (for loopback mounting)"
	echo "Enter 'su' or 'sudo bash' to switch to root"
	exit
fi

if [ ! -e BinOS ]
then
	mkdir BinOS
fi

if [ ! -e BinOS/FrigoOS.flp ]
then
	mkdosfs -C BinOS/FrigoOS.flp 1440 
fi

nasm -O0 -w+orphan-labels -f bin -o  BinOS/bootloader.bin Bootloader.asm

nasm -O0 -w+orphan-labels -f bin -o BinOS/kernel.bin Kernel.asm 

dd status=noxfer conv=notrunc if=BinOS/bootloader.bin of=BinOS/FrigoOS.flp


rm -rf BinOS/tmp-loop

mkdir BinOS/tmp-loop && mount -o loop -t vfat BinOS/FrigoOS.flp BinOS/tmp-loop && cp BinOS/kernel.bin BinOS/tmp-loop/

sleep 0.2

umount BinOS/tmp-loop 

rm -rf BinOS/tmp-loop

rm -f BinOS/FrigoOS.iso
mkisofs -quiet -V 'BESTOS' -input-charset iso8859-1 -o BinOS/FrigoOS.iso -b BinOS/FrigoOS.flp ./ 

echo '>>> Done!'