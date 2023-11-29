; ################################
; # INCLUDE HEADER
; ################################

%include "src/kernel/standard.inc"

; ################################
; # START ASSEMBLY CODE
; ################################

[org PROGRAM_SPACE]

mov bx, ExtendedSpaceSuccess
call ConsoleWriteString

jmp $

; ################################
; # INCLUDE CODE
; ################################

%include "src/kernel/console.s"

; ################################
; # END ASSEMBLY CODE
; ################################

ExtendedSpaceSuccess:
	db 'We are succesfully in extended space', 0

times 2048-($-$$) db 0
