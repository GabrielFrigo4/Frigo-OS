#!/bin/sh

if [ ! -e BinOS ]
then
	mkdir BinOS
fi

if test "`whoami`" != "root" ; then
	echo "You must be logged in as root to build (for loopback mounting)"
	echo "Enter 'su' or 'sudo bash' to switch to root"
	exit
fi

if [ ! -e BinOS/FrigoOS.flp ]
then
	mkdosfs -C BinOS/FrigoOS.flp 1440 || exit
fi

nasm -O0 -w+orphan-labels -f bin -o  BinOS/bootloader.bin src/Bootloader.asm || exit

nasm -O0 -w+orphan-labels -f bin -o BinOS/kernel.bin src/Kernel.asm  || exit

dd status=noxfer conv=notrunc if=BinOS/bootloader.bin of=BinOS/FrigoOS.flp || exit

cd BinOS

rm -rf tmp-loop

mkdir tmp-loop && mount -o loop -t vfat FrigoOS.flp tmp-loop && cp kernel.bin tmp-loop/

sleep 0.2

umount tmp-loop || exit

rm -rf tmp-loop

rm -f FrigoOS.iso
mkisofs -quiet -V 'FRIGOOS' -input-charset iso8859-1 -o FrigoOS.iso -b FrigoOS.flp ./ || exit

qemu-system-i386 -fda FrigoOS.flp

echo '>>> Done!'
