mkdir BinOS

wsl mkdosfs -C BinOS/FrigoOS.flp 1440
nasm -O0 -w+orphan-labels -f bin -o  BinOS/bootloader.bin src/Bootloader.asm
nasm -O0 -w+orphan-labels -f bin -o BinOS/kernel.bin src/Kernel.asm
wsl dd status=noxfer conv=notrunc if=BinOS/bootloader.bin of=BinOS/FrigoOS.flp
cd BinOS

mkdir tmp-loop && wsl sudo mount -o loop -t vfat FrigoOS.flp tmp-loop
copy kernel.bin tmp-loop

wsl sudo umount tmp-loop 

del /q tmp-loop\*
rmdir tmp-loop

del FrigoOS.iso
wsl mkisofs -quiet -V 'FRIGOOS' -input-charset iso8859-1 -o FrigoOS.iso -b FrigoOS.flp ./

wsl sudo qemu-system-i386 -fda FrigoOS.flp