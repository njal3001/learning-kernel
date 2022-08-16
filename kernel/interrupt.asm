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

extern isr_handler

%macro isr_define 1
global isr%1

isr%1:
    cli

    push %1 ; Fault index
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
%endmacro

%assign i 0
%rep 32
isr_define i
%assign i i + 1
%endrep
