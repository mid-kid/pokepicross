INCLUDE "hardware.inc"

SECTION "vram_copy", ROM0[$0fbd]

; Parameters:
; a - bank
; hl - source
; de - dest
; bc - length
vram_copy::
    ld [w_bank_temp], a
    ld a, [w_bank_rom]
    push af
    ld a, [w_bank_temp]
    ld [w_bank_rom], a
    ld [rROMB0], a

.loop
    ldh a, [rLCDC]
    bit 7, a
    jr z, .in_vblank

.wait_vblank
    ldh a, [rSTAT]
    and $03
    jr z, .wait_vblank

.in_vblank
    ldh a, [rSTAT]
    and $03
    jr nz, .in_vblank

    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    dec bc
    dec bc
    dec bc
    ld a, b
    or c
    jr nz, .loop

    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
    ret
