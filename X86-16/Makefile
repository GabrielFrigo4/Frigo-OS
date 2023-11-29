################################
#	ASM FILES
################################
x86_16_kernel_asm_source_files := $(shell find src/kernel -name *.asm)
x86_16_kernel_asm_binary_files := $(patsubst src/kernel/%.asm, bin/kernel/%.bin, $(x86_16_kernel_asm_source_files))

################################
#	BINARY FILES
################################
x86_16_kernel_binary_files := $(x86_16_kernel_asm_binary_files)

$(x86_16_kernel_asm_binary_files): bin/kernel/%.bin : src/kernel/%.asm
	mkdir -p $(dir $@) && \
	nasm -f bin $(patsubst bin/kernel/%.bin, src/kernel/%.asm, $@) -o $@

.PHONY: build
build: $(x86_16_kernel_binary_files)
	mkdir -p bin/kernel && \
	cat bin/kernel/bootloader.bin bin/kernel/extended-program.bin >> bin/Frigo-OS.flp
