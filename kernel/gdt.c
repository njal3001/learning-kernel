#include "gdt.h"
#include <stddef.h>

struct gdt_entry gdt[3];
struct gdt_descriptor gdt_descriptor = { sizeof(gdt) - 1, gdt };

extern void gdt_load(uint16_t code_offset, uint16_t data_offset);
static void gdt_set_segment_descriptor(size_t index, uint32_t limit,
        uint32_t base, uint8_t access, uint8_t flags);

void gdt_init()
{
    // Null descriptor
    gdt_set_segment_descriptor(0, 0, 0, 0, 0);

    // Code segment
    gdt_set_segment_descriptor(1, 0xFFFFF, 0, 0x9A, 0xC);

    // Data segment
    gdt_set_segment_descriptor(2, 0xFFFFF, 0, 0x92, 0xC);

    gdt_load(0x8, 0x10);
}

void gdt_set_segment_descriptor(size_t index, uint32_t limit,
        uint32_t base, uint8_t access, uint8_t flags)
{
   struct gdt_entry *entry = &gdt[index];
   entry->limit_low = limit & 0xFFFF;
   entry->base_low = base & 0xFFFF;
   entry->base_mid = (base >> 16) & 0xFF;
   entry->base_high = (base >> 24) & 0xF;
   entry->access = access;
   entry->attrib = (flags << 4) | ((limit >> 16) & 0xF);
}
