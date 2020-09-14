#!/usr/bin/env python3

# Usage: ./dump_decompress.py 75:7d35 00b6 >compressed.bin 2>decompressed.bin

from sys import argv, stdout, stderr

file = open("DMGAKVJ0.1", "rb").read()

bank_addr = argv[1].split(':')
bank = int(bank_addr[0], 16)
addr = int(bank_addr[1], 16)
length = int(argv[2], 16)
offset = bank * 0x4000 + (addr & 0x3fff)

output = []
i = offset
v = 0x00
for _1 in range(length):
    byte = file[i]
    i += 1
    if byte < 0x80:
        for _2 in range(byte + 1):
            v ^= file[i]
            output.append(v)
            i += 1
    else:
        for _2 in range(byte - 0x7e):
            v ^= file[i]
            output.append(v)
        i += 1

stdout.buffer.write(bytes(file[offset:i])) # compressed
stderr.buffer.write(bytes(output)) # decompressed
