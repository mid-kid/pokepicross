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

    if not message:
        return None

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
            if constant:
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
    return "    dw " + ", ".join(["$%04x" % val for val in values])

message = None
def print_message():
    global message
    if message is not None:
        text = convert_message(message)
        if text is not None:
            print(text)
    message = ""

has_val = False
for i, line in enumerate(open(filename)):
    if i == 0 and not line.startswith(".org"):
        print("SECTION \"%s\", ROMX" % filename)

    if line.startswith("#"):
        continue

    if line.startswith("[") and line.endswith("]\n"):
        print_message()
        if has_val:
            print("    db $00")
            has_val = False
        print("\n%s::" % line[1:-2])
        continue

    if line.startswith(".val "):
        split = line.split(" ", 1)
        if len(split) < 2:
            continue
        value = int(split[1].strip(), 0)

        print_message()
        print("    dw $%04x" % value)
        has_val = True
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

        print_message()
        if has_val:
            print("    db $00")
            has_val = False
        message = None

        if i != 0:
            print()
        print("SECTION \"%s %s:%s\", ROMX[$%s], BANK[$%s]" %
                (filename, bank, addr, addr, bank))
        continue

    if message is not None:
        message += line

print_message()
if has_val:
    print("    db $00")
