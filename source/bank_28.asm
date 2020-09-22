INCLUDE "hardware.inc"
INCLUDE "code_macros.inc"

SECTION "function_28_426a", ROMX[$426a], BANK[$28]

function_28_426a::
    ld a, $01
    ld [w_d6b5], a
    ld a, BANK(compressed_gfx_copyright)
    ld hl, compressed_gfx_copyright
    ld de, _VRAM8800
    ld bc, $b6
    call decompress
    ld a, BANK(compressed_tilemap_copyright)
    ld hl, compressed_tilemap_copyright
    ld de, _SCRN0
    ld bc, $52
    call decompress
    call function_00_1085
    ; TBC
