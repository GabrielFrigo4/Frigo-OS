################################
#	ASM FILES
################################
x86_64_kernel_asm_source_files := $(shell find src/kernel -name *.asm)
x86_64_kernel_asm_object_files := $(patsubst src/kernel/%.asm, bin/obj/kernel/%.o, $(x86_64_kernel_asm_source_files))

################################
#	C FILES
################################
x86_64_kernel_c_source_files := $(shell find src/kernel -name *.c)
x86_64_kernel_c_object_files := $(patsubst src/kernel/%.c, bin/obj/kernel/%.o, $(x86_64_kernel_c_source_files))

################################
#	OBJECT FILES
################################
x86_64_kernel_object_files := $(x86_64_kernel_c_object_files) $(x86_64_kernel_asm_object_files)

$(x86_64_kernel_asm_object_files): bin/obj/kernel/%.o : src/kernel/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst bin/obj/kernel/%.o, src/kernel/%.asm, $@) -o $@

$(x86_64_kernel_c_object_files): bin/obj/kernel/%.o : src/kernel/%.c
	mkdir -p $(dir $@) && \
	x86_64-elf-gcc -c -I src/kernel/interface -ffreestanding -Wno-multichar $(patsubst bin/obj/kernel/%.o, src/kernel/%.c, $@) -o $@

.PHONY: build
build: $(x86_64_kernel_object_files)
	mkdir -p bin/elf && \
	mkdir -p bin/obj/kernel && \
	mkdir -p bin/iso/boot/grub && \
	x86_64-elf-ld -n -o bin/elf/kernel.elf -T src/linker/kernel.ld $(x86_64_kernel_object_files) && \
	cp bin/elf/kernel.elf bin/iso/boot/kernel.elf && \
	cp src/kernel/boot/grub.cfg bin/iso/boot/grub/grub.cfg && \
	grub-mkrescue -o bin/Frigo-OS.iso bin/iso
