#pragma once
#include <stddef.h>
#include <stdint.h>

size_t strlen(const char *s);
void memcpy(void *dest, const void *src, size_t n);
void memset16(void *dest, uint16_t val, size_t n);
int max(int a, int b);
