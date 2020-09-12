SECTION "textbox_border_load", ROMX[$4d16], BANK[$3c]
textbox_border_load::
    ld a, BANK(gfx_textbox_border)
    ld hl, gfx_textbox_border
    ld de, $8900
    ld bc, gfx_textbox_border.end - gfx_textbox_border
    call vram_copy
    jp farcall_ret
