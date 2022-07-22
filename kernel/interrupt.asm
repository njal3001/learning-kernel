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
