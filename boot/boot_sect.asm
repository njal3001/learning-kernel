; A 512 byte boot sector

[org 0x7c00] ; Start address
[bits 16]

KERNEL_LOCATION equ 0x1000
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

MMAP_LOCATION equ 0x8004
MMAP_ENTRY_COUNT_LOCATION equ 0x9000

mov [BOOT_DRIVE], dl

; Initialize segment registers
xor ax, ax
mov ds, ax
mov ss, ax
mov es, ax

; Move stack pointer to safe address
mov bp, 0x8000
mov sp, bp

; Clear screen by changing to graphics mode
; and changing back to text mode
mov ah, 0
mov al, 0
int 0x10
mov al, 3
int 0x10

; Load kernel
; TODO: Error handling
mov dl, [BOOT_DRIVE]    ; Select drive
mov dh, 20              ; Number of sectors to read
mov bx, KERNEL_LOCATION ; Buffer pointer

call bios_disk_load

; Read memory map
mov di, MMAP_LOCATION
call bios_get_mmap
mov [MMAP_ENTRY_COUNT_LOCATION], ax

cmp ax, 0
jne boot_success

boot_error:
    mov bx, BOOT_ERROR_MSG
    call bios_print_string

error_loop:
    hlt
    jmp error_loop

boot_success:

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

jmp KERNEL_LOCATION

%include "boot/bios_utils.asm"

; Data
[bits 16]
BOOT_ERROR_MSG: db "Something went wrong. Boot failed!", 0

BOOT_DRIVE: db 0

[bits 32]
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
