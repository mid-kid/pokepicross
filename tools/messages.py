#!/usr/bin/env python3

from sys import argv, stderr, exit
from charmap import parse_charmap

def err(s):
    print("ERROR:", s.rstrip(), file=stderr)
    exit(1)

charmap, constants = parse_charmap(argv[1])

filename = argv[2]

def convert_message(message):
    while True:
        if message.endswith("\r\n"):
            message = message[:-2]
            continue
        if message.endswith("\n"):
            message = message[:-1]
            continue
        break

    values = []
    in_braces = False
    constant = ""
    for char in message:
        if char == "{" and not in_braces:
            in_braces = True
            constant = ""
            continue
        if char == "}" and in_braces:
            in_braces = False
            if constant in constants:
                values.append(constants[constant])
            elif constant in charmap:
                values.append(charmap[constant])
            else:
                err("%s: Unrecognized constant %s" % (filename, constant))
            continue

        if in_braces:
            constant += char
            continue

        if char == "\r":
            continue
        if char == "\n":
            values.append(0xfffe)
            continue

        if char in charmap:
            values.append(charmap[char])
        else:
            err("%s: Unrecognized character '%s'" % (filename, char))

    values.append(0xffff)
    return "    dw" + ", ".join(["$%04x" % val for val in values])

name = None
message = None
for i, line in enumerate(open(filename)):
    if i == 0 and not line.startswith(".org"):
        print("SECTION \"%s\", ROMX" % filename)

    if line.startswith("#"):
        continue

    if line.startswith("[") and line.endswith("]\n"):
        if name is not None or message is not None:
            print("\n%s::" % name)
            print(convert_message(message))
        message = ""
        name = line[1:-2]
        continue

    if line.startswith(".org "):
        split = line.split(" ", 1)
        if len(split) < 2:
            continue
        split = split[1].strip().split(":")
        if len(split) != 2:
            continue
        bank = split[0]
        addr = split[1]
        if i != 0:
            print()
        print("SECTION \"%s %s:%s\", ROMX[$%s], BANK[$%s]" %
                (filename, bank, addr, addr, bank))
        continue

    if message is not None:
        message += line

if name is not None and message is not None:
    print("\n%s::" % name)
    print(convert_message(message))
