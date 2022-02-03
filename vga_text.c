#include "vga_text.h"
#include <stddef.h>

#define VMA 0xb8000

#define VGA_WIDTH 80
#define VGA_HEIGHT 25

size_t x = 0; 
size_t y = 0; 
uint16_t *buffer = (uint16_t*)VMA;
uint8_t color = VGA_COLOR_WHITE;

static inline uint16_t vga_entry(const char ch, const uint8_t color)
{
    return ((uint16_t) ch) | ((uint16_t)(color << 8)); 
}

void vga_writechar(const char c)
{
    if (c == '\n')
    {
        x = 0;
        if (++y == VGA_HEIGHT)
            y = 0;
    }
    else
    {
        const size_t i = x + y * VGA_WIDTH; 
        buffer[i] = vga_entry(c, color);

        if (++x == VGA_WIDTH) 
        {
            x = 0;
            if (++y == VGA_HEIGHT)
                y = 0;
        }
    }
}

void vga_writestring(const char *s)
{
    while(*s)
    {
        vga_writechar(*(s++));
    }
}

void vga_setcolorfb(const enum vga_color fg, const enum vga_color bg)
{
    color = ((uint8_t)fg) | ((uint8_t)(bg << 4));
}

void vga_setcolor(const uint8_t co)
{
    color = co;
}
