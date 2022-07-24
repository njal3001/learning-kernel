#include <stddef.h>
#include "../drivers/vga_text.h"
#include "interrupt.h"
#include <stdbool.h>

int main()
{
    init_interrupts();
    vga_setcolorfb(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
    vga_writestring("Hello kernel! This is my simple vga implementation!\n");
    vga_writestring("Hello again!\n");

    for (;;)
    {
        asm ("hlt");
    }

    return 0;
}

