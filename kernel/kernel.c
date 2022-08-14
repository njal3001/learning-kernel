#include <stddef.h>
#include "../drivers/vga_text.h"
#include "interrupt.h"
#include <stdbool.h>

int main()
{
    init_interrupts();
    vga_setcolorfb(VGA_COLOR_WHITE, VGA_COLOR_BLACK);

    for (;;)
    {
        asm volatile ("hlt");
    }

    return 0;
}

