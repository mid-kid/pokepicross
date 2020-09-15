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


RGB: macro
    rept _NARG / 3
        dw palred (\1) + palgreen (\2) + palblue (\3)
        shift 3
    endr
endm

palred   EQUS "(1 << 0) *"
palgreen EQUS "(1 << 5) *"
palblue  EQUS "(1 << 10) *"

palettes EQUS "* PALETTE_SIZE"
palette  EQUS "+ PALETTE_SIZE *"
color    EQUS "+ PAL_COLOR_SIZE *"

tiles EQUS "* $10"


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


const_def: macro
if _NARG >= 1
const_value = \1
else
const_value = 0
endc
if _NARG >= 2
const_inc = \2
else
const_inc = 1
endc
endm

const: macro
\1 EQU const_value
const_value = const_value + const_inc
endm

shift_const: macro
\1 EQU (1 << const_value)
const_value = const_value + const_inc
endm

const_skip: macro
if _NARG >= 1
const_value = const_value + const_inc * (\1)
else
const_value = const_value + const_inc
endc
endm

const_next: macro
if (const_value > 0 && \1 < const_value) || (const_value < 0 && \1 > const_value)
fail "const_next cannot go backwards from {const_value} to \1"
else
const_value = \1
endc
endm

const_dw: macro
    const \1
    dw \2
endm
