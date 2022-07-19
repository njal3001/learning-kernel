#include <stddef.h>
#include "../drivers/vga_text.h"
#include "idt.h"

int main()
{
    idt_load();
    vga_setcolorfb(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
    vga_writestring("Hello kernel! This is my simple vga implementation!\n");
    vga_writestring("Hello again!\n");

    return 0;
}

