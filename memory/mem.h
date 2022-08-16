#pragma once
#include <stdint.h>
#include <stddef.h>

#define MEM_REGION_FREE 0x1
#define MEM_REGION_RESERVED 0x2

struct mem_region
{
    uint64_t base;
    uint64_t length;
    uint32_t type;
    uint32_t attrib;
};

void memcpy(void *dest, const void *src, size_t n);
void memset16(void *dest, uint16_t val, size_t n);

void print_memory_map();
