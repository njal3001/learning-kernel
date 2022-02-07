C_SRC = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

C_FILE = $(notdir $(C_SRC))
C_OBJ_TEMP = ${C_FILE:.c=.o}
C_OBJ = $(addprefix $(BUILD)/, $(C_OBJ_TEMP))

BUILD := build
KERNEL := kernel
DRIVERS := drivers
BOOT := boot

all: $(BUILD)/pixelos.bin
	qemu-system-x86_64 -drive format=raw,file=$<

$(BUILD)/pixelos.bin: $(BUILD)/everything.bin $(BUILD)/zeroes.bin
	cat $^ > $@

$(BUILD)/everything.bin: $(BUILD)/boot_sect.bin $(BUILD)/full_kernel.bin
	cat $^ > $@

$(BUILD)/full_kernel.bin: $(BUILD)/kernel_entry.o ${C_OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

$(BUILD)/%.o : $(KERNEL)/%.c ${HEADERS}
	i386-elf-gcc -ffreestanding -m32 -g -c $< -o $@
	
$(BUILD)/%.o : $(DRIVERS)/%.c ${HEADERS}
	i386-elf-gcc -ffreestanding -m32 -g -c $< -o $@

$(BUILD)/kernel_entry.o: kernel/kernel_entry.asm
	nasm $^ -f elf -o $@

$(BUILD)/boot_sect.bin: boot/boot_sect.asm boot/bios_utils.asm
	nasm $< -f bin -o $@

$(BUILD)/zeroes.bin: boot/zeroes.asm
	nasm $< -f bin -o $@

