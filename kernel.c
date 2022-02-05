#include <stddef.h>
#include "vga_text.h"

int main()
{
    vga_setcolorfb(VGA_COLOR_WHITE, VGA_COLOR_BLACK);
    vga_writestring("Hello kernel! This is my simple vga implementation!\n");
    vga_writestring("Hello again!\n");

    return 0;
}

