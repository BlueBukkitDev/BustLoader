[org 0x7c00] ; This tells us that the code is expected to be loaded to address 0x7c00, which is the address at which BIOS loads the bootloader. This prevents having to calculate addresses so much. 
%include "print.asm"
mov bx, welcome_message
call print

welcome_message:
    db 'Deez Nutz! ',0

times 510-($-$$) db 0

dw 0xaa55
 ; nasm boot.asm -f bin -o boot.bin      to compile
 ; qemu-system-x86_64 boot.bin           to run