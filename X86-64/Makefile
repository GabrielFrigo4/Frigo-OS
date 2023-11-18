x86_64_asm_source_files := $(shell find src -name *.asm)
x86_64_asm_object_files := $(patsubst src/%.asm, bin/obj/%.o, $(x86_64_asm_source_files))

$(x86_64_asm_object_files): bin/obj/%.o : src/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst bin/obj/%.o, src/%.asm, $@) -o $@

.PHONY: build
build: $(x86_64_asm_object_files)
	mkdir -p bin/obj && \
	x86_64-elf-ld -n -o bin/obj/kernel.bin -T src/targets/linker.ld $(x86_64_asm_object_files) && \
	cp bin/obj/kernel.bin iso/boot/kernel.bin && \
	grub-mkrescue /usr/lib/grub/i386-pc -o bin/kernel.iso iso