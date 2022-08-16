#include <stddef.h>
#include "../drivers/vga_text.h"
#include "interrupt.h"
#include <stdbool.h>
#include "../memory/mem.h"

int main()
{
    init_interrupts();
    vga_setcolorfb(VGA_COLOR_WHITE, VGA_COLOR_BLACK);

    print_memory_map();

    for (;;)
    {
        asm volatile ("hlt");
    }

    return 0;
}

