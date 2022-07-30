#include "keyboard.h"
#include "vga_text.h"
#include "io_port.h"
#include "pic.h"
#include <stdbool.h>

#define SCANCODE_CAPSLOCK 0x3A
#define SCANCODE_LEFT_SHIFT 0x2A
#define SCANCODE_RIGHT_SHIFT 0x36

enum keyboard_state
{
    KEYBOARD_STATE_CAPSLOCK = 1 << 0,
    KEYBOARD_STATE_SHIFT = 1 << 1,
};

unsigned char kbdus[128] =
{
    0,  27, '1', '2', '3', '4', '5', '6', '7', '8',	/* 9 */
  '9', '0', '-', '=', '\b',	/* Backspace */
  '\t',			/* Tab */
  'q', 'w', 'e', 'r',	/* 19 */
  't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',	/* Enter key */
    0,			/* 29   - Control */
  'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';',	/* 39 */
 '\'', '`',   0,		/* Left shift */
 '\\', 'z', 'x', 'c', 'v', 'b', 'n',			/* 49 */
  'm', ',', '.', '/',   0,				/* Right shift */
  '*',
    0,	/* Alt */
  ' ',	/* Space bar */
    0,	/* Caps lock */
    0,	/* 59 - F1 key ... > */
    0,   0,   0,   0,   0,   0,   0,   0,
    0,	/* < ... F10 */
    0,	/* 69 - Num lock*/
    0,	/* Scroll Lock */
    0,	/* Home key */
    0,	/* Up Arrow */
    0,	/* Page Up */
  '-',
    0,	/* Left Arrow */
    0,
    0,	/* Right Arrow */
  '+',
    0,	/* 79 - End key*/
    0,	/* Down Arrow */
    0,	/* Page Down */
    0,	/* Insert Key */
    0,	/* Delete Key */
    0,   0,   0,
    0,	/* F11 Key */
    0,	/* F12 Key */
    0,	/* All other keys are undefined */
};		

unsigned char kbdus_shift[128] =
{
    0,  27, '!', '@', '#', '$', '%', '^', '&', '*',	/* 9 */
  '(', ')', '_', '+', '\b',	/* Backspace */
  '\t',			/* Tab */
  'Q', 'W', 'E', 'R',	/* 19 */
  'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\n',	/* Enter key */
    0,			/* 29   - Control */
  'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':',	/* 39 */
 '"', '~',   0,		/* Left shift */
 '|', 'Z', 'X', 'C', 'V', 'B', 'N',			/* 49 */
  'M', '<', '>', '?',   0,				/* Right shift */
  '*',
    0,	/* Alt */
  ' ',	/* Space bar */
    0,	/* Caps lock */
    0,	/* 59 - F1 key ... > */
    0,   0,   0,   0,   0,   0,   0,   0,
    0,	/* < ... F10 */
    0,	/* 69 - Num lock*/
    0,	/* Scroll Lock */
    0,	/* Home key */
    0,	/* Up Arrow */
    0,	/* Page Up */
  '-',
    0,	/* Left Arrow */
    0,
    0,	/* Right Arrow */
  '+',
    0,	/* 79 - End key*/
    0,	/* Down Arrow */
    0,	/* Page Down */
    0,	/* Insert Key */
    0,	/* Delete Key */
    0,   0,   0,
    0,	/* F11 Key */
    0,	/* F12 Key */
    0,	/* All other keys are undefined */
};

uint32_t keyboard_state = 0;

void keyboard_interrupt_handler()
{
    uint8_t scancode = inb(0x60);
    if (scancode & 0x80)
    {
        // Key release
        scancode ^= 0x80;
        if (scancode == SCANCODE_LEFT_SHIFT || scancode == SCANCODE_RIGHT_SHIFT)
        {
            keyboard_state &= ~KEYBOARD_STATE_SHIFT;
        }
    }
    else
    {
        bool is_special = false;

        // Key press
        if (scancode == SCANCODE_CAPSLOCK)
        {
            keyboard_state ^= KEYBOARD_STATE_CAPSLOCK;
            is_special = true;
        }
        if (scancode == SCANCODE_LEFT_SHIFT || scancode == SCANCODE_RIGHT_SHIFT)
        {
            keyboard_state |= KEYBOARD_STATE_SHIFT;
            is_special = true;
        }

        if (!is_special)
        {
            char c;
            if (keyboard_state & KEYBOARD_STATE_SHIFT)
            {
                c = kbdus_shift[scancode];
            }
            else
            {
                c = kbdus[scancode];
            }

            if (keyboard_state & KEYBOARD_STATE_CAPSLOCK)
            {
                // Switch uppercase and lowercase
                if ((c > 0x40 && c < 91) || (c > 0x60 && c < 0x7B))
                {
                    c ^= 0x20;
                }
            }

            vga_writechar(c);
        }
    }

    pic_send_eoi(); 
}
