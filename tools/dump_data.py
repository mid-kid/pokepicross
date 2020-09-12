#!/usr/bin/env python3

from sys import argv

file = open("DMGAKVJ0.1", "rb").read()

bank = int(argv[1], 16)
addr = int(argv[2], 16)
len = int(argv[3], 16)

offset = addr
if bank > 0:
    offset += 0x4000 * (bank - 1)

print("    db ", end="")
for x in range(len):
    print("$%02x, " % file[offset + x], end="")
print()
