; ################################
; # INCLUDE ASSEMBLY HEADER
; ################################

%include "src/kernel/standard.inc"

; ################################
; # START ASSEMBLY CODE
; ################################

[org STACK_SPACE]

mov [BOOT_DISK], dl
mov bp, STACK_SPACE
mov sp, bp

call ReadDisk

jmp PROGRAM_SPACE

; ################################
; # INCLUDE ASSEMBLY CODE
; ################################

%include "src/kernel/console.s"
%include "src/kernel/disk-read.s"

; ################################
; # END ASSEMBLY CODE
; ################################

times (BOOT_SIZE-2) - ($-$$) db 0
dw 0xaa55
