#!/usr/bin/env python3

from sys import argv

file = open("DMGAKVJ0.1", "rb").read()

multistring = False
if argv[1] == "-m":
    argv.pop(1)
    multistring = True

bank = int(argv[1], 16)
addr = int(argv[2], 16)
count = 1
if len(argv) > 3:
    count = int(argv[3], 0)

offset = addr
if bank > 0:
    offset += 0x4000 * (bank - 1)

charmap = {}
for line in open("include/charmap.inc"):
    if line.startswith("charmap "):
        split = line.split(";")[0].split(" ", 1)[1].split(",")
        if len(split) != 2:
            continue

        char = split[0].strip()
        value = int(split[1].strip())

        if not char.startswith("\"") or not char.endswith("\""):
            continue
        char = char[1:-1]

        charmap[value] = char

for x in range(count):
    bank = offset // 0x4000
    addr = offset % 0x4000
    if bank > 0:
        addr += 0x4000

    print("string_%02x_%04x::" % (bank, addr))
    while True:
        if multistring:
            if file[offset] == 0:
                offset += 1
                print("    db 0\n")
                break
            val = file[offset] | (file[offset + 1] << 8)
            print("    dw %d" % val)
            offset += 2

        print("    text \"", end="")
        while True:
            value = file[offset] | (file[offset + 1] << 8)
            offset += 2

            if value == 0xffff:
                break
            elif value == 0xfffe:
                print("\"\n    line \"")
                continue

            if value in charmap:
                print(charmap[value], end="")
            else:
                print("<%02x>" % value, end="")

        print("\"\n    done")
        if not multistring:
            print()
            break
