/*
 * The Rux kernel entry point.
 */


#![no_std]      // no standard library linkage
#![no_main]     // disable all rust entry points


use core::panic::PanicInfo;


/// Function that gets called on panic, required by rust compiler without
/// std linkage.
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}


/// True entry point of Rux that overwrites the default starting point
/// required by rust runtime kickstarter.
/// 
/// Use `extern "C"` to ensure C calling convention to get kickstarted
/// correctly.
#[no_mangle]    // don't mangle the name of this function
pub extern "C" fn _start() -> ! {
    loop {}
}
