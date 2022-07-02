section .text
;args: al
;ret: al
dec2hex:
	push bx
	push cx
	mov bl, 10
	mov cl, 10h
	call base1_to_base2
	pop cx
	pop bx
	ret


	section .text
;args: al
;ret: al
hex2dec:
	push bx
	push cx
	mov bl, 10h
	mov cl, 10
	call base1_to_base2
	pop cx
	pop bx
	ret
	
	
	section .text
;args: al, bl, cl
;ret: al
base1_to_base2:
	mov byte [.arg1], al
	mov byte [.arg2], bl
	mov byte [.arg3], cl
	push ax
	push cx
	push dx
	xor ax, ax
	xor cx, cx
	xor dx, dx
	
	mov al, byte [.arg1]
    mov cl, byte [.arg2]
    div cx
	mov byte [.rst], al
	mov byte [.quo], dl
	
	mov al, byte [.rst]
	mov cl, byte [.arg3]
    mul cx
	add al, byte [.quo]
	mov byte [.val], al
	
	pop dx
	pop cx
	pop ax
	mov al, byte [.val]
	
	ret
	section .data
	.arg1: db 0
	.arg2: db 0
	.arg3: db 0
	.rst: db 0
	.quo: db 0
	.val: db 0


;args: al
;ret: al
abs:
	ret


;args: al
;ret: al
switchsign:
	ret