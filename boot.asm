[bits 16] ; tell the assembler which instructions to generate
[org 0x7c00] ; This tells the assembler that the code is expected to be loaded to address 0x7c00, which is the address at which BIOS loads the bootloader. This prevents having to calculate addresses manually. 

mov bp, 0x8000 ; base pointer of stack at address 0x8000 (arbitrarily chosen)
mov sp, bp ; stack pointer is top of stack; we have set the stack to 0 height. This is how the stack gets initialized.

mov si, welcome_message ; the si register points to the start of the string.
pusha
call print

print:
    mov ah, 0x0e ; int =10/ ah =0 x0e -> BIOS tele - type output
    lodsb ; load string byte (also increments si)
    cmp al, 0 ; check to see if our last byte is null (string was null-terminated)
    je end_of_string
    int 0x10 ; print the character in al
    jmp print ; since we printed, loop back through again

end_of_string:
    popa
    ret ; jump back to original function call

welcome_message:
    db 'Busting Loads...', 0

times 510-($-$$) db 0

dw 0xaa55
 ; nasm boot.asm -f bin -o boot.bin      to compile
 ; qemu-system-x86_64 boot.bin           to run