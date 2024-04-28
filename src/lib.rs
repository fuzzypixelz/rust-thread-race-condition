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

pub extern "C" fn init() {
    let handle = thread::spawn(|| {
        thread::sleep(Duration::from_secs(60));
    });
    DUMMY.0.lock().unwrap().set(handle).unwrap();

    unsafe { libc::atexit(handler) };
}

extern "C" fn handler() {
    let handle = DUMMY.0.lock().unwrap().take().unwrap();
    handle.join().unwrap();
}
