BITS 16
[org 0]

mov ax, cs
mov ds, ax
mov es, ax
mov ax, 0x7000
mov ss, ax
mov sp, ss

start: 
    mov al, 03h
    mov ah, 0
    int 10h

    ; get keyboard
    _mouser:
        mov ah, 02h
        mov dl, bl
        mov dh, cl
        int 10h
        mov ah, 00h
        int 16h

        cmp al, 08h
        je _backspace
        cmp al, 09h
        jge _print
        cmp al, 07h
        jae _print
        jmp _mouser

    _backspace:
        sub bl, 1h
        jmp _backspace_char

    _backspace_char:
        mov ah, 0eh
        mov al, 20h
        int 10h
        jmp _mouser

    _down_key:
        add cl, 1h
        jmp _mouser

    _up_key:
        sub cl, 10h
        jmp _mouser
    
    _left_key:
        sub bl, 10h
        jmp _mouser

    _right_key:
        add bl, 1h
        jmp _mouser

    _print:
        mov ah, 0eh
        cmp al, 0dH
        je _down_key
        int 10h
        jmp _right_key

    ret