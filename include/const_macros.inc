macro const_def
    if _NARG >= 1
        def const_value = \1
    else
        def const_value = 0
    endc
    if _NARG >= 2
        def const_inc = \2
    else
        def const_inc = 1
    endc
endm

macro const
    DEF \1 EQU const_value
    def const_value = const_value + const_inc
endm

macro shift_const
    DEF \1 EQU (1 << const_value)
    def const_value = const_value + const_inc
endm

macro const_skip
    if _NARG >= 1
        def const_value = const_value + const_inc * (\1)
    else
        def const_value = const_value + const_inc
    endc
endm

macro const_next
    if (const_value > 0 && \1 < const_value) || (const_value < 0 && \1 > const_value)
        fail "const_next cannot go backwards from {const_value} to \1"
    else
        def const_value = \1
    endc
endm

macro const_dw
    const \1
    dw \2
endm
