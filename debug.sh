if make; then
    qemu-system-x86_64 -drive format=raw,file=pixelos.bin -s -S &
    gdb pixelos.bin -ex 'target remote localhost:1234' -ex 'symbol-file kernel.elf'
fi
