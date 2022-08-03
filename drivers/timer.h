#pragma once
#include <stdint.h>

#define TIMER_FREQUENCY 18.222f

void timer_interrupt_handler();
uint32_t timer_ticks();
