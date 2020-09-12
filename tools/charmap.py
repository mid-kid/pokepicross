#!/usr/bin/env python3

from sys import argv

def parse_charmap(file):
    charmap = {}
    constants = {}
    for line in open(file):
        split = line.split("#")[0].split("=")
        if len(split) != 2:
            continue

        char = "=".join(split[0:-1]).strip()
        value = int(split[-1].strip(), 0) & 0xFFFF

        if char.startswith("'") and char.endswith("'"):
            charmap[char[1:-1]] = value
        else:
            constants[char] = value
    return charmap, constants

if __name__ == "__main__":
    charmap, constants = parse_charmap(argv[1])

    for char in charmap:
        value = charmap[char]
        print("charmap \"%s\", %d" % (char, value))

    for constant in constants:
        value = constants[constant]
        print("%s EQU %d" % (constant, value))
