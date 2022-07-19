[bits 32]

global idt_load
[extern idt_descriptor]

idt_load:
    lidt [idt_descriptor]
    ret
