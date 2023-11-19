; ################################
; #	GLOBAL / EXTERN
; ################################

global long_mode_start


; ################################
; #	SECTION .TEXT
; ################################

section .text
bits 64

; label long_mode_start
long_mode_start:
	; load null into all data segment registers
	mov ax, 0
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

    ; print OK
    mov dword [0xB8000], 0x2F4B2F4F
	;call kernel_main
	hlt