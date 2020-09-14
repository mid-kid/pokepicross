INCLUDE "hardware.inc"
INCLUDE "macros.inc"

SECTION "function_28_426a", ROMX[$426a], BANK[$28]

function_28_426a::
    ld a, $01
    ld [w_d6b5], a
    ld a, BANK(compressed_gfx_75_7d35)
    ld hl, compressed_gfx_75_7d35
    ld de, _VRAM8800
    ld bc, 182
    call decompress
    ld a, BANK(compressed_tilemap_6c_7eec)
    ld hl, compressed_tilemap_6c_7eec
    ld de, _SCRN0
    ld bc, 82
    call decompress
    call function_00_1085
    ; TBC
