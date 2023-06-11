section .text
    [bits 32]
	[extern init_kernel]
    call init_kernel
    [extern main]
    call main
    jmp $
