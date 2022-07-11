#include "vga_text.h"
#include "../kernel/utils.h"
#include "io_port.h"

#define VMA 0xb8000

size_t x = 0; 
size_t y = 0; 
uint16_t *buffer = (uint16_t*)VMA;
uint8_t color = VGA_COLOR_WHITE;

static inline uint16_t vga_entry(char ch, uint8_t color)
{
    return ((uint16_t) ch) | ((uint16_t)(color << 8)); 
}

void vga_clear()
{
    uint16_t blank = vga_entry(32, color);
    void *dest = &buffer[0];

    memset16(dest, blank, VGA_WIDTH * VGA_WIDTH);
}

void vga_writechar(char c)
{
    if (c == '\n')
    {
        x = 0;
        if (++y == VGA_HEIGHT)
            y = 0;
    }
    else
    {
        size_t i = x + y * VGA_WIDTH; 
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
        vga_writechar(*(s++));
}

void vga_writeint(int val, size_t base)
{
    if (val == 0)
    {
        // Print zero and end early
        vga_writechar(48);
        return;
    }

    if (val < 0)
    {
        // Print minus sign
        vga_writechar(45);

        // Convert to positive
        val = -val;
    }

    // Store digits to be printed
    int digits[10]; // Harcoded max length
    size_t n_digits = 0;

    while (val != 0)
    {
        // Get least significant digit and right shift
        int res = val % base;
        val -= res;
        val /= base;

        digits[n_digits++] = res;
    }

    // Print the digits
    for (int i = n_digits - 1; i >= 0; i--)
    {
        vga_writechar(48 + digits[i]);
    }
}

void vga_setcolorfb(enum vga_color fg, enum vga_color bg)
{
    color = ((uint8_t)fg) | ((uint8_t)(bg << 4));
}

void vga_setcolor(uint8_t co)
{
    color = co;
}

void vga_scrolldown(size_t amount)
{
    // Number of rows to move
    size_t mov_rows = max(VGA_HEIGHT - amount, 0);

    // Move lower part of buffer  
    if (mov_rows)
    {
        size_t i = amount * VGA_WIDTH;
        void *src = &buffer[i];
        void *dest = &buffer[0];

        memcpy(dest, src, mov_rows * VGA_WIDTH * sizeof(uint16_t));
    }

    // Clear rest of screen
    uint16_t blank = vga_entry(32, color);
    size_t clear_rows = VGA_HEIGHT - mov_rows;
    void *dest = &buffer[mov_rows * VGA_WIDTH];

    memset16(dest, blank, clear_rows * VGA_WIDTH);
}

void vga_enablecursor(uint8_t start, uint8_t end)
{
    outb(0x3D4, 0x0A);
    outb(0x3D5, start);
 
	outb(0x3D4, 0x0B);
	outb(0x3D5, end);
}

void vga_disablecursor()
{
    outb(0x3D4, 0x0A);
    outb(0x3D5, 0x20);
}

void vga_updatecursor(size_t x, size_t y)
{
    uint16_t pos = x + y * VGA_WIDTH;

    // Send lowest byte of pos
    outb(0x3D4, 0x0F);
    outb(0x3D5, (uint8_t)(pos & 0xFF));

    // Send highest byte of pos
    outb(0x3D4, 0x0E);
    outb(0x3D5, (uint8_t)(pos >> 8));
}
