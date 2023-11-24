section .multiboot_header

header_start:
	MAGIC_NUMBER:	equ	0xE85250D6
	ARCHITECTURE:	equ	0
	HEADER_LENGHT:	equ header_end - header_start
	CHECKSUM:		equ 0x100000000 - (MAGIC_NUMBER + ARCHITECTURE + HEADER_LENGHT)

	dd MAGIC_NUMBER ; multiboot2
	dd ARCHITECTURE ; protected mode i386
	dd HEADER_LENGHT
	dd CHECKSUM
	
	; end tag
	dw 0
	dw 0
	dd 8
header_end: