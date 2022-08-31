    section .text
;args: noone
;ret: noone
set_color:
    mov ah, 09h
    mov cx, 1000h
    mov al, 20h

    mov bl, [color_sys]
    int 10h
    ret

;args: di
;ret: noone
set_color_str:
    mov si, color_sys

    mov al, byte [buffer + 1]
    cmp al, 0
    je .end
    mov al, byte [buffer]
    cmp al, 0
    je .end

    xor ax, ax
    mov al, byte [buffer + 1]
    cmp al, 'A'
    jge .letter1
    sub al, '0'
    mov byte [si], al
    jmp .endLetter1
.letter1:
    sub al, 'A' - 10
    mov byte [si], al
.endLetter1:

    xor ax, ax
    xor cx, cx
    mov al, byte [buffer]
    cmp al, 'A'
    jge .letter2
    sub al, '0'
    mov cl, 16
    mul cx
    add byte [si], al
    jmp .endLetter2
.letter2:
    sub al, 'A' - 10
    mov cl, 16
    mul cx
    add byte [si], al
.endLetter2:

.end:
    ret


;args: noone
;ret: noone
set_all_color:
    ret


;args: noone
;ret: noone
clear:
    mov al, 03h
    mov ah, 0
    int 10h
    ret


;args: noone
;ret: al
readc_hide:
	mov ah, 0
    int 0x16
	ret
	
;args: noone
;ret: al
readc:
	call readc_hide
    pusha
	mov bl, al
	call writec
	popa
	ret


;args: di(ref)
;ret: noone
read_hide:
    xor cl, cl

.loop:
    call readc_hide

    cmp al, 0x08
    je .backspace

    cmp al, 0x0D
    je .done

    cmp cl, 0x3F
    je .loop

    stosb
    inc cl
    jmp .loop

.backspace:
    cmp cl, 0
    je .loop

    dec di
    mov byte[di], 0
    dec cl

    mov ah, 0x0E
    mov al, 0x08

    jmp .loop

.done:
    mov al, 0
    stosb
	mov bl, 0x0D
	call writec
	mov bl, 0x0A
	call writec
    ret


;args: di(ref)
;ret: noone
read:
    xor cl, cl

.loop:
    call readc_hide

    cmp al, 0x08
    je .backspace

    cmp al, 0x0D
    je .done

    cmp cl, 0x3F
    je .loop

	mov bl, al
	call writec

    stosb
    inc cl
    jmp .loop

.backspace:
    cmp cl, 0
    je .loop

    mov bl, al
	call writec ;show remove char


    dec di
    mov byte[di], 0
    dec cl

    mov ah, 0x0E
    mov al, 0x08

	mov bl, ''
	call writec

	mov bl, 0x08
	call writec

    jmp .loop

.done:
    mov al, 0
    stosb
	mov bl, 0x0D
	call writec
	mov bl, 0x0A
	call writec
    ret


;args: bl
;ret: noone
writec:
    pusha
	mov ah, 0x0E
	mov al, bl
	int 0x10
    popa
	ret


;args: si
;ret: noone
write:
    pusha
.loop:
	mov bl, [si]
	cmp bl, 0
	je .end
	call writec
	cmp bl, 10
	je .newl
	jmp .thisl
	
.newl:
	mov bl, 0x0D
	call writec

.thisl:
	inc si
	jmp .loop
	
.end:
    popa
	ret


;args: si
;ret: noone
writeln:
    pusha
    call write
    
    mov bl, 0x0D
    call writec
    mov bl, 0x0A
	call writec
    popa
    ret