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

In the CPU, there are certain flags which help it keep track of what just happened; for instance, if you use 'cmp ax, 4' it will compare the two and store that as a flag for what may come next. Here are conditional jmp (jump) instructions, used after comparison, which can take advantage of this flag. 
je target  > jump if equal ( i.e. x == y)
jne target > jump if not equal ( i.e. x != y)
jl target  > jump if less than ( i.e. x < y)
jle target > jump if less than or equal ( i.e. x <= y)
jg target  > jump if greater than ( i.e. x > y)
jge target > jump if greater than or equal ( i.e. x >= y)
These allow you to skip certain pieces of code by jumping to delimiters or scope symbols in your non-compiled code, each of which may be it's own location that can be jumped to on specific conditions. 

Functions are handled by the CPU using instructions "call" and "ret" (return), which can be used in assembly to "call" a jump location, which will jump to that point, storing the "from" address on the stack; when "ret" is called, it will pop that address off the stack and jump back to it. 
Because it is storing the address on the stack, jumping from a function into a deeper function should still work, since ret can then be called multiple times to get back to origin. As for the registers you may be using to store data, "pusha" and "popa" will let you push and pop ALL registers to and from the stack, so you can retain the values of variables before and after doing work inside other functions. 

%include is a keyword in NASM that allows you to include entire assembly files inside of this one; because of this, you can make small assembly bits that do particular things, then include them into your existing project to make it more human-readable and reduce your workload. Example:
%include "useful_function.asm" ; this will be replaced by the code inside the quoted assembly file. 

General-Purpose registers allow you to manipulate and compare data quickly and easily. They are named and used as follows:
AX (Accumulator): Often used for arithmetic operations, I/O operations, and interrupt calls.
BX (Base Register): Commonly used as a pointer to data (base pointer for data segment).
CX (Count Register): Often used as a loop counter due to its role in loop and string instructions.
DX (Data Register): Frequently used for I/O operations, especially when dealing with word-sized data, and sometimes used in conjunction with AX for operations requiring more than 16 bits.