; A 512 byte boot sector

[org 0x7c00] ; Start address
[bits 16]

KERNEL_LOCATION equ 0x1000
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

mov [BOOT_DRIVE], dl

; Initialize segment registers
xor ax, ax
mov ds, ax
mov ss, ax
mov es, ax

; Move stack pointer to safe address
mov bp, 0x8000
mov sp, bp

; Load kernel
mov dl, [BOOT_DRIVE]    ; Select drive
mov dh, 2               ; Number of sectors to read
mov bx, KERNEL_LOCATION ; Buffer pointer

call bios_disk_load


cli ; Disable interrups
lgdt [gdt_descriptor] ; Load GDT

; Switch to 32 bit protected mode
mov eax, cr0
or eax, 1
mov cr0, eax

; Long jump to flush cpu pipeline of 16-bit instructions
jmp CODE_SEG:start_protected_mode

[bits 32]
start_protected_mode:

; Initialize segment registers
mov ax, DATA_SEG
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

; Move stack pointer to safe address
mov ebp, 0x90000
mov esp, ebp

mov eax, MSG_PM
call print_string

jmp $ ; Infinite loop

%include "bios_utils.asm"
%include "utils.asm"

; Data
BOOT_DRIVE: db 0
MSG_PM: db "Switched to 32-bit protected mode!", 0

; GDT setup
gdt_start:
    ; Null descriptor
    dd 0
    dd 0

gdt_code:
    dw 0xffff       ; Limit (bits 0-15)
    dw 0            ; Base (bits 0-15)
    db 0            ; Base (bits 16-23)
    db 10011010b    ; Access byte
    db 11001111b    ; Flags and Limit (bits 16-19)
    db 0            ; Base (bits 24-31)
    
gdt_data:
    dw 0xffff       ; Limit (bits 0-15)
    dw 0            ; Base (bits 0-15)
    db 0            ; Base (bits 16-23)
    db 10010010b    ; Access byte
    db 11001111b    ; Flags and Limit (bits 16-19)
    db 0            ; Base (bits 24-31)

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start


times 510-($-$$) db 0 ; Pad with 0 until 510 bytes
dw 0xaa55 ; Magic boot number at end
