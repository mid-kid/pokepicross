INCLUDE "charmap.inc"

SECTION "ASCII credits 1", ROMX[$4010], BANK[$7e]

pushc
setcharmap ascii
    db "DSEQLITE", 0
    db $01
    db "CRTS(C) mcmxcvi by Toshiyuki Ueno", 0
    db "toshi-u@tau.bekkoame.or.jp", 0
popc
