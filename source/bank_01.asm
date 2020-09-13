INCLUDE "macros.inc"

SECTION "text_2_char_draw", ROMX[$5e3c], BANK[$01]

level_name_textbox_clear:
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
