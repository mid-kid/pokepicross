#!/usr/bin/env python3

from sys import argv
from charmap import parse_charmap

file = open("DMGAKVJ0.1", "rb").read()

bank = int(argv[1], 16)
addr = int(argv[2], 16)
count = 1
if len(argv) > 3:
    count = int(argv[3], 0)

offset = addr
if bank > 0:
    offset += 0x4000 * (bank - 1)

o_charmap, constants = parse_charmap("data/charmap.txt")
charmap = {}
for char in o_charmap:
    if o_charmap[char] not in charmap:
        charmap[o_charmap[char]] = char

print(".org %02x:%04x" % (bank, addr))
for x in range(count):
    bank = offset // 0x4000
    addr = offset % 0x4000
    if bank > 0:
        addr += 0x4000

    print("[message_%02x_%04x]" % (bank, addr))
    while True:
        value = file[offset] | (file[offset + 1] << 8)
        offset += 2

        if value == 0xffff:
            print("\n")
            break
        elif value == 0xfffe:
            print()
            continue

        if value in charmap:
            print(charmap[value], end="")
        else:
            print("<%02x>" % value, end="")
