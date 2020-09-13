INCLUDE "charmap.inc"

text: macro
_arg = 1
    rept _NARG
_WS EQUS \1
_len = STRLEN("{_WS}")
_i = 1
        rept _len
          dw STRSUB("{_WS}", _i, 1)
_i = _i + 1
        endr
        PURGE _WS
        shift
_arg = _arg + 1
    endr
endm
line EQUS "dw TX_LF\n    text"
done EQUS "dw TX_END"
