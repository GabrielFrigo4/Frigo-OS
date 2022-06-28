BITS 16
[org 0]

    section .data
buffer:         times 64 db 0
color_sys:      db 07h
cmd:            db ":>", 0
erro_comand:    db "Command not found: ", 0
os_data:        db "FrigoOS v0.2.2", 0
get_clear:      db "clear", 0
get_os_data:    db "dataos", 0
get_color:     db "color", 0
color_arg:      db "color value: ", 0
get_color1:     db "color1", 0
get_color2:     db "color2", 0
get_color3:     db "color3", 0
get_color4:     db "color4", 0
get_color5:     db "color5", 0
get_color6:     db "color6", 0
get_color7:     db "color7", 0
get_color8:     db "color8", 0
get_color9:     db "color9", 0
get_exit:       db "exit", 0
get_restart:    db "restart", 0
get_date:        db "date", 0
get_time:        db "time", 0


    section .text
mov ax, cs
mov ds, ax
mov es, ax
mov ax, 0x7000
mov ss, ax
mov sp, ss

call clear

call setcolor
mov si, os_data ;write FrigoOS data
call writeln

main:
    call setcolor
    mov si, cmd
    call write

    mov di, buffer 
    call read

    call setcolor
    mov si, buffer
    cmp byte [si], 0
    je main

    mov si, buffer
    mov di, get_clear
    call strcmp
    je .clear

    mov si, buffer
    mov di, get_os_data
    call strcmp
    je .os_data

    mov si, buffer
    mov di, get_color
    call strcmp
    je .color

    mov si, buffer
    mov di, get_color1
    call strcmp
    je .color1

    mov si, buffer
    mov di, get_color2
    call strcmp
    je .color2

    mov si, buffer
    mov di, get_color3
    call strcmp
    je .color3

    mov si, buffer
    mov di, get_color4
    call strcmp
    je .color4

    mov si, buffer
    mov di, get_color5
    call strcmp
    je .color5

    mov si, buffer
    mov di, get_color6
    call strcmp
    je .color6

    mov si, buffer
    mov di, get_color7
    call strcmp
    je .color7

    mov si, buffer
    mov di, get_color8
    call strcmp
    je .color8

    mov si, buffer
    mov di, get_color9
    call strcmp
    je .color9

    mov si, buffer
    mov di, get_exit
    call strcmp
    je .exit

    mov si, buffer
    mov di, get_restart
    call strcmp
    je .restart
    
    mov si, buffer
    mov di, get_date
    call strcmp
    je .date

    mov si, buffer
    mov di, get_time
    call strcmp
    je .time

    mov si, erro_comand
    call write
    mov si, buffer
    call writeln

    jmp main

.clear:
    call clear
    call setcolor

    jmp main

.os_data:
    mov si, os_data
    call writeln

    jmp main

.color:
    mov si, color_arg
    call write

    mov di, buffer 
    call read
    call setcolorstr

    jmp main

.color1:
    mov si, color_sys
    mov byte [si], 07h

    jmp main

.color2:
    mov si, color_sys
    mov byte [si], 70h

    jmp main

.color3:
    mov si, color_sys
    mov byte [si], 87h

    jmp main

.color4:
    mov si, color_sys
    mov byte [si], 78h

    jmp main

.color5:
    mov si, color_sys
    mov byte [si], 13h

    jmp main

.color6:
    mov si, color_sys
    mov byte [si], 31h

    jmp main

.color7:
    mov si, color_sys
    mov byte [si], 24h

    jmp main

.color8:
    mov si, color_sys
    mov byte [si], 34h

    jmp main

.color9:
    mov si, color_sys
    mov byte [si], 94h

    jmp main

.exit:
    call shutdown
    ret

.restart:
    call restart
    ret
    
.date:
    call get_date_string 
    mov si, bx 
    call writeln
    jmp main

.time:
    call get_time_string 
    mov si, bx 
    call writeln
    jmp main


;args: si, di
strcmp:
.loop:
    mov al, [si]
    mov bl, [di] 
    cmp al, bl
    jne .notequal

    cmp al, 0
    je .done

    inc di
    inc si
    jmp .loop

.notequal:
    clc
    ret

.done:
    stc 
    ret


;args: noone
setcolor:
    mov ah, 09h
    mov cx, 1000h
    mov al, 20h

    mov bl, [color_sys]
    int 10h
    ret


;args: di
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
    cmp al, 0
    sub al, '0'
    mov byte [si], al

    xor ax, ax
    xor cx, cx
    mov al, byte [buffer]
    cmp al, 0
    sub al, '0'
    mov cl, 16
    mul cx
    add byte [si], al
.end:
    ret


;args: noone
setallcolor:
    ret


;args: noone
clear:
    mov al, 03h
    mov ah, 0
    int 10h
    ret


;args: di
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
writeln:
    call write
    
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret


;args: noone
restart:
    mov byte [color_sys], 07h
    mov si, buffer

    push ax
    xor ax, ax

.loop:
    mov byte [si], 0

    cmp al, 63
    jge .done

    inc di
    inc si
    inc ax
    jmp .loop

.done:
    pop ax
    ret


;args: noone
shutdown:
    mov ax, 0x1000
    mov ax, ss
    mov sp, 0xf000
    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15
    cli
    hlt
    ret
    
; ------------------------------------------------------------------
; FEATURES -- Code to pull into the kernel

     %INCLUDE "src/Date.asm"

; ==================================================================
; END OF KERNEL
; ==================================================================
