#pragma once
#include <stdint.h>

#define PIC1_COMMAND_PORT   0x20
#define PIC2_COMMAND_PORT   0xA0
#define PIC1_DATA_PORT      0x21
#define PIC2_DATA_PORT      0xA1
#define PIC_EOI             0x20

#define ICW1_INIT           0x10
#define ICW1_ICW4           0x01
#define ICW4_8086           0x01

void pic_remap();
void irq_set_mask(uint8_t mask);
void pic_send_eoi();
