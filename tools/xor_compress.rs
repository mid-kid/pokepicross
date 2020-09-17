use std::env::args;
use std::process::exit;
use std::fs::write;
use std::io::{Read, Error};

const PROGRAM_NAME: &str = "xor-compress";

fn read_files(filenames: &[String]) -> Result<Vec<u8>, (&String, Error)> {
    let mut data = Vec::new();
    for filename in filenames {
        match std::fs::File::open(filename) {
            Ok(mut f) => match f.read_to_end(&mut data) {
                Ok(_) => (),
                Err(err) => return Err((filename, err)),
            },
            Err(err) => return Err((filename, err)),
        }
    }
    Ok(data)
}

fn write_compressed(filename: &String, data: &[u8]) -> Result<u32, Error> {
    let n = data.len();

    let mut output = Vec::new();
    let mut v = 0x00;
    let mut i = 0;
    let mut runs = 0;

    while i < n {
        let mut byte = data[i];
        i += 1;
        runs += 1;

        if data[i] == v {
            // Alternating (>= 0x80)
            // Run stops at 0x80 bytes or when the values stop alternating
            let mut size = 0;
            while i < n && size < 0x80 && data[i] == (if size % 2 == 0 { v } else { byte }) {
                size += 1;
                i += 1;
            }
            output.push(size + 0x7f);
            output.push(v ^ byte);
            if size % 2 == 0 {
                v = byte;
            }
        } else {
            // Sequential (< 0x80)
            // Run stops at 0x80 bytes or when the value two ahead is equal to v
            let mut buffer = vec![v ^ byte];
            while i < n {
                v = byte;
                if buffer.len() > 0x7f || (i + 1 < n && data[i + 1] == v) {
                    break;
                }
                byte = data[i];
                buffer.push(v ^ byte);
                i += 1;
            }
            output.push((buffer.len() - 1) as u8);
            output.extend(buffer);
        }
    }

    match write(filename, &output[..]) {
        Ok(()) => Ok(runs),
        Err(err) => Err(err),
    }
}

fn main() {
    let mut argv: Vec<String> = args().skip(1).collect();

    let verbose = !argv.is_empty() && argv[0] == "-v";
    if verbose {
        argv.remove(0);
    }

    if argv.len() < 2 {
        eprintln!("Usage: {} [-v] file... files.xor", PROGRAM_NAME);
        exit(1);
    }

    let out_filename = argv.pop().unwrap();
    let data = match read_files(&argv[..]) {
        Ok(data) => data,
        Err((filename, err)) => {
            eprintln!("{}: {}: {}", PROGRAM_NAME, filename, err);
            exit(err.raw_os_error().unwrap_or(1));
        }
    };
    if !data.is_empty() {
        match write_compressed(&out_filename, &data[..]) {
            Ok(runs) => if verbose {
                println!("{}: {}: ld bc, ${:x}", PROGRAM_NAME, out_filename, runs);
            },
            Err(err) => {
                eprintln!("{}: {}: {}", PROGRAM_NAME, out_filename, err);
                exit(err.raw_os_error().unwrap_or(1));
            },
        }
    }
}
