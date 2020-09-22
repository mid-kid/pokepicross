SECTION "textbox_border_load", ROMX[$4d16], BANK[$3c]
textbox_border_load::
    ld a, BANK(gfx_textbox_border_dark)
    ld hl, gfx_textbox_border_dark
    ld de, $8900
    ld bc, gfx_textbox_border_dark.end - gfx_textbox_border_dark
    call vram_copy
    jp farcall_ret

SECTION "calc_easy_picross_puzzle_index", ROMX[$649d], BANK[$3c]
calc_easy_picross_puzzle_index::
    ld a, [w_easy_picross_y]
    ld c, a
    add a
    add a
    add c
    ld c, a
    ld a, [w_easy_picross_x]
    add c
    jp farcall_ret
