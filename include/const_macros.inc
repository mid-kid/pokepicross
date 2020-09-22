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
