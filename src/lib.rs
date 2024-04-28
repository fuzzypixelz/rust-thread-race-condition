use std::{
    sync::{Mutex, OnceLock},
    thread::{self, JoinHandle},
    time::Duration,
};

pub static DUMMY: Dummy = Dummy::new();

pub struct Dummy(Mutex<OnceLock<JoinHandle<()>>>);

impl Dummy {
    const fn new() -> Self {
        Self(Mutex::new(OnceLock::new()))
    }
}

#[no_mangle]
pub extern "C" fn init(timeout: libc::c_int) {
    let handle = thread::spawn(move || {
        thread::sleep(Duration::from_secs(timeout as u64));
    });
    DUMMY.0.lock().unwrap().set(handle).unwrap();

    unsafe { libc::atexit(handler) };
}

extern "C" fn handler() {
    let handle = DUMMY.0.lock().unwrap().take().unwrap();
    handle.join().unwrap();
}
