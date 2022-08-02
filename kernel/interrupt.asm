[bits 32]

global idt_load
global keyboard_interrupt_wrapper
extern idt_descriptor
extern keyboard_interrupt_handler

idt_load:
    lidt [idt_descriptor]
    ret

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
    push byte 0
    call isr_handler
    iret

isr1:
    cli
    push byte 1
    call isr_handler
    iret

isr2:
    cli
    push byte 2
    call isr_handler
    iret

isr3:
    cli
    push byte 3
    call isr_handler
    iret

isr4:
    cli
    push byte 4
    call isr_handler
    iret

isr5:
    cli
    push byte 5
    call isr_handler
    iret

isr6:
    cli
    push byte 6
    call isr_handler
    iret

isr7:
    cli
    push byte 7
    call isr_handler
    iret

isr8:
    cli
    push byte 8
    call isr_handler
    iret

isr9:
    cli
    push byte 9
    call isr_handler
    iret

isr10:
    cli
    push byte 10
    call isr_handler
    iret

isr11:
    cli
    push byte 11
    call isr_handler
    iret

isr12:
    cli
    push byte 12
    call isr_handler
    iret

isr13:
    cli
    push byte 13
    call isr_handler
    iret

isr14:
    cli
    push byte 14
    call isr_handler
    iret

isr15:
    cli
    push byte 15
    call isr_handler
    iret

isr16:
    cli
    push byte 16
    call isr_handler
    iret

isr17:
    cli
    push byte 17
    call isr_handler
    iret

isr18:
    cli
    push byte 18
    call isr_handler
    iret

isr19:
    cli
    push byte 19
    call isr_handler
    iret

isr20:
    cli
    push byte 20
    call isr_handler
    iret

isr21:
    cli
    push byte 21
    call isr_handler
    iret

isr22:
    cli
    push byte 22
    call isr_handler
    iret

isr23:
    cli
    push byte 23
    call isr_handler
    iret

isr24:
    cli
    push byte 24
    call isr_handler
    iret

isr25:
    cli
    push byte 25
    call isr_handler
    iret

isr26:
    cli
    push byte 26
    call isr_handler
    iret

isr27:
    cli
    push byte 27
    call isr_handler
    iret

isr28:
    cli
    push byte 28
    call isr_handler
    iret

isr29:
    cli
    push byte 29
    call isr_handler
    iret

isr30:
    cli
    push byte 30
    call isr_handler
    iret

isr31:
    cli
    push byte 31
    call isr_handler
    iret
