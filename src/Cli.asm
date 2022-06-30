    section .text
;args: noone
;ret: noone
setcolor:
    mov ah, 09h
    mov cx, 1000h
    mov al, 20h

    mov bl, [color_sys]
    int 10h
    ret

;args: di
;ret: noone
setcolorstr:
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
setallcolor:
    ret


;args: noone
;ret: noone
clear:
    mov al, 03h
    mov ah, 0
    int 10h
    ret


;args: di(ref)
;ret: noone
read:
    xor cl, cl

.loop:
    mov ah, 0
    int 0x16

    cmp al, 0x08
    je .backspace

    cmp al, 0x0D
    je .done

    cmp cl, 0x3F
    je .loop

    mov ah, 0x0E ;show add char
    int 0x10

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

    mov al, ''
    int 10h

    mov al, 0x08
    int 10h

    jmp .loop

.done:
    mov al, 0
    stosb
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret


;args: si
;ret: noone
write:
    lodsb

    or al, al
    jz .done

    mov ah, 0x0E
    int 0x10
    jmp write

.done:
    ret


;args: si
;ret: noone
writeln:
    call write
    
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret