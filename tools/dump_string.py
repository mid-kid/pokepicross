#!/usr/bin/env python3

from sys import argv
from charmap import parse_charmap

file = open("DMGAKVJ0.1", "rb").read()

bank = int(argv[1], 16)
addr = int(argv[2], 16)

offset = addr
if bank > 0:
    offset += 0x4000 * (bank - 1)

o_charmap, constants = parse_charmap("data/charmap.txt")
charmap = {}
for char in o_charmap:
    if o_charmap[char] not in charmap:
        charmap[o_charmap[char]] = char

while True:
    value = file[offset] | (file[offset + 1] << 8)
    offset += 2

    if value == 0xffff:
        print()
        break
    elif value == 0xfffe:
        print()
        continue

    if value in charmap:
        print(charmap[value], end="")
    else:
        print("<%02x>" % value, end="")
