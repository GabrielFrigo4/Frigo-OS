; ################################
; #	GLOBAL / EXTERN
; ################################

global Kernel_StackMemory_Used
global Kernel_StackMemory_Free
global Kernel_StackMemory_Total

extern STACK_BOTOM
extern STACK_TOP


; ################################
; #	SECTION .TEXT
; ################################

section .text
bits 64

; function uint64_t Kernel_StackMemory_Used()
Kernel_StackMemory_Used:
	mov rax, STACK_TOP
	sub rax, rsp
	ret

; function uint64_t Kernel_StackMemory_Free()
Kernel_StackMemory_Free:
	mov rax, rsp
	sub rax, STACK_BOTOM
	ret

; function uint64_t Kernel_StackMemory_Total()
Kernel_StackMemory_Total:
	mov rax, STACK_TOP
	sub rax, STACK_BOTOM
	ret