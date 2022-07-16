#pragma once
#include <stdint.h>
#include <stddef.h>

void memcpy(void *dest, const void *src, size_t n);
void memset16(void *dest, uint16_t val, size_t n);
