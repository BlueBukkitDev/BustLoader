A bootloader is a sector of 512 bytes that ends in 0xaa55

The BIOS loads the bootloader into memory at address 0x7c00, which is far enough down the line to prevent overwriting the BIOS routines (which would cause a crash).

0x0      > Interrupt Vector Table (1kb)
0x400    > BIOS Data Area (256 bytes)
0x500    > Free
0x7c00   > Loaded Boot Sector (512 bytes) this is in the middle of a free area.
0x7e00   > Free
0x9fc00  > Extended BIOS Data Area (936kb)
0xa0000  > Video Memory (128kb) is this the VGA buffer?
0xc0000  > BIOS (256 kb)
0x100000 > Free for everything else. By this point, we have allocated 1MB of space for the BIOS, the instruction set, the bootloader, and the initial video memory.

The memory stack is accessed by CPU instructions "push" and "pop", and is bound by registers bp and sp, which maintain the base (top) and the growing end (base) respectively; this seems counterintuitive at first, but since BIOS and OS  are loaded in at low-value addresses, the stack grows like a stalactite from a higher memory address down toward our core data. If the data grew dangerously high, it could overwrite pieces of the loaded OS, crashing the system from memory errors. 

