run: build/pixelos.bin
	qemu-system-x86_64 -drive format=raw,file=build/pixelos.bin 

build/pixelos.bin: build/everything.bin build/zeroes.bin
	cat build/everything.bin build/zeroes.bin > build/pixelos.bin

build/everything.bin: build/boot_sect.bin build/full_kernel.bin
	cat build/boot_sect.bin build/full_kernel.bin > build/everything.bin

build/full_kernel.bin: build/kernel_entry.o build/kernel.o
	i386-elf-ld -o build/full_kernel.bin -Ttext 0x1000 build/kernel_entry.o build/kernel.o --oformat binary

build/kernel.o: kernel.c
	i386-elf-gcc -ffreestanding -m32 -g -c kernel.c -o build/kernel.o

build/kernel_entry.o: kernel_entry.asm
	nasm kernel_entry.asm -f elf -o build/kernel_entry.o

build/boot_sect.bin: boot_sect.asm
	nasm boot_sect.asm -f bin -o build/boot_sect.bin

build/zeroes.bin: zeroes.asm
	nasm zeroes.asm -f bin -o build/zeroes.bin
