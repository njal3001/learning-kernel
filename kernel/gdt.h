#pragma once
#include <stdint.h>

// TODO: Create flag definitions
struct gdt_entry
{
    uint16_t limit_low;
    uint16_t base_low;
    uint8_t base_mid;
    uint8_t access;
    uint8_t attrib; // Upper limit and flags
    uint8_t base_high;
} __attribute__((packed));

struct gdt_descriptor
{
    uint16_t limit;
    struct gdt_entry *gdt;
} __attribute__((packed));

void gdt_init();
