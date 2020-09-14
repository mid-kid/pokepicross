INCLUDE "charmap.inc"
INCLUDE "macros.inc"

SECTION "text_char", ROMX[$4bf7], BANK[$02]
far_textbox_print_char::
    farcall textbox_print_char
    jp farcall_ret

; Returns:
; flags - z if reached end of string
textbox_print_char::
    ld a, [w_c342]
    bit 0, a
    jp nz, farcall_ret

    ld a, [w_textbox_cur_string + 0]
    ld l, a
    ld a, [w_textbox_cur_string + 1]
    ld h, a
    ld a, [w_textbox_cur_x]
    ld b, a
    ld a, [w_textbox_cur_y]
    ld c, a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]

    ; Check if we've reached the end of the string
    ld d, a
    and e
    cp TX_END
    jp z, farcall_ret
    push hl

    ; Check for line feed
    ld a, e
    cp LOW(TX_LF)
    jr nz, .not_line_feed
    ld a, d
    cp HIGH(TX_LF)
    jr z, .line_feed
.not_line_feed

    ; Draw ピ one pixel higher
    ld a, e
    cp "ピ"
    jr nz, .not_pi
    ld a, d
    and a
    jr nz, .not_pi
    dec c
.not_pi

    ; Draw character
    farcall textbox_draw_char

    ; Leave two pixels space between each character
    ld hl, w_textbox_cur_x
    add 2
    add [hl]
    ld [hl], a
    jr .done

.line_feed
    ; Advance to the next line
    ld a, [w_textbox_x]
    ld [w_textbox_cur_x], a
    ld a, [w_textbox_cur_y]
    add 11
    ld [w_textbox_cur_y], a

.done
    ; Back up string pointer
    pop hl
    ld16 w_textbox_cur_string, hl

    ; Check if the next character is a terminator
    ld a, [hl+]
    and [hl]
    cp TX_END
    jp farcall_ret

; Returns:
; a - character width
; Parameters:
; de - character to print
; b - x position
; c - y position
textbox_draw_char::
    push de

    ; Get char address
    sla e
    rl d
    ld hl, text_chars_offsets
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, gfx_text_chars_dark
    add hl, de
    ld16 w_vwf_char_addr, hl
    ld a, BANK(gfx_text_chars_dark)
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

SECTION "textbox_delay", ROMX[$5b7a], BANK[$02]
textbox_delay::
    ld a, [w_c343]
    bit 4, a
    jr nz, .no_blink
    ld a, [w_textbox_cur_x]
    sub 3
    ld b, a
    ld a, [w_textbox_cur_y]
    inc a
    ld c, a
    ld a, $e9
    call function_00_208c
.no_blink
    ld hl, w_textbox_delay_timer
    dec [hl]
    jp farcall_ret
