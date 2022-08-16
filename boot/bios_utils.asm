[bits 16]
; Input
;   bx: Hex value
bios_print_hex:
    pusha

    ; Set print character mode
    mov ah, 0x0e

    ; Loop counter
    mov cx, 0

    ; Print hex start
    mov al, '0'
    int 0x10
    mov al, 'x'
    int 0x10

    bios_print_hex_loop:
        ; Copy lower part of hex value
        mov al, bh

        ; Get current digit
        and al, 0xf0
        shr al, 4

        ; Convert to ascii
        add al, 0x30
        ; Check if value is 0-9 or a-f
        cmp al, 0x3a

        jl bios_print_hex_loop_end

        ; Add another offset if a-f
        add al, 0x27

        bios_print_hex_loop_end:
        ; Print character
        int 0x10

        ; Check if loop is done
        inc cx
        cmp cx, 4
        je bios_print_hex_end

        ; Shift to next digit
        shl bx, 4

        jmp bios_print_hex_loop

    bios_print_hex_end:

    ; Print newline and carriage return
    mov al, 0xa
    int 0x10
    mov al, 0xd
    int 0x10

    popa
    ret

; Input
;   bx: Memory address of string
bios_print_string:
    pusha

    ; Set print character mode
    mov ah, 0x0e

    bios_print_string_loop:
        ; Get current character
        mov al, [bx]

        ; Check if character is null terminator
        cmp al, 0
        je bios_print_string_end

        ; Print character
        int 0x10

        ; Increment string address
        inc bx

        jmp bios_print_string_loop

    bios_print_string_end:

    ; Print newline and carriage return
    mov al, 0xa
    int 0x10
    mov al, 0xd
    int 0x10

    popa
    ret

; Input
;   dl: Selected drive
;   dh: Number of sectors to read
;   bx: Buffer pointer (es:bx)
bios_disk_load:
    pusha

    ; Save number of sectors requested for error comparison
    push dx

    ; Set read sector mode
    mov ah, 0x02
    ; Set number of sectors to read
    mov al, dh
    ; Select cylinder 0
    mov ch, 0x00
    ; Select head 0
    mov dh, 0x00
    ; Read from sector 2, first sector after boot sector
    mov cl, 0x02

    ; Send interrupt
    int 0x13

    ; Get number of sectors read
    pop dx

    ; Error if carry flag is set
    jc bios_disk_load_error

    ; Check if requested number of sectors were read
    cmp dh, al
    ; Error if not matching
    jne bios_disk_load_error

    jmp bios_disk_load_end

    bios_disk_load_error:

    mov bx, DISK_LOAD_ERROR_MSG
    call bios_print_string
    mov bx, ax
    call bios_print_hex

    bios_disk_load_end:

    popa
    ret

; Input
;   es:di: Destination for memory map list
; Output
;   ax: Entry count, 0 if error
bios_get_mmap:
    xor bp, bp ; Entry counter
    xor ebx, ebx
    mov edx, 0x534D4150
    mov eax, 0xE820
    mov ecx, 24
    int 0x15
    jc bios_get_mmap_error

    bios_get_mmap_loop:
        cmp cl, 20
        jne bios_get_mmap_no_extend

        mov [es:di + 20], dword 1 ; Manually add extended attributes

        bios_get_mmap_no_extend:

        add di, 24 ; Increment pointer to next entry
        inc bp ; Increment counter

        ; Get next entry
        mov eax, 0xE820
        mov ecx, 24
        int 0x15

        ; Jump to end if no more entries
        jc bios_get_mmap_end
        cmp bx, 0
        je bios_get_mmap_end

        jmp bios_get_mmap_loop

    bios_get_mmap_error:
    mov ax, 0
    ret

    bios_get_mmap_end:
    mov ax, bp
    ret

DISK_LOAD_ERROR_MSG: db "Disk read error!", 0
