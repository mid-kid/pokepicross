SECTION "text_char_draw", ROMX[$4c80], BANK[$02]
; Parameters:
; de - character to print
; b - x position
; c - y position
text_char_draw::
    push de

	; Get char address
    sla e
    rl d
    ld hl, text_chars_offsets
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, gfx_text_chars
    add hl, de
    ld a, l
    ld [w_vwf_char_addr + 0], a
    ld a, h
    ld [w_vwf_char_addr + 1], a
    ld a, BANK(gfx_text_chars)
    ld [w_vwf_char_bank], a

    ld a, b
    ld [w_vwf_char_start_x], a

	; Get character width
    pop de
    ld hl, text_chars_widths
    add hl, de
    ld a, [hl]
    and a
    jp z, farcall_ret

	; Check we aren't drawing outside the textbox
    push af
    add b
    ld hl, w_textbox_width
    cp [hl]
    jr c, .inside_width
    pop af
    jp farcall_ret
.inside_width
    ld [w_vwf_char_end_x], a

    ld a, c
    ld [w_vwf_char_start_y], a
    add 9
    ld hl, w_textbox_height
    cp [hl]
    jr c, .inside_height
    pop af
    jp farcall_ret
.inside_height
    ld [w_vwf_char_end_y], a

    call vwf_char_draw
    pop af
    jp farcall_ret
