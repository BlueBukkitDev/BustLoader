A bootloader is a sector of 512 bytes that ends in 0xaa55
The BIOS loads the bootloader into memory at address 0x7c00, which is far enough down the line to prevent overwriting the BIOS routines (which would cause a crash). 
