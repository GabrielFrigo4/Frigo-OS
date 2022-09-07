@call build.bat
@qemu-system-x86_64w -drive format=raw,file="BinOS/OS.bin",index=0,if=floppy,  -m 128M