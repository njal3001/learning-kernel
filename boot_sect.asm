; A 512 byte boot sector

; Start address
[org 0x7c00]

;
; Print hex numbers to screen
;

mov bx, 0x0f9b
call print_hex
mov bx, 0xfab3
call print_hex

; Infinite loop
jmp $

%include "utils.asm"

; Pad with 0 until 510 bytes
times 510-($-$$) db 0

; Magic boot number at end
dw 0xaa55
