#pragma once
#include <stdint.h>

struct interrupt_info
{
    uint32_t gs, fs, es, ds;
    uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
    uint32_t fault_index;
};

void init_interrupts();
void isr_handler(struct interrupt_info info);
