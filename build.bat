mkdir BinOS
nasm -O0 -w+orphan-labels -f bin -o  BinOS/bootloader.bin src/Bootloader.asm
nasm -O0 -w+orphan-labels -f bin -o BinOS/kernel.bin src/Kernel.asm 