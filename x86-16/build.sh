#!/bin/sh

if [ ! -e BinOS ]
then
	mkdir BinOS
fi

if [ ! -e BinOS/FrigoOS.flp ]
then
	sudo mkdosfs -C BinOS/FrigoOS.flp 1440 || exit
fi

nasm -O0 -w+orphan-labels -f bin -o  BinOS/bootloader.bin src/Bootloader.asm || exit

nasm -O0 -w+orphan-labels -f bin -o BinOS/kernel.bin src/Kernel.asm  || exit

dd status=noxfer conv=notrunc if=BinOS/bootloader.bin of=BinOS/FrigoOS.flp || exit

cd BinOS

rm -rf tmp-loop

mkdir tmp-loop && sudo mount -o loop -t vfat FrigoOS.flp tmp-loop 
sudo cp kernel.bin tmp-loop/

sleep 0.2

sudo umount tmp-loop || exit

rm -rf tmp-loop

rm -f FrigoOS.iso
mkisofs -quiet -V 'FRIGOOS' -input-charset iso8859-1 -o FrigoOS.iso -b FrigoOS.flp ./ || exit

echo 'FrigoOS Build!'
