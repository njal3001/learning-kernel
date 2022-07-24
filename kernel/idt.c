#include "idt.h"

struct idt_entry idt[256];
struct idt_descriptor idt_descriptor = { sizeof(idt) - 1, idt };

void idt_set_gate(size_t index, uint32_t offset, uint16_t selector, uint8_t flags)
{
    struct idt_entry *gate = &idt[index];
    gate->offset_low = offset & 0xFFFF;
    gate->offset_high = (offset >> 16) & 0xFFFF;
    gate->segment_selector = selector;
    gate->flags = flags;
}
