# ASM FILES
x86_64_asm_source_files := $(shell find src -name *.asm)
x86_64_asm_object_files := $(patsubst src/%.asm, bin/obj/%.o, $(x86_64_asm_source_files))

# C FILES
x86_64_c_source_files := $(shell find src -name *.c)
x86_64_c_object_files := $(patsubst src/%.c, bin/obj/%.o, $(x86_64_c_source_files))

# OBJECT FILES
x86_64_object_files := $(x86_64_c_object_files) $(x86_64_asm_object_files)

$(x86_64_asm_object_files): bin/obj/%.o : src/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst bin/obj/%.o, src/%.asm, $@) -o $@

$(x86_64_c_object_files): bin/obj/%.o : src/%.c
	mkdir -p $(dir $@) && \
	x86_64-elf-gcc -c -I src/interface -ffreestanding $(patsubst bin/obj/%.o, src/%.c, $@) -o $@

.PHONY: build
build: $(x86_64_object_files)
	mkdir -p bin/obj && \
	mkdir -p bin/elf && \
	x86_64-elf-ld -n -o bin/elf/kernel.elf -T src/linker/kernel.ld $(x86_64_object_files) && \
	cp bin/elf/kernel.elf iso/boot/kernel.elf && \
	grub-mkrescue -o bin/kernel.iso iso