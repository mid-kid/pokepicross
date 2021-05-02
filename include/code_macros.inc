macro lb
    ld \1, ((\2) & $ff) << 8 | ((\3) & $ff)
endm

macro ln
    ld \1, ((\2) & $f) << 4 | ((\3) & $f)
endm

macro ld16
    ld a, LOW(\2)
    ld [\1 + 0], a
    ld a, HIGH(\2)
    ld [\1 + 1], a
endm


macro farcall
    push af
    ld16 w_farcall_target, \1
    ld a, BANK(\1)
    ld [w_bank_temp], a
    pop af
    call _farcall
endm

macro farjp
    push af
    ld16 w_farcall_target, \1
    ld a, BANK(\1)
    ld [w_bank_temp], a
    pop af
    jp _farjp
endm


macro push_bank_rom
    ld a, [w_bank_rom]
    push af
    ld a, \1
    ld [w_bank_rom], a
    ld [rROMB0], a
endm

macro pop_bank_rom
    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
endm
