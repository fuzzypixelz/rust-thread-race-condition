use std::{
    sync::{Mutex, OnceLock},
    thread::{self, JoinHandle},
};

pub static HANDLE: Mutex<OnceLock<JoinHandle<()>>> = Mutex::new(OnceLock::new());

#[no_mangle]
pub extern "C" fn init(n: libc::c_int) {
    let handle = thread::spawn(move || eprintln!("Fibonnaci({n}) = {}", fib(n)));
    HANDLE.lock().unwrap().set(handle).unwrap();

    unsafe { libc::atexit(handler) };
}

extern "C" fn handler() {
    let handle = HANDLE.lock().unwrap().take().unwrap();
    handle.join().unwrap();
    eprintln!("Successfuly joined the thread!");
}

fn fib(n: i32) -> i32 {
    if n <= 1 {
        n
    } else {
        fib(n - 1) + fib(n - 2)
    }
}
