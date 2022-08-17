[bits 32]

global gdt_load
extern gdt_descriptor

; Input:
;   $1: Data segment offset
;   $2: Code segment offset
gdt_load:
    push ebp
    mov ebp, esp

    lgdt [gdt_descriptor]

    ; Far jump to flush?
    mov ax, [ebp + 8] ; Code offset
    push ax
    push gdt_load_end
    retf

    gdt_load_end:

    ; Set up segment registers
    mov ax, [ebp + 12] ; Data offset
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov esp, ebp
    pop ebp
    ret
