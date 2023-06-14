section .text
    [bits 64]
	[extern init_kernel]
    call init_kernel
    [extern main]
    call main
    jmp $
