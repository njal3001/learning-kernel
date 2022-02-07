#pragma once
#include <stddef.h>
#include <stdint.h>

size_t strlen(const char *s);
void memcpy(void *dest, const void *src, const size_t n);
void memset16(void *dest, const uint16_t val, const size_t n);
int max(const int a, const int b);
