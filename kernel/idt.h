#pragma once
#include <stdint.h>
#include <stddef.h>

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

#define IDT_CODE_SELECTOR 0x8
#define IDT_GATE_INTERRUPT_FLAGS 0x8E
#define IDT_GATE_TRAP_FLAGS 0x8F
#define IDT_GATE_TASK_FLAGS 0x85

extern void idt_load();
void idt_set_gate(size_t index, uint32_t offset, uint16_t selector, uint8_t flags);
