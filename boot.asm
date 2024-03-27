loop:
    mov ah, 0x0e ; int 10/ ah = 0eh -> scrolling teletype BIOS routine
    mov al, 'D'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'z'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'N'
    int 0x10
    mov al, 'u'
    int 0x10
    mov al, 't'
    int 0x10
    mov al, 'z'
    int 0x10
    mov al, '!'
    int 0x10
    mov al, ' '
    int 0x10
    jmp loop

times 510-($-$$) db 0

dw 0xaa55 ; nasm boot.asm -f bin -o boot.bin // the bytes are 170 and 85