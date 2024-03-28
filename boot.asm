[org 0x7c00] ; This tells us that the code is expected to be loaded to address 0x7c00, which is the address at which BIOS loads the bootloader. This prevents having to calculate addresses so much. 
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

welcome_message:
    db 'Deez Nutz! ',0

times 510-($-$$) db 0

dw 0xaa55
 ; nasm boot.asm -f bin -o boot.bin      to compile
 ; qemu-system-x86_64 boot.bin           to run