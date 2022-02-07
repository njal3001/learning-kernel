#pragma once
#include <stdint.h>
#include <stddef.h>

enum vga_color {
	VGA_COLOR_BLACK = 0,
	VGA_COLOR_BLUE = 1,
	VGA_COLOR_GREEN = 2,
	VGA_COLOR_CYAN = 3,
	VGA_COLOR_RED = 4,
	VGA_COLOR_MAGENTA = 5,
	VGA_COLOR_BROWN = 6,
	VGA_COLOR_LIGHT_GREY = 7,
	VGA_COLOR_DARK_GREY = 8,
	VGA_COLOR_LIGHT_BLUE = 9,
	VGA_COLOR_LIGHT_GREEN = 10,
	VGA_COLOR_LIGHT_CYAN = 11,
	VGA_COLOR_LIGHT_RED = 12,
	VGA_COLOR_LIGHT_MAGENTA = 13,
	VGA_COLOR_LIGHT_BROWN = 14,
	VGA_COLOR_WHITE = 15,
};

#define VGA_WIDTH 80
#define VGA_HEIGHT 25

void vga_writechar(const char c);
void vga_writestring(const char *s);
void vga_writeint(int val, const size_t base);

void vga_setcolor(const uint8_t co);
void vga_setcolorfb(const enum vga_color fg, const enum vga_color bg);

void vga_clear();
void vga_scrolldown(const size_t amount);

// Cursor start and end scanline (0 to 15)
void vga_enablecursor(const uint8_t start, const uint8_t end);
void vga_disablecursor();
void vga_updatecursor(const size_t x, const size_t y);
