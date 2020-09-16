const PROGRAM_NAME: &str = "xor_compress";

fn read_files(filenames: &[String]) -> Result<Vec<u8>, (&String, std::io::Error)> {
    let mut data = Vec::new();
    for filename in filenames.iter() {
        match std::fs::read(filename) {
            Ok(bytes) => data.extend(&bytes),
            Err(err)  => return Err((filename, err)),
        }
    }
    Ok(data)
}

fn write_compressed(filename: &String, data: Vec<u8>) -> Result<u32, std::io::Error> {
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

    match std::fs::write(filename, &output[..]) {
        Ok(()) => Ok(runs),
        Err(err) => Err(err),
    }
}

fn main() {
    let mut args: Vec<String> = std::env::args().skip(1).collect();

    let mut verbose = false;
    if !args.is_empty() && args[0] == "-v" {
        verbose = true;
        args.remove(0);
    }

    if args.len() < 2 {
        eprintln!("Usage: {} [-v] file... files.xor", PROGRAM_NAME);
        std::process::exit(1);
    }

    let out_filename = args.pop().unwrap();
    let data = match read_files(&args[..]) {
        Ok(data) => data,
        Err((filename, err)) => {
            eprintln!("{}: {}: {}", PROGRAM_NAME, filename, err);
            std::process::exit(err.raw_os_error().unwrap_or(1));
        }
    };
    if !data.is_empty() {
        match write_compressed(&out_filename, data) {
            Ok(runs) => if verbose {
                println!("{}: {}: ld bc, ${:x}", PROGRAM_NAME, out_filename, runs);
            },
            Err(err) => {
                eprintln!("{}: {}: {}", PROGRAM_NAME, out_filename, err);
                std::process::exit(err.raw_os_error().unwrap_or(1));
            },
        }
    }
}
