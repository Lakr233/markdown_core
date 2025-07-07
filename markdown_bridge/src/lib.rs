use markdown::Constructs;
use std::ffi::{c_char, CStr, CString};

#[no_mangle]
pub extern "C" fn markdown_core_parse_to_mdast_json(c_str: *const c_char) -> *mut c_char {
    if c_str.is_null() {
        return std::ptr::null_mut();
    }

    use markdown::to_mdast;
    let c_str = unsafe { CStr::from_ptr(c_str) };
    let r_str = match c_str.to_str() {
        Ok(s) => s,
        Err(_) => return std::ptr::null_mut(),
    };

    let mut options = markdown::ParseOptions::default();

    options.constructs = Constructs {
        math_flow: true,
        math_text: true,
        ..Constructs::gfm()
    };

    let options = &options;
    let mdast = match to_mdast(r_str, options) {
        Ok(tree) => tree,
        Err(_) => return std::ptr::null_mut(),
    };

    let json = match serde_json::to_string(&mdast) {
        Ok(json_str) => json_str,
        Err(_) => return std::ptr::null_mut(),
    };

    match CString::new(json) {
        Ok(cstring) => cstring.into_raw(),
        Err(_) => std::ptr::null_mut(),
    }
}

#[no_mangle]
pub extern "C" fn markdown_core_free_str(ptr: *mut c_char) {
    if ptr.is_null() {
        return;
    }
    unsafe {
        let _ = CString::from_raw(ptr);
    }
}
