#include "keyboard.h"
#include "vga_text.h"
#include "io_port.h"

void keyboard_interrupt_handler()
{
    uint8_t val = inb(0x60);
    vga_writechar('h'); 
}
