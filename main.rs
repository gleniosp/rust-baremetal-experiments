#![no_std]
#![no_main]

use core::panic::PanicInfo;

#[no_mangle]
pub unsafe extern "C" fn start_here() -> ! {
    let mut _counter: u32 = 47;

    loop {
        _counter = _counter + 1;
    }
}

// A panic handler is required for #![no_std]
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
