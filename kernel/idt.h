#pragma once
#include <stdint.h>

struct idt_entry
{
    uint16_t offset_low;
    uint16_t segment_selector;
    uint8_t reserved;
    uint8_t flags;
    uint16_t offset_high;
} __attribute__((packed));

struct idt_descriptor
{
    uint16_t limit;
    struct idt_entry *idt;
} __attribute__((packed));

extern void idt_load();
