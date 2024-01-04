Remove-Item bin -Force -Recurse;
New-Item -ItemType Directory -Force -Path "bin/elf";
New-Item -ItemType Directory -Force -Path "bin/obj/kernel";
New-Item -ItemType Directory -Force -Path "bin/iso/boot/grub";