lb: macro
    ld \1, ((\2) & $ff) << 8 | ((\3) & $ff)
endm

ln: macro
    ld \1, ((\2) & $f) << 4 | ((\3) & $f)
endm

ld16: macro
    ld a, LOW(\2)
    ld [\1 + 0], a
    ld a, HIGH(\2)
    ld [\1 + 1], a
endm


farcall: macro
    push af
    ld a, LOW(\1)
    ld [w_farcall_target + 0], a
    ld a, HIGH(\1)
    ld [w_farcall_target + 1], a
    ld a, BANK(\1)
    ld [w_bank_temp], a
    pop af
    call _farcall
endm

farjp: macro
    push af
    ld a, LOW(\1)
    ld [w_farcall_target + 0], a
    ld a, HIGH(\1)
    ld [w_farcall_target + 1], a
    ld a, BANK(\1)
    ld [w_bank_temp], a
    pop af
    jp _farjp
endm


push_bank_rom: macro
    ld a, [w_bank_rom]
    push af
    ld a, \1
    ld [w_bank_rom], a
    ld [rROMB0], a
endm

pop_bank_rom: macro
    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
endm
