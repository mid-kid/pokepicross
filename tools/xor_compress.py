#!/usr/bin/env python3

# Usage: ./xor_compress.py [source.bin] [dest.bin.xor]

import sys

with (open(sys.argv[1], 'rb') if len(sys.argv) > 1 else sys.stdin) as f:
    data = f.read()

n = len(data) 
output = []
v = 0
i = 0

while i < n:
    val = data[i]
    i += 1

    if data[i] == v: #>=0x80
        # Alternating (>= 0x80)
        # Run stops at 0x81 bytes or when the values stop alternating
        size = 1
        while i < n and size < 0x81 and data[i] == (v if size % 2 else val):
            size += 1
            i += 1
        output.append(size + 0x7e)
        output.append(v ^ val)
        if size % 2:
            v = val

    else:
        # Sequential (< 0x80)
        # Run stops at 0x80 bytes or when the value two ahead is equal to v
        buffer = [v ^ val]
        while i < n:
            v = val
            if len(buffer) > 0x7f or (i + 1 < n and data[i + 1] == v):
                break
            val = data[i]
            buffer.append(v ^ val)
            i += 1
        output.append(len(buffer) - 1)
        output.extend(buffer)

with (open(sys.argv[2], 'wb') if len(sys.argv) > 2 else sys.stdout) as f:
    f.write(bytes(output))
