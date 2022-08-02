#pragma once
#include <stdint.h>

void init_interrupts();
void isr_handler(uint8_t fault_index);
