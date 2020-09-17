#!/usr/bin/env python3

import sys

PROGRAM_NAME = "xor_compress.py"

sys.argv.pop(0)

verbose = sys.argv and sys.argv[0] == '-v'
if verbose:
    sys.argv.pop(0)

if len(sys.argv) < 2:
    print('Usage: %s [-v] file... files.xor' % PROGRAM_NAME, file=sys.stderr)
    exit(1)

out_filename = sys.argv.pop()

data = bytearray()
for filename in sys.argv:
    with open(filename, 'rb') as f:
        data.extend(f.read())

n = len(data)
output = bytearray()
v = 0x00
i = 0
runs = 0

while i < n:
    byte = data[i]
    i += 1
    runs += 1

    if data[i] == v:
        # Alternating (>= 0x80)
        # Run stops at 0x80 bytes or when the values stop alternating
        size = 0
        while i < n and size < 0x80 and data[i] == (byte if size % 2 else v):
            size += 1
            i += 1
        output.append(size + 0x7f)
        output.append(v ^ byte)
        if not size % 2:
            v = byte

    else:
        # Sequential (< 0x80)
        # Run stops at 0x80 bytes or when the value two ahead is equal to v
        buffer = [v ^ byte]
        while i < n:
            v = byte
            if len(buffer) > 0x7f or (i + 1 < n and data[i + 1] == v):
                break
            byte = data[i]
            buffer.append(v ^ byte)
            i += 1
        output.append(len(buffer) - 1)
        output.extend(buffer)

with open(out_filename, 'wb') as f:
    f.write(output)

if verbose:
    print('%s: %s: ld bc, $%x' % (PROGRAM_NAME, out_filename, runs))
