// The Rux kernel entry point.
// See https://os.phil-opp.com/freestanding-rust-binary/.


#![no_std]      // no standard library linkage
#![no_main]     // disable all rust entry points


use core::panic::PanicInfo;
use core::arch::global_asm;


// Include bootstrapping code `boot.s`.
global_asm!(include_str!("boot/boot.s"), options(att_syntax));


/// Function that gets called on panic, required by rust compiler without
/// std linkage.
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}


static HELLO_STR: &[u8] = b"Hello, world!";
static VGA_ADDR: u64 = 0xB8000;
static VGA_COLOR: u8 = 0 << 4 | 15;     // Black bg | White fg.

/// True entry point of Rux that overwrites the default starting point
/// required by rust runtime kickstarter.
/// 
/// Use `extern "C"` to ensure C calling convention to get kickstarted
/// correctly.
#[no_mangle]    // don't mangle the name of this function
pub extern "C" fn kernel_main() -> ! {
    let vga_buffer = VGA_ADDR as *mut u8;

    for (i, &byte) in HELLO_STR.iter().enumerate() {
        let offset: isize = i as isize * 2;
        unsafe {    // dangerous!
            *vga_buffer.offset(offset) = byte;
            *vga_buffer.offset(offset + 1) = VGA_COLOR;
        }
    }

    loop {}
}
