BITS 16
[org 0]

	section .data
buffer times 64 db 0
prompt db '>', 0
os_data db "FrigoOS v0.1", 0
get_clear db "clear", 0
get_os_data db "dataos", 0
get_shutdown db "shutdown", 0
get_restart db "restart", 0

	section .text
mov ax, cs
mov ds, ax
mov es, ax
mov ax, 0x7000
mov ss, ax
mov sp, ss

mov al, 03h
mov ah, 0
int 10h

call setcolor
mov si, os_data ;write FrigoOS data
call writeln

mainloop:
    mov si, prompt
    call write

    mov di, buffer 
    call read

    mov si, buffer
    cmp byte[si], 0
    je mainloop

    mov si, buffer
    mov di, get_clear
    call strcmp
    je .clear

    mov si, buffer
    mov di, get_os_data
    call strcmp
    je .os_data

    mov si, buffer
    mov di, get_restart
    call strcmp
    je .restart

    mov si, buffer
    mov di, get_shutdown
    call strcmp
    je .shutdown

    mov si, buffer
    call writeln

    jmp mainloop

.clear:
    call clear
    call setcolor

    mov si, os_data ;write FrigoOS data
    call writeln

    jmp mainloop

.os_data:
    mov si, os_data
    call writeln

    jmp mainloop

.restart:
    ret

.shutdown:
    call shutdown


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


setcolor:
    mov ah, 09h
    mov cx, 1000h
    mov al, 20h

    mov bl, 30h
    int 10h
    ret


clear:
    mov al, 03h
    mov ah, 0
    int 10h
    ret

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


write:
    lodsb

    or al, al
    jz .done

    mov ah, 0x0E
    int 0x10
    jmp write

.done:
    ret

writeln:
    call write
    
    mov al, 0
    stosb
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret

shutdown:
    mov ax, 0x1000
    mov ax, ss
    mov sp, 0xf000
    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15
    ret
