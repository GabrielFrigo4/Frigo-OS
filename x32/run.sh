./build.sh
qemu-system-x86_64 -drive format=raw,file="BinOS/OS.bin",index=0,if=floppy,  -m 128M