/**
 * Kernel basic linker script that puts the multiboo2 header section
 * in front of kernel binary.
 */


/** Starts execution at the '_start' symbol as defined in `boot.s`. */
ENTRY(_start)


/** Sections layout. */
SECTIONS
{
    /**
     * Kernel's booting code will be loaded starting at 1MiB address by the
     * bootloader by convention.
     */
    . = 1M;

    .boot ALIGN(4K):        /** Put multiboot header before code. */
    {
        *(.multiboot2)
    }

    .text ALIGN(4K):        /** Align to 4KiB boundary. */
    {
        *(.text)
        *(.comment)
    }

    .rodata ALIGN(4K):
    {
        *(.rodata)
    }

    .data ALIGN(4K):
    {
        *(.data)
    }

    .bss ALIGN(4K):
    {
        *(.bss)     /** Includes our 16KiB temporary stack. */
        *(COMMON)
    }
}
