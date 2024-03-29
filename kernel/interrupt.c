#include "interrupt.h"
#include "idt.h"
#include "../drivers/pic.h"
#include "../drivers/vga_text.h"

extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();
extern void isr8();
extern void isr9();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();

extern void timer_interrupt_wrapper();
extern void keyboard_interrupt_wrapper();

void init_interrupts()
{
    idt_load();

    // Interrupt service routines
    idt_set_gate(0,  (uint32_t)isr0,  IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(1,  (uint32_t)isr1,  IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(2,  (uint32_t)isr2,  IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(3,  (uint32_t)isr3,  IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(4,  (uint32_t)isr4,  IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(5,  (uint32_t)isr5,  IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(6,  (uint32_t)isr6,  IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(7,  (uint32_t)isr7,  IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(8,  (uint32_t)isr8,  IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(9,  (uint32_t)isr9,  IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(10, (uint32_t)isr10, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(11, (uint32_t)isr11, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(12, (uint32_t)isr12, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(13, (uint32_t)isr13, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(14, (uint32_t)isr14, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(15, (uint32_t)isr15, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(16, (uint32_t)isr16, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(17, (uint32_t)isr17, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(18, (uint32_t)isr18, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(19, (uint32_t)isr19, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(20, (uint32_t)isr20, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(21, (uint32_t)isr21, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(22, (uint32_t)isr22, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(23, (uint32_t)isr23, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(24, (uint32_t)isr24, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(25, (uint32_t)isr25, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(26, (uint32_t)isr26, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(27, (uint32_t)isr27, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(28, (uint32_t)isr28, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(29, (uint32_t)isr29, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(30, (uint32_t)isr30, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(31, (uint32_t)isr31, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);

    // Hardware interrupts
    pic_remap();

    idt_set_gate(0x20, (uint32_t)timer_interrupt_wrapper, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);
    idt_set_gate(0x21, (uint32_t)keyboard_interrupt_wrapper, IDT_CODE_SELECTOR, IDT_GATE_INTERRUPT_FLAGS);

    // Only allow timer and keyboard interrupts
    irq_set_mask(0xFC);

    // Enable interrupts
    asm volatile ("sti");
}

const char *exception_messages[32] =
{
    "Division By Zero",
    "Debug",
    "Non Maskable Interrupt",
    "Breakpoint",
    "Into Detected Overflow",
    "Out Of Bounds",
    "Invalid Opcode",
    "No Coprocessor",
    "Double Fault",
    "Coprocessor Segment Overrun",
    "Bad TSS",
    "Segment Not Present",
    "Stack Fault",
    "General Protection Fault",
    "Page Fault",
    "Unknown Interrupt",
    "Coprocessor Fault",
    "Alignment Check",
    "Machine Check",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
};

void isr_handler(struct interrupt_info info)
{
    vga_writestring(exception_messages[info.fault_index]);
    vga_writestring(" Exception. System Halted!\n");

    // Print register contents
    // TODO: Should print unsigned
    vga_writestring("\nRegisters:\n");
    vga_writestring("\ngs: ");
    vga_writeint(info.gs, FORMAT_HEX);
    vga_writestring("\nfs: ");
    vga_writeint(info.fs, FORMAT_HEX);
    vga_writestring("\nes: ");
    vga_writeint(info.es, FORMAT_HEX);
    vga_writestring("\nds: ");
    vga_writeint(info.ds, FORMAT_HEX);
    vga_writestring("\nedi: ");
    vga_writeint(info.edi, FORMAT_HEX);
    vga_writestring("\nesi: ");
    vga_writeint(info.esi, FORMAT_HEX);
    vga_writestring("\nebp: ");
    vga_writeint(info.ebp, FORMAT_HEX);
    vga_writestring("\nebx: ");
    vga_writeint(info.ebx, FORMAT_HEX);
    vga_writestring("\nesp: ");
    vga_writeint(info.esp, FORMAT_HEX);
    vga_writestring("\nedx: ");
    vga_writeint(info.edx, FORMAT_HEX);
    vga_writestring("\necx: ");
    vga_writeint(info.ecx, FORMAT_HEX);
    vga_writestring("\neax: ");
    vga_writeint(info.eax, FORMAT_HEX);

    for (;;)
    {
        asm ("hlt");
    }
}
