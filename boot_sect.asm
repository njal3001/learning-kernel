; A 512 byte boot sector

; Start address
[org 0x7c00]

; Initialize boot drive value
mov [BOOT_DRIVE], dl

; Initialize segment registers
mov ax, cs
mov ds, ax
mov ss, ax
mov es, ax

; Move stack pointer to safe address
mov bp, 0x8000
mov sp, bp

mov bx, ax
call print_hex

; Select drive
mov dl, [BOOT_DRIVE]
; Number of sectors to read
mov dh, 1
; Buffer address
mov bx, 0x9000

call disk_load

mov bx, [0x9000]
call print_hex

; Infinite loop
jmp $

%include "utils.asm"

; Data
BOOT_DRIVE: db 0

; Pad with 0 until 510 bytes
times 510-($-$$) db 0

; Magic boot number at end
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface
