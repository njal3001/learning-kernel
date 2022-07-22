#include <stddef.h>
#include "../drivers/vga_text.h"
#include "idt.h"
#include "stdbool.h"

int main()
{
    idt_initialize();
    // asm volatile ("sti");
    vga_setcolorfb(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
    vga_writestring("Hello kernel! This is my simple vga implementation!\n");
    vga_writestring("Hello again!\n");

    while (true);

    return 0;
}

