/* linker.ld - Tells the compiler where to put the code */
SECTIONS
{
    . = 0x80000000; /* Standard start address for ARM64 QEMU */
    .text.boot : { *(.text.boot) }
    .text : { *(.text) }
    .rodata : { *(.rodata) }
    .data : { *(.data) }
    .bss : { *(.bss) }
}
