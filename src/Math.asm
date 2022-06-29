    section .text
;args: al
;ret: al
dec2hex:
    mov byte [.arg], al

    push ax
    push cx
    push dx

    xor ax, ax
    xor cx, cx
    xor dx, dx
    mov al, byte [.arg]
    mov cx, 10
    div cx
    push dx
    
    xor cx, cx
    mov cx, 10h
    mul cx
    pop dx
    add ax, dx
    mov byte [.return], al

    pop dx
    pop cx
    pop ax

    mov al, byte [.return]
    ret
    .arg: db 0
    .return: db 0


;args: al
;ret: al
hex2dec:
    mov byte [.arg], al

    push ax
    push cx
    push dx

    xor ax, ax
    xor cx, cx
    xor dx, dx
    mov al, byte [.arg]
    mov cx, 10h
    div cx
    push dx
    
    xor cx, cx
    mov cx, 10
    mul cx
    pop dx
    add ax, dx
    mov byte [.return], al

    pop dx
    pop cx
    pop ax

    mov al, byte [.return]
    ret
    .arg: db 0
    .return: db 0