#include "idt.h"

struct idt_entry idt[256];
struct idt_descriptor idt_descriptor = { sizeof(idt) - 1, idt };
