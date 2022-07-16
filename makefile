C_SRC = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

C_FILE = $(notdir $(C_SRC))
C_OBJ = ${C_FILE:.c=.o}

KERNEL := kernel
DRIVERS := drivers
BOOT := boot

all: pixelos.bin

run: pixelos.bin
	qemu-system-x86_64 -drive format=raw,file=$<

clean:
	rm *.o *.bin

pixelos.bin: everything.bin zeroes.bin
	cat $^ > $@

everything.bin: boot_sect.bin full_kernel.bin
	cat $^ > $@

full_kernel.bin: kernel_entry.o ${C_OBJ}
	i686-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o : $(KERNEL)/%.c ${HEADERS}
	i686-elf-gcc -ffreestanding -m32 -g -c $< -o $@
	
%.o : $(DRIVERS)/%.c ${HEADERS}
	i686-elf-gcc -ffreestanding -m32 -g -c $< -o $@

kernel_entry.o: ${KERNEL}/kernel_entry.asm
	nasm $^ -f elf -o $@

boot_sect.bin: ${BOOT}/boot_sect.asm boot/bios_utils.asm
	nasm $< -f bin -o $@

zeroes.bin: ${BOOT}/zeroes.asm
	nasm $< -f bin -o $@

