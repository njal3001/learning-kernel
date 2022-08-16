#include "mem.h"
#include "../drivers/vga_text.h"

#define MMA 0x8004
#define MM_LENGTH_ADDRESS 0x9000

struct mem_region *memory_map = (struct mem_region*)MMA;

void memcpy(void *dest, const void *src, size_t n)
{
    char* d = dest;
    const char* s = src;

    for (size_t i = 0; i < n; i++)
    {
        d[i] = s[i];
    }
}

void memset16(void *dest, uint16_t val, size_t n)
{
    uint16_t* d = dest;

    for (size_t i = 0; i < n; i++)
    {
        d[i] = val;
    }
}

void print_memory_map()
{
    uint16_t mm_length = *(uint16_t*)MM_LENGTH_ADDRESS;
    vga_writestring("Memory Map:\n");
    for (uint16_t i = 0; i < mm_length; i++)
    {
        vga_writestring("\nBase Address: ");
        vga_writeint(memory_map[i].base, FORMAT_HEX);
        vga_writestring(" | Length: ");
        vga_writeint(memory_map[i].length, FORMAT_HEX);

        uint32_t type = memory_map[i].type;
        vga_writestring(" | Type: ");

        switch (type)
        {
            case MEM_REGION_FREE:
                vga_writestring("Free memory (1)");
                break;
            case MEM_REGION_RESERVED:
                vga_writestring("Reserved memory (2)");
                break;
            default:
                vga_writestring("Unknown (");
                vga_writeint(type, FORMAT_DEC);
                vga_writestring(")");
                break;
        }
    }
};

