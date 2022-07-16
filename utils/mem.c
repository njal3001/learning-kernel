#include "mem.h"

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
