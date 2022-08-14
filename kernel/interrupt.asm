[bits 32]

global idt_load
global timer_interrupt_wrapper
global keyboard_interrupt_wrapper

extern idt_descriptor
extern timer_interrupt_handler
extern keyboard_interrupt_handler

idt_load:
    lidt [idt_descriptor]
    ret

timer_interrupt_wrapper:
    pushad
    cld
    call timer_interrupt_handler
    popad
    iret

keyboard_interrupt_wrapper:
    pushad
    cld
    call keyboard_interrupt_handler
    popad
    iret

global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

extern isr_handler

isr0:
    cli

    push 0 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr1:
    cli

    push 1 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr2:
    cli

    push 2 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr3:
    cli

    push 3 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr4:
    cli

    push 4 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr5:
    cli

    push 5 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr6:
    cli

    push 6 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr7:
    cli

    push 7 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr8:
    cli

    push 8 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr9:
    cli

    push 9 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr10:
    cli

    push 10 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr11:
    cli

    push 11 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr12:
    cli

    push 12 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr13:
    cli

    push 13 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr14:
    cli

    push 14 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr15:
    cli

    push 15 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr16:
    cli

    push 16 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr17:
    cli

    push 17 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr18:
    cli

    push 18 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr19:
    cli

    push 19 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr20:
    cli

    push 20 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr21:
    cli

    push 21 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr22:
    cli

    push 22 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr23:
    cli

    push 23 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr24:
    cli

    push 24 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr25:
    cli

    push 25 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr26:
    cli

    push 26 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr27:
    cli

    push 27 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr28:
    cli

    push 28 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr29:
    cli

    push 29 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr30:
    cli

    push 30 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret

isr31:
    cli

    push 31 ; Fault index
    pusha ; General purpose registers

    ; Segment registers
    push ds
    push es
    push fs
    push gs

    call isr_handler

    pop gs
    pop fs
    pop es
    pop ds
    popa

    iret
