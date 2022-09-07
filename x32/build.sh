export PATH="$PATH:/usr/local/i386elfgcc/bin"

if [ ! -e Binaries ]
then
	mkdir Binaries
fi

nasm "src/asm/boot.asm" -f bin -o "Binaries/boot.bin"
nasm "src/asm/kernel_entry.asm" -f elf -o "Binaries/kernel_entry.o"
i386-elf-gcc -ffreestanding -m32 -g -c "src/c/kernel.c" -o "Binaries/kernel.o"
i386-elf-gcc -ffreestanding -m32 -g -c "src/c/io.c" -o "Binaries/io.o"
i386-elf-gcc -ffreestanding -m32 -g -c "src/c/main.c" -o "Binaries/main.o"
nasm "src/asm/zeroes.asm" -f bin -o "Binaries/zeroes.bin"

i386-elf-ld -o "Binaries/full_kernel.bin" -Ttext 0x1000 "Binaries/kernel_entry.o" "Binaries/kernel.o" "Binaries/io.o" "Binaries/main.o" --oformat binary

cat "Binaries/boot.bin" "Binaries/full_kernel.bin" "Binaries/zeroes.bin" > "Binaries/OS.bin"