print_hex:
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

    print_loop:
        ; Copy lower part of hex value
        mov al, bh

        ; Get current digit
        and al, 0xf0
        shr al, 4

        ; Convert to ascii
        add al, 0x30
        ; Check if value is 0-9 or a-f
        cmp al, 0x3a

        jl print_loop_end 

        ; Add another offset if a-f
        add al, 0x27

        print_loop_end:
        ; Print character
        int 0x10
        
        ; Check if loop is done
        inc cx
        cmp cx, 4
        je print_end

        ; Shift to next digit
        shl bx, 4

        jmp print_loop
    

    print_end:

    ; Print newline and carriage return
    mov al, 10
    int 0x10
    mov al, 13
    int 0x10

    popa
    ret
