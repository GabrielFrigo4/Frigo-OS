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
cread_hide:
	mov ah, 0
    int 0x16
	ret
	
;args: noone
;ret: al
cread:
	push bx
	call cread_hide
	mov bl, al
	call cwrite
	pop bx
	ret


;args: di(ref)
;ret: noone
read:
    xor cl, cl

.loop:
    call cread_hide

    cmp al, 0x08
    je .backspace

    cmp al, 0x0D
    je .done

    cmp cl, 0x3F
    je .loop

	mov bl, al
	call cwrite

    stosb
    inc cl
    jmp .loop

.backspace:
    cmp cl, 0
    je .loop

    mov ah, 0x0E ;show remove char
    int 0x10

    dec di
    mov byte[di], 0
    dec cl

    mov ah, 0x0E
    mov al, 0x08

	mov bl, ''
	call cwrite

	mov bl, 0x08
	call cwrite

    jmp .loop

.done:
    mov al, 0
    stosb
	mov bl, 0x0D
	call cwrite
	mov bl, 0x0A
	call cwrite
    ret


;args: bl
;ret: noone
cwrite:
	push ax
	mov ah, 0x0E
	mov al, bl
	int 0x10
	pop ax
	ret


;args: si
;ret: noone
write:
.loop:
	mov bl, [si]
	cmp bl, 0
	je .end
	call cwrite
	cmp bl, 10
	je .newl
	jmp .thisl
	
.newl:
	mov bl, 0x0D
	call cwrite

.thisl:
	inc si
	jmp .loop
	
.end:
	ret


;args: si
;ret: noone
writeln:
    call write
    
    mov bl, 0x0D
    call cwrite
    mov bl, 0x0A
	call cwrite
    ret