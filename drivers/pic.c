#include "pic.h"
#include "../drivers/io_port.h"

void pic_remap()
{
    // ICW1 - Start initialization
    outb(PIC1_COMMAND_PORT, ICW1_INIT | ICW1_ICW4);
    outb(PIC2_COMMAND_PORT, ICW1_INIT | ICW1_ICW4);

    // ICW2 - Remap master and slave pic
    outb(PIC1_DATA_PORT, 0x20);
    outb(PIC2_DATA_PORT, 0x28);

    // ICW3 - setup cascading
    outb(PIC1_DATA_PORT, 4);
    outb(PIC2_DATA_PORT, 3);

    // ICW4 - enviroment info
    outb(PIC1_DATA_PORT, ICW4_8086);
    outb(PIC2_DATA_PORT, ICW4_8086);
}

void irq_set_mask(uint8_t mask)
{
    outb(PIC1_DATA_PORT, mask);
}

void pic_send_eoi()
{
    outb(PIC1_COMMAND_PORT, PIC_EOI);
}
