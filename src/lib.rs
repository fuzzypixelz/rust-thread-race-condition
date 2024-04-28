use std::{
    sync::{Mutex, OnceLock},
    thread::{self, JoinHandle},
    time::Duration,
};

pub static HANDLE: Mutex<OnceLock<JoinHandle<()>>> = Mutex::new(OnceLock::new());

#[no_mangle]
pub extern "C" fn init(timeout: libc::c_int) {
    let handle = thread::spawn(move || {
        thread::sleep(Duration::from_millis(timeout as u64));
    });
    HANDLE.lock().unwrap().set(handle).unwrap();

    unsafe { libc::atexit(handler) };
}

extern "C" fn handler() {
    let handle = HANDLE.lock().unwrap().take().unwrap();
    handle.join().unwrap();
    eprintln!("Successfuly joined the thread!");
}
