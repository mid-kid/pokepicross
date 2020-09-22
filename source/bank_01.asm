INCLUDE "code_macros.inc"
INCLUDE "const_macros.inc"
INCLUDE "gfx_macros.inc"
INCLUDE "level_constants.inc"
INCLUDE "puzzle_constants.inc"

SECTION "text_2_char_draw", ROMX[$5e3c], BANK[$01]

puzzle_name_textbox_clear:
    xor a
    ld [w_dbe4], a

.loop
    ld16 w_vwf_char_addr, gfx_blank_char
    ld a, BANK(gfx_blank_char)
    ld [w_vwf_char_bank], a
    ld a, [w_dbe4]
    add a
    add a
    add a
    add 40
    ld [w_vwf_char_start_x], a
    add 7
    ld [w_vwf_char_end_x], a
    ld a, 15
    ld [w_vwf_char_start_y], a
    ld a, 26
    ld [w_vwf_char_end_y], a
    call vwf_char_draw

    ld a, [w_dbe4]
    inc a
    ld [w_dbe4], a
    cp 11
    jp nz, .loop
    ret

SECTION "calc_town_map_puzzle_index", ROMX[$61FA], BANK[$01]
calc_town_map_puzzle_index::
    ld a, [w_town_map_level]
    cp LEVEL_MEW
    jr nz, .not_mew
    ld a, PUZZLE_MEW
    jp farcall_ret

.not_mew
    ld a, [w_town_map_y]
    ld c, a
    add a
    add a
    add c
    ld c, a
    ld a, [w_town_map_x]
    add c
    ld c, a
    ld a, [w_town_map_level]
    add a
    add a
    add a
    add a
    add c
    ld c, a
    ld a, [w_town_map_level]
    xor $ff
    inc a
    add c
    add TOWN_MAP_PUZZLES
    jp farcall_ret

SECTION "function_01_6306", ROMX[$6306], BANK[$01]
function_01_6306::
    ld c, 16
.loop
    push bc
    push hl
    push de
    push af
    ld bc, 8 tiles
    call vram_copy
    farcall function_05_7089
    pop af
    pop de
    pop hl
    push hl
    ld hl, 8 tiles
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld bc, 8 tiles
    add hl, bc
    pop bc
    dec c
    jp nz, .loop
    ret
