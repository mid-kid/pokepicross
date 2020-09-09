#!/usr/bin/env python3

from sys import argv

for line in open(argv[1]):
    split = line.split(";")[0].split(" ")
    if len(split) < 2:
        continue
    name = " ".join(split[1:]).strip()

    split = split[0].split(":")
    if len(split) != 2:
        continue
    bank = int(split[0], 16)
    addr = int(split[1], 16)

    section = None
    bankdec = None
    if bank == 0 and addr >= 0x0000 and addr < 0x4000:
        section = "ROM0"
    elif addr >= 0x4000 and addr < 0x8000:
        section = "ROMX"
        bankdec = bank
    elif addr >= 0x8000 and addr < 0xA000:
        section = "VRAM"
        bankdec = bank
    elif addr >= 0xA000 and addr < 0xC000:
        section = "SRAM"
        bankdec = bank
    elif bank == 0 and addr >= 0xC000 and addr < 0xD000:
        section = "WRAM0"
    elif addr >= 0xD000 and addr < 0xE000:
        section = "WRAMX"
        bankdec = bank
    elif bank == 0 and addr >= 0xFE00 and addr < 0xFEA0:
        section = "OAM"
    elif bank == 0 and addr >= 0xFF80 and addr < 0xFFFF:
        section = "HRAM"
    else:
        continue

    if bankdec is not None:
        bankdec = ", BANK[$%x]" % bankdec
    else:
        bankdec = ""
    print("SECTION \"Shim %s\",%s[$%x]%s" % (name, section, addr, bankdec))
    print("%s::" % name)
