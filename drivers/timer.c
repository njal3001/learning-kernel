#include "timer.h"
#include "vga_text.h"
#include "pic.h" 

volatile uint32_t ticks = 0;

void timer_interrupt_handler()
{
    ticks++;

    pic_send_eoi(); 
}

uint32_t timer_ticks()
{
    return ticks;
}
