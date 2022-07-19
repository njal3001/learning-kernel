KERNEL := kernel
DRIVERS := drivers
BOOT := boot
UTILS := utils

TARGET := i686-elf

C_SRC = $(wildcard ${KERNEL}/*.c ${DRIVERS}/*.c ${UTILS}/*.c)
UTILS_HEADERS = $(wildcard ${UTILS}/*.h)
HEADERS = ${UTILS_HEADERS} $(wildcard ${KERNEL}/*.h ${DRIVERS}/*.h)

C_FILE = $(notdir $(C_SRC))
C_OBJ = ${C_FILE:.c=.o}

all: pixelos.bin

run: pixelos.bin
	qemu-system-x86_64 -drive format=raw,file=$<

clean:
	rm *.o *.bin

pixelos.bin: everything.bin zeroes.bin
	cat $^ > $@

everything.bin: boot_sect.bin full_kernel.bin
	cat $^ > $@

full_kernel.bin: kernel_entry.o interrupt.o ${C_OBJ}
	${TARGET}-ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o : $(KERNEL)/%.c ${HEADERS}
	${TARGET}-gcc -ffreestanding -m32 -g -c $< -o $@
	
%.o : $(DRIVERS)/%.c ${UTILS_HEADERS}
	${TARGET}-gcc -ffreestanding -m32 -g -c $< -o $@

%.o : $(UTILS)/%.c
	${TARGET}-gcc -ffreestanding -m32 -g -c $< -o $@

interrupt.o: ${KERNEL}/interrupt.asm
	nasm $^ -f elf -o $@

kernel_entry.o: ${KERNEL}/kernel_entry.asm
	nasm $^ -f elf -o $@

boot_sect.bin: ${BOOT}/boot_sect.asm ${BOOT}/bios_utils.asm
	nasm $< -f bin -o $@

zeroes.bin: ${BOOT}/zeroes.asm
	nasm $< -f bin -o $@

