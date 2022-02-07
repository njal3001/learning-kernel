VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; Input:
;   eax: String pointer
print_string:
    pusha

    mov edx, VIDEO_MEMORY ; VG pointer
    mov bh, WHITE_ON_BLACK
    
    print_string_loop:
        mov bl, [eax] ; Get character
        
        ; Check if null terminator is reached
        cmp bl, 0
        je print_string_end

        
        mov [edx], bx ; Upload character to VG
        add edx, 2    ; Increment VG pointer
        add eax, 1    ; Increment string pointer

        jmp print_string_loop

    print_string_end:
    popa
    ret
