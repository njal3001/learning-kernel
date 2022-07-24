#include "interrupt.h"
#include "idt.h"
#include "../drivers/pic.h"

extern void keyboard_interrupt_wrapper();

void init_interrupts()
{
    idt_load();
    pic_remap();
    idt_set_gate(
            0x21,
            (uint32_t)keyboard_interrupt_wrapper,
            IDT_CODE_SELECTOR,
            IDT_GATE_INTERRUPT_FLAGS);

    // Only allow keyboard interrupts
    irq_set_mask(0xFD);

    // Enable interrupts
    asm volatile ("sti");
}
