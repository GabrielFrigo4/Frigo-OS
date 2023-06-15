#!/bin/sh
export PATH="$PATH:/usr/local/x86_64elfgcc/bin"

if [ ! -e BinOS ]
then
	mkdir BinOS
fi

nasm "src/asm/boot.asm" -f bin -o "BinOS/boot.bin"
nasm "src/asm/kernel_entry.asm" -f elf64 -o "BinOS/kernel_entry.o"
x86_64-elf-gcc -ffreestanding -m64 -g -c "src/c/kernel.c" -o "BinOS/kernel.o"
x86_64-elf-gcc -ffreestanding -m64 -g -c "src/c/io.c" -o "BinOS/io.o"
x86_64-elf-gcc -ffreestanding -m64 -g -c "src/c/main.c" -o "BinOS/main.o"
nasm "src/asm/zeroes.asm" -f bin -o "BinOS/zeroes.bin"

x86_64-elf-ld -o "BinOS/full_kernel.bin" -Ttext 0x1000 "BinOS/kernel_entry.o" "BinOS/kernel.o" "BinOS/io.o" "BinOS/main.o" --oformat binary

cat "BinOS/boot.bin" "BinOS/full_kernel.bin" "BinOS/zeroes.bin" > "BinOS/OS.bin"

echo 'FrigoOS Build!'
