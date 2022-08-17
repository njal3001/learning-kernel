KERNEL := kernel
DRIVERS := drivers
BOOT := boot
MEMORY := memory
UTILS := utils

TARGET := i686-elf

C_SRC = $(wildcard ${KERNEL}/*.c ${DRIVERS}/*.c ${UTILS}/*.c ${MEMORY}/*.c)
HEADERS = $(wildcard ${KERNEL}/*.h ${DRIVERS}/*.h ${UTILS}/*.h ${MEMORY}/*.h)

C_FILE = $(notdir $(C_SRC))
C_OBJ = ${C_FILE:.c=.o}

all: pixelos.bin kernel.elf

run: pixelos.bin
	qemu-system-x86_64 -drive format=raw,file=$<

clean:
	rm *.o *.bin *.elf

pixelos.bin: everything.bin zeroes.bin
	cat $^ > $@

everything.bin: boot_sect.bin kernel.bin
	cat $^ > $@

kernel.bin:	kernel.elf
	${TARGET}-objcopy -O binary $^ $@

# TODO: Don't allow access to all headers from everywhere
kernel.elf: kernel_entry.o interrupt_asm.o gdt_asm.o ${C_OBJ}
	${TARGET}-ld -o $@ -Ttext 0x1000 $^

%.o : $(KERNEL)/%.c ${HEADERS}
	${TARGET}-gcc -ffreestanding -g -m32 -c $< -o $@

%.o : $(DRIVERS)/%.c ${HEADERS}
	${TARGET}-gcc -ffreestanding -g -m32 -c $< -o $@

%.o : $(MEMORY)/%.c
	${TARGET}-gcc -ffreestanding -g -m32 -c $< -o $@

%.o : $(UTILS)/%.c
	${TARGET}-gcc -ffreestanding -g -m32 -c $< -o $@

gdt_asm.o: ${KERNEL}/gdt.asm
	nasm $^ -g -f elf -o $@

interrupt_asm.o: ${KERNEL}/interrupt.asm
	nasm $^ -g -f elf -o $@

kernel_entry.o: ${KERNEL}/kernel_entry.asm
	nasm $^ -g -f elf -o $@

boot_sect.bin: ${BOOT}/boot_sect.asm ${BOOT}/bios_utils.asm
	nasm $< -g -f bin -o $@

zeroes.bin: ${BOOT}/zeroes.asm
	nasm $< -g -f bin -o $@

