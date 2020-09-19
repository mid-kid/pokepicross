INCLUDE "charmap.inc"
INCLUDE "hardware.inc"
INCLUDE "macros.inc"

SECTION "reset", ROM0[$0000]
reset::
    di
    jp start

SECTION "vblank_wait", ROM0[$0008]
vblank_wait::
    ldh a, [rLCDC]
    bit LCDCF_ON_BIT, a
    ret z
    ld hl, w_vblank_ran
    xor a
    ld [hl], a
.wait
    halt
    ld a, [hl]
    and a
    jr z, .wait
    ret

SECTION "jumptable", ROM0[$0018]
jumptable::
    add a
    pop hl
    ld e, a
    ld d, 0
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld l, e
    ld h, d
    jp hl

SECTION "vblank_interrupt", ROM0[$0040]
vblank_interrupt::
    jp vblank

SECTION "lcd_interrupt", ROM0[$0048]
lcd_interrupt::
    jp lcd

SECTION "timer_interrupt", ROM0[$0050]
timer_interrupt::
    jp timer

SECTION "serial_interrupt", ROM0[$0058]
serial_interrupt::
    jp serial

SECTION "joypad_interrupt", ROM0[$0060]
joypad_interrupt::
    jp joypad

SECTION "start", ROM0[$0100]
start::
    nop
    jp _start

SECTION "bank0", ROM0[$0150]
_start::
    ld c, a
    xor a
    ld [w_c357], a
    ld [w_c358], a
    ld a, c
    cp $11
    jr nz, .no_speed_switch
    ld a, $1
    ld [w_c357], a
    ld [w_c358], a
    ld hl, rSPD
    bit KEY1F_DBLSPEED_BIT, [hl]
    jr nz, .no_speed_switch
    xor a
    ldh [rIF], a
    ldh [rIE], a
    ldh a, [rP1]
    or P1F_GET_NONE
    ldh [rP1], a
    ldh a, [rSPD]
    ld a, KEY1F_PREPARE
    ldh [rSPD], a
    ei
    di
    stop $6f
.no_speed_switch

    ld a, $1
    ld [w_c325], a
    xor a
    ld [w_c326], a
    ld [w_c329], a
    ld [w_c32c], a
    ld [w_c327], a
    ld [w_c32a], a
    ld [w_c32d], a
    ld [w_c330], a
    ld [w_c333], a

    ld sp, h_stack_bottom
    di
    xor a
    ldh [rIF], a

    ldh a, [rLCDC]
    bit LCDCF_ON_BIT, a
    jr nz, .lcd_on
    set LCDCF_ON_BIT, a
    ldh [rLCDC], a
.lcd_on
    ld bc, 2
    call busy_wait
.wait_vblank
    ldh a, [rLY]
    cp SCRN_Y + 1
    jr c, .wait_vblank
    ld a, LCDCF_ON
    ldh [rLCDC], a
    xor a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld bc, 2
    call busy_wait

    call function_00_0ecf
    ld a, CART_SRAM_ENABLE
    ld [rRAMG], a
    ld a, $01 ; BANK(???)
    ld [rROMB0], a
    ld a, $00
    ld [rRAMB], a
    ld a, $01 ; BANK(???)
    ld [w_bank_rom], a

    ld a, [w_c344]
    push af
    ld a, [w_c357]
    push af
    ld a, [w_c358]
    push af
    ld hl, _RAM
    ld bc, $2000 - 1
    call mem_clear
    pop af
    ld [w_c358], a
    pop af
    ld [w_c357], a
    pop af
    ld [w_c344], a

    ld a, $02
    ld [w_c316], a
    ld a, $01
    ld [w_d61b], a

    ld a, $7e ; BANK(???)
    ld [w_c35a], a
    ld sp, w_stack_bottom
    call function_00_0f20
    call function_00_1085
    call clear_scrn0
    call function_00_103c
    xor a
    ld [w_c320], a
    ld [w_c321], a
    ld [w_c322], a
    ld [w_c340], a
    ld [w_cdcc], a
    ld [w_c325], a
    ld [s_a07d], a
    ld [s_a072], a
    ld [w_cdce], a

    ld hl, w_LCDC
    xor a
    ld [hl+], a ; w_LCDC
    ld [hl+], a ; w_BGP
    ld [hl+], a ; w_OBP0
    ld [hl+], a ; w_OBP1
    ld [hl+], a ; w_SCX
    ld [hl+], a ; w_SCY
    ld a, SCRN_X + 6
    ld [hl+], a ; w_WX
    ld a, SCRN_Y - 1
    ld [hl+], a ; w_WY
    xor a
    ld [hl+], a ; w_LYC
    ld [hl+], a ; w_STAT
    ld [w_c359], a

    call function_00_24b7
    ld a, IEF_SERIAL | IEF_VBLANK
    ldh [rIE], a
    ei

    call function_00_1caa
    rl a
    and $1
    ld [w_c344], a
    jr z, .skip_call
    call function_00_1d59
.skip_call

    xor a
    ld [w_c345], a
    ld a, $0
    call function_00_0d91
    ld a, $40
    ld [w_cd73], a
    call function_00_114e
    xor a
    ld [w_d568], a

    farjp function_04_43ec

function_00_0295::
    ld a, $01
    ld [w_c325], a
    xor a
    ld [w_c326], a
    ld [w_c329], a
    ld [w_c32c], a
    ld [w_c327], a
    ld [w_c32a], a
    ld [w_c32d], a
    ld [w_c330], a
    ld [w_c333], a

    ld sp, h_stack_bottom

    ld a, $5
    call function_00_0d91
    ld a, $1
    ld c, $0
    call function_00_0d91
    call function_00_0d58
    ld c, $0
    ld a, $1
    call function_00_0d91

    xor a
    ld [w_BGP], a
    ld [w_OBP0], a
    ld [w_OBP1], a
    ld bc, 2
    call busy_wait

    di
    xor a
    ldh [rIF], a
    ld sp, h_stack_bottom

    call function_00_0ecf
    ld a, CART_SRAM_ENABLE
    ld [rRAMG], a
    ld a, $01 ; BANK(???)
    ld [rROMB0], a
    ld a, $00
    ld [rRAMB], a
    ld a, $01 ; BANK(???)
    ld [w_bank_rom], a

    ld a, [w_d6b5]
    push af
    ld a, [w_c358]
    push af
    ld a, [w_c357]
    push af
    ld a, [w_c344]
    push af
    ld hl, _RAM
    ld bc, $2000
    call mem_clear
    pop af
    ld [w_c344], a
    pop af
    ld [w_c357], a
    pop af
    ld [w_c358], a
    pop af
    ld [w_d6b5], a

    ld sp, w_stack_bottom
    call function_00_0f20
    call function_00_1085
    call clear_scrn0
    call function_00_103c
    xor a
    ld [w_c320], a
    ld [w_c321], a
    ld [w_c322], a
    ld [w_c340], a
    ld [w_cdcc], a
    ld [w_c359], a
    ld [s_a07d], a
    ld [s_a072], a
    ld [w_cdce], a
    ld a, $7e ; BANK(???)
    ld [w_c35a], a

    ld hl, w_LCDC
    xor a
    ld [hl+], a ; w_LCDC
    ld [hl+], a ; w_BGP
    ld [hl+], a ; w_OBP0
    ld [hl+], a ; w_OBP1
    ld [hl+], a ; w_SCX
    ld [hl+], a ; w_SCY
    ld a, SCRN_X + 6
    ld [hl+], a ; w_WX
    ld a, SCRN_Y - 1
    ld [hl+], a ; w_WY
    xor a
    ld [hl+], a ; w_LYC
    ld [hl+], a ; w_STAT

    call function_00_24b7
    ld a, IEF_SERIAL | IEF_VBLANK
    ldh [rIE], a
    ei

    xor a
    ld [w_c345], a
    ld a, $0
    call function_00_0d91
    ld a, $40
    ld [w_cd73], a
    call function_00_114e
    xor a
    ld [w_d568], a

    ld a, $ff
    ld hl, w_df3f
    ld [hl+], a
    ld [hl+], a
    ld [hl], a

    ld a, [w_df62]
    and a
    jr z, .jr_000_03a6
    ld a, [w_c344]
    and a
    jr z, .jr_000_03a6
    call function_00_1de7
    ld a, BANK(data_00_48cc)
    ld hl, data_00_48cc
    call function_00_1cfa
    xor a
    ld [w_df62], a
.jr_000_03a6

    farjp function_04_43ec

vblank::
    push af
    push bc
    push de
    push hl
    ld a, [s_a072]
    and a
    call nz, function_00_284d
    ld a, [w_c301]
    and a
    jr z, .jr_000_03d5
    ld a, 1
    ld [w_vblank_ran], a
    pop hl
    pop de
    pop bc
    pop af
    reti

.jr_000_03d5
    call h_oam_dma

    ld a, [w_cdcc]
    and a
    jr nz, .set_bg_8000
    ld a, [w_LCDC]
    ldh [rLCDC], a
    jr .lcdc_done
.set_bg_8000
    ld a, [w_LCDC]
    set LCDCF_BG8000_BIT, a
    ldh [rLCDC], a
.lcdc_done

    ld a, [w_c345]
    and a
    jr nz, .skip_video_update
    ld hl, w_BGP
    ld a, [hl+] ; w_BGP
    ldh [rBGP], a
    ld a, [hl+] ; w_OBP0
    ldh [rOBP0], a
    ld a, [hl+] ; w_OBP1
    ldh [rOBP1], a
    ld a, [hl+] ; w_SCX
    ldh [rSCX], a
    ld a, [hl+] ; w_SCY
    ldh [rSCY], a
    ld a, [hl+] ; w_WX
    ldh [rWX], a
    ld a, [hl+] ; w_WY
    ldh [rWY], a
    ld a, [hl+] ; w_LYC
    ldh [rLYC], a
    ld a, [hl+] ; w_STAT
    ldh [rSTAT], a
    call function_00_11f1
.skip_video_update

    ld a, [w_cdd0]
    and a
    jr z, .continue
    ld a, [w_c326]
    cp $0f
    jr nz, .continue
    ld a, [w_c329]
    and $0f
    jr z, .continue
    ld hl, function_00_0295
    push hl
    reti
.continue

    ld a, [w_c342]
    inc a
    ld [w_c342], a
    ld a, 1
    ld [w_vblank_ran], a
    ld hl, w_cdfc
    inc [hl]

    ld a, [w_c345]
    and a
    jr nz, .continue_2
    ld hl, function_00_0458
    push hl
    ld hl, function_00_0df5
    push hl
    reti
.continue_2

    ld hl, rSTAT
.hblank_enter
    ld a, STATF_LCD
    and [hl]
    jr nz, .hblank_enter

    pop hl
    pop de
    pop bc
    pop af
    reti

function_00_0458::
    pop hl
    pop de
    pop bc

    ld a, [w_c301]
    and a
    jr nz, .skip_hblank_wait
    ldh a, [rLCDC]
    bit LCDCF_ON_BIT, a
    jr z, .hblank_enter
.hblank_finish
    ldh a, [rSTAT]
    and STATF_LCD
    jr z, .hblank_finish
.hblank_enter
    ldh a, [rSTAT]
    and STATF_LCD
    jr nz, .hblank_enter
.skip_hblank_wait

    pop af
    ret

unknown_00_0475:: ; ???
    db 8,8,8,8, 8,8,8,8, 8,8,8,8, 8,8,8,8
    db 8,8,8,0, 8,8,8,0, 8,8,8,0, 8,8,8,0
    db 8,0,8,0, 8,0,8,0, 8,0,8,0, 8,0,8,0
    db 8,0,0,8, 0,0,8,0, 0,8,0,0, 8,0,0,8
    db 0,8,0,0, 0,8,0,0, 0,8,0,0, 0,8,0,0

lcd::
    push af
    push bc
    push de
    push hl

    ld hl, .return
    push hl

    ld a, [w_c340]
    sla a
    ld c, a
    ld b, 0
    ld hl, .pointers
    add hl, bc
    ld c, [hl]
    inc hl
    ld b, [hl]
    push bc
    pop hl
    jp hl

.return:
    ld hl, w_c343
    inc [hl]

    ld hl, rSTAT
.hblank_enter
    ld a, STATF_LCD
    and [hl]
    jr nz, .hblank_enter

    pop hl
    pop de
    pop bc
    pop af
rept 40
    nop
endr
    reti

.pointers:
    const_def
    const_dw LCD_FUNCTION_0, lcd_function_0
    const_dw LCD_FUNCTION_1, lcd_function_1
    const_dw LCD_FUNCTION_2, lcd_function_2
    const_dw LCD_FUNCTION_3, lcd_function_3
    const_dw LCD_FUNCTION_4, lcd_function_4
    const_dw LCD_FUNCTION_5, lcd_function_5
    const_dw LCD_FUNCTION_6, lcd_function_6
    const_dw LCD_FUNCTION_7, lcd_function_7
    const_dw LCD_FUNCTION_8, lcd_function_8
    const_dw LCD_FUNCTION_9, lcd_function_9
    const_dw LCD_FUNCTION_A, lcd_function_a
    const_dw LCD_FUNCTION_B, lcd_function_b

lcd_function_0::
    ret ; unused

timer::
    reti

    reti ; unused

joypad::
    reti

; Returns:
; a - character width
; Parameters:
; de - character to print
; b - x position
; c - y position
text_draw_char_dark::
    push_bank_rom BANK(text_chars_offsets)

    ; Get char address
    push de
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
    pop de

    ; Get character width
    ld hl, text_chars_widths
    add hl, de
    ld a, [hl]
    and a
    jr z, .done
    push af
    add b
    ld [w_vwf_char_end_x], a

    ; Draw ピ one pixel higher
    ld a, e
    cp "ピ"
    jr nz, .not_pi
    ld a, d
    and a
    jr nz, .not_pi
    dec c
.not_pi

    ; Set y coordinates for the character
    ld a, c
    ld [w_vwf_char_start_y], a
    add 9
    ld [w_vwf_char_end_y], a

    call vwf_char_draw
    pop af
.done

    ld e, a
    pop_bank_rom
    ld a, e
    ret

vwf_char_draw_dark::
    ld a, [w_vwf_char_start_x]
    and %00000111
    ld c, a
    ld b, 0
    ld hl, vwf_pixel_masks_right
    add hl, bc
    ld a, [hl]
    ld [w_c363], a
    ld hl, vwf_pixel_masks_left
    add hl, bc
    ld a, [hl]
    ld [w_c364], a
    xor a
    ld [w_c365], a
    inc a
    ld [w_c366], a
    ld a, [w_vwf_char_start_x]
    and %00000111
    ld c, a
    add $38
    ld [w_c368], a
    ld b, 0
    ld hl, vwf_pixel_masks_right
    add hl, bc
    ld a, [hl]
    ld [w_c369], a
    ld hl, vwf_data_00_0a2c
    add hl, bc
    ld a, [hl]
    ld [w_c36a], a
    ld a, [w_vwf_char_addr + 0]
    ld c, a
    ld a, [w_vwf_char_addr + 1]
    ld b, a
    push_bank_rom [w_vwf_char_bank]

    ld de, w_vwf_char_buffer
    ld a, [w_vwf_char_start_y]
    ld l, a
    ld a, [w_vwf_char_start_x]
    and %11111000
    ld h, a

.jump_000_05ef
    xor a
    ld [w_c36b], a
    ld [w_c36c], a
    ld a, [w_c366]
    ld [w_c367], a
    ld a, [w_c363]
    ld [w_c362], a
    push bc
    push hl
    push hl
    ld a, [w_c364]
    ld hl, w_c363
    and [hl]
    ld [w_c362], a
    pop hl
    push_bank_rom $23 ; BANK(???)
    push bc
    push de
    ld b, h
    ld c, l
    ld a, l
    and %11111000
    srl a
    srl a
    ld e, a
    ld d, 0
    ld a, [w_cd6d]
    ld l, a
    ld a, [w_cd6e]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, b
    and %11111000
    srl a
    srl a
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, c
    and %00000111
    sla a
    add l
    ld l, a
    pop de
    pop bc
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    pop_bank_rom
    ld a, [w_c362]
    ld [de], a
    inc de
    ld a, [w_c367]
    and a
    jr z, .jump_000_0667

    ld a, [bc]
    inc bc

.jump_000_0667
    ld l, a
    ld a, [w_c368]
    ld h, a
    ld a, [hl]
    push af
    ld hl, w_c369
    and [hl]
    ld hl, w_c36b
    or [hl]
    ld [de], a
    pop af
    ld hl, w_c36a
    and [hl]
    ld [w_c36b], a
    inc de
    ld a, [w_c367]
    and a
    jr z, .jump_000_0691

    ld a, [bc]
    push af
    ld a, c
    add $0f
    ld c, a
    ld a, b
    adc 0
    ld b, a
    pop af

.jump_000_0691
    ld l, a
    ld a, [w_c368]
    ld h, a
    ld a, [hl]
    push af
    ld hl, w_c369
    and [hl]
    ld hl, w_c36c
    or [hl]
    ld [de], a
    pop af
    ld hl, w_c36a
    and [hl]
    ld [w_c36c], a
    inc de
    pop hl
    pop bc
    inc bc
    inc bc
    ld a, c
    and %00001111
    jr nz, .jump_000_06bb

    ld a, c
    add $f0
    ld c, a
    ld a, b
    adc 0
    ld b, a

.jump_000_06bb
    inc l
    ld a, [w_vwf_char_start_y]
    cp l
    jp nc, .jump_000_05ef

    xor a
    ld [de], a
    inc de
    ld [de], a

    ; Write tiles stored in the buffer
    ld bc, w_vwf_char_buffer

    ; Ignore hblank (update during vblank?)
    ld a, [w_LCDC]
    bit LCDCF_ON_BIT, a
    jr z, .write_tile_ignore_hblank_loop

.write_tile_loop
    ; Get location to write to
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a
    or l
    jr z, .write_tile_done

    ; Get mask in e, and pixels in d
    inc bc
    ld a, [bc]
    ld e, a
    inc bc
    ld a, [bc]
    ld d, a
    inc bc

.hblank_finish
    ldh a, [rSTAT]
    and STATF_LCD
    jr z, .hblank_finish
.hblank_enter
    ldh a, [rSTAT]
    and STATF_LCD
    jr nz, .hblank_enter

    ; Write pixels high bit, preserving background
    ld a, d
    xor [hl]
    and e
    xor [hl]
    ld [hl+], a
    ld a, [bc]
    ld d, a
    inc bc

.hblank_next
    ldh a, [rSTAT]
    and STATF_LCD
    jr nz, .hblank_next

    ; Write 8 pixels low bit, preserving background
    ld a, d
    xor [hl]
    and e
    xor [hl]
    ld [hl], a
    jr .write_tile_loop

.write_tile_done
    pop_bank_rom
    ret

.write_tile_ignore_hblank_loop:
    ; Get location to write to
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a
    or l
    jr z, .write_tile_done

    ; Get mask in e, and pixels in a
    inc bc
    ld a, [bc]
    ld e, a
    inc bc
    ld a, [bc]
    inc bc

    ; Write pixels high bit, preserving background
    xor [hl]
    and e
    xor [hl]
    ld [hl+], a
    ld a, [bc]
    inc bc

    ; Write 8 pixels low bit, preserving background
    xor [hl]
    and e
    xor [hl]
    ld [hl], a
    jr .write_tile_ignore_hblank_loop

vwf_char_draw::
    ld a, [w_vwf_char_start_x]
    and %00000111
    ld c, a
    ld b, 0
    ld hl, vwf_pixel_masks_right
    add hl, bc
    ld a, [hl]
    ld [w_c363], a
    ld a, [w_vwf_char_end_x]
    and %00000111
    ld c, a
    ld b, 0
    ld hl, vwf_pixel_masks_left
    add hl, bc
    ld a, [hl]
    ld [w_c364], a
    ld a, [w_vwf_char_start_x]
    and %11111000
    ld c, a
    ld a, [w_vwf_char_end_x]
    and %11111000
    sub c
    srl a
    srl a
    srl a
    ld [w_c365], a
    ld a, [w_vwf_char_start_x]
    ld c, a
    ld a, [w_vwf_char_end_x]
    sub c
    srl a
    srl a
    srl a
    inc a
    ld [w_c366], a
    ld a, [w_vwf_char_start_x]
    and %00000111
    ld c, a
    add $38
    ld [w_c368], a
    ld b, 0
    ld hl, vwf_pixel_masks_right
    add hl, bc
    ld a, [hl]
    ld [w_c369], a
    ld hl, vwf_data_00_0a2c
    add hl, bc
    ld a, [hl]
    ld [w_c36a], a
    ld a, [w_vwf_char_addr + 0]
    ld c, a
    ld a, [w_vwf_char_addr + 1]
    ld b, a
    push_bank_rom [w_vwf_char_bank]

    ld de, w_vwf_char_buffer
    ld a, [w_vwf_char_start_y]
    ld l, a
    ld a, [w_vwf_char_start_x]
    and %11111000
    ld h, a

.jump_000_07a9
    xor a
    ld [w_c36b], a
    ld [w_c36c], a
    ld a, [w_c366]
    ld [w_c367], a
    ld a, [w_c363]
    ld [w_c362], a
    push bc
    push hl
    ld a, [w_c365]
    and a
    jr nz, .jr_000_07d3

    push hl
    ld a, [w_c364]
    ld hl, w_c363
    and [hl]
    ld [w_c362], a
    pop hl
    jp .jump_000_0911

.jr_000_07d3
    push hl
    push_bank_rom $23 ; BANK(???)
    push bc
    push de
    ld b, h
    ld c, l
    ld a, l
    and %11111000
    srl a
    srl a
    ld e, a
    ld d, 0
    ld a, [w_cd6d]
    ld l, a
    ld a, [w_cd6e]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, b
    and %11111000
    srl a
    srl a
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, c
    and %00000111
    sla a
    add l
    ld l, a
    pop de
    pop bc
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    pop_bank_rom
    ld a, [w_c362]
    ld [de], a
    inc de
    ld a, [bc]
    ld l, a
    ld a, [w_c368]
    ld h, a
    ld a, [hl]
    ld [de], a
    ld hl, w_c36a
    and [hl]
    ld [w_c36b], a
    inc bc
    inc de
    ld a, [bc]
    ld l, a
    ld a, [w_c368]
    ld h, a
    ld a, [hl]
    ld [de], a
    ld hl, w_c36a
    and [hl]
    ld [w_c36c], a
    ld a, c
    add $0f
    ld c, a
    ld a, b
    adc 0
    ld b, a
    inc de
    pop hl
    ld a, h
    add $08
    ld h, a
    ld a, [w_c367]
    dec a
    ld [w_c367], a
    ld a, [w_c365]
    dec a
    jp z, .jump_000_090b

.jump_000_085f
    push af
    push hl
    push_bank_rom $23 ; BANK(???)
    push bc
    push de
    ld b, h
    ld c, l
    ld a, l
    and %11111000
    srl a
    srl a
    ld e, a
    ld d, 0
    ld a, [w_cd6d]
    ld l, a
    ld a, [w_cd6e]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, b
    and %11111000
    srl a
    srl a
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, c
    and %00000111
    sla a
    add l
    ld l, a
    pop de
    pop bc
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    pop_bank_rom
    ld a, $ff
    ld [de], a
    inc de
    ld a, [w_c367]
    and a
    jr z, .jr_000_08b7

    ld a, [bc]
    inc bc

.jr_000_08b7
    ld l, a
    ld a, [w_c368]
    ld h, a
    ld a, [hl]
    push af
    ld hl, w_c369
    and [hl]
    ld hl, w_c36b
    or [hl]
    ld [de], a
    pop af
    ld hl, w_c36a
    and [hl]
    ld [w_c36b], a
    inc de
    ld a, [w_c367]
    and a
    jr z, .jr_000_08e1

    ld a, [bc]
    push af
    ld a, c
    add $0f
    ld c, a
    ld a, b
    adc 0
    ld b, a
    pop af

.jr_000_08e1
    ld l, a
    ld a, [w_c368]
    ld h, a
    ld a, [hl]
    push af
    ld hl, w_c369
    and [hl]
    ld hl, w_c36c
    or [hl]
    ld [de], a
    pop af
    ld hl, w_c36a
    and [hl]
    ld [w_c36c], a
    inc de
    pop hl
    ld a, h
    add $08
    ld h, a
    ld a, [w_c367]
    dec a
    ld [w_c367], a
    pop af
    dec a
    jp nz, .jump_000_085f

.jump_000_090b
    ld a, [w_c364]
    ld [w_c362], a

.jump_000_0911
    push_bank_rom $23 ; BANK(???)
    push bc
    push de
    ld b, h
    ld c, l
    ld a, l
    and %11111000
    srl a
    srl a
    ld e, a
    ld d, 0
    ld a, [w_cd6d]
    ld l, a
    ld a, [w_cd6e]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, b
    and %11111000
    srl a
    srl a
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, c
    and %00000111
    sla a
    add l
    ld l, a
    pop de
    pop bc
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    pop_bank_rom
    ld a, [w_c362]
    ld [de], a
    inc de
    ld a, [w_c367]
    and a
    jr z, .jr_000_0968

    ld a, [bc]
    inc bc

.jr_000_0968
    ld l, a
    ld a, [w_c368]
    ld h, a
    ld a, [hl]
    push af
    ld hl, w_c369
    and [hl]
    ld hl, w_c36b
    or [hl]
    ld [de], a
    pop af
    ld hl, w_c36a
    and [hl]
    ld [w_c36b], a
    inc de
    ld a, [w_c367]
    and a
    jr z, .jr_000_0992

    ld a, [bc]
    push af
    ld a, c
    add $0f
    ld c, a
    ld a, b
    adc 0
    ld b, a
    pop af

.jr_000_0992
    ld l, a
    ld a, [w_c368]
    ld h, a
    ld a, [hl]
    push af
    ld hl, w_c369
    and [hl]
    ld hl, w_c36c
    or [hl]
    ld [de], a
    pop af
    ld hl, w_c36a
    and [hl]
    ld [w_c36c], a
    inc de
    pop hl
    pop bc
    inc bc
    inc bc
    ld a, c
    and %00001111
    jr nz, .jr_000_09bc

    ld a, c
    add $f0
    ld c, a
    ld a, b
    adc 0
    ld b, a

.jr_000_09bc
    inc l
    ld a, [w_vwf_char_end_y]
    cp l
    jp nc, .jump_000_07a9

    xor a
    ld [de], a
    inc de
    ld [de], a

    ; Write tiles stored in the buffer
    ld bc, w_vwf_char_buffer

    ; Ignore hblank (update during vblank?)
    ld a, [w_LCDC]
    bit LCDCF_ON_BIT, a
    jr z, .write_tile_ignore_hblank_loop

.write_tile_loop
    ; Get location to write to
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a
    or l
    jr z, .write_tile_done

    ; Get mask in e, and pixels in d
    inc bc
    ld a, [bc]
    ld e, a
    inc bc
    ld a, [bc]
    ld d, a
    inc bc

.hblank_finish
    ldh a, [rSTAT]
    and STATF_LCD
    jr z, .hblank_finish
.hblank_enter
    ldh a, [rSTAT]
    and STATF_LCD
    jr nz, .hblank_enter

    ; Write pixels high bit, preserving background
    ld a, d
    xor [hl]
    and e
    xor [hl]
    ld [hl+], a
    ld a, [bc]
    ld d, a
    inc bc

.hblank_next
    ldh a, [rSTAT]
    and STATF_LCD
    jr nz, .hblank_next

    ; Write 8 pixels low bit, preserving background
    ld a, d
    xor [hl]
    and e
    xor [hl]
    ld [hl], a
    jr .write_tile_loop

.write_tile_done
    pop_bank_rom
    ret

.write_tile_ignore_hblank_loop:
    ; Get location to write to
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a
    or l
    jr z, .write_tile_done

    ; Get mask in e, and pixels in a
    inc bc
    ld a, [bc]
    ld e, a
    inc bc
    ld a, [bc]
    inc bc

    ; Write pixels high bit, preserving background
    xor [hl]
    and e
    xor [hl]
    ld [hl+], a
    ld a, [bc]
    inc bc

    ; Write 8 pixels low bit, preserving background
    xor [hl]
    and e
    xor [hl]
    ld [hl], a
    jr .write_tile_ignore_hblank_loop

vwf_pixel_masks_right:
    db $ff, $7f, $3f, $1f, $0f, $07, $03, $01

vwf_data_00_0a2c:
    db $00

vwf_pixel_masks_left:
    db $80, $c0, $e0, $f0, $f8, $fc, $fe, $ff

vwf_data_00_0a35: ; ???
    db $00, $00, $68, $01, $d0, $02, $38, $04, $a0, $05, $08, $07, $70, $08, $d8, $09, $40, $0b, $a8, $0c, $fa, $57, $c3, $a7, $c8, $f0, $00, $f6, $30, $e0, $00, $f0, $4d, $3e, $01, $e0, $4d, $10, $6f

function_00_0a5c::
    ret

function_00_0a5d::
    push af
    push hl
    ld hl, sp + 4
    ld a, [hl]
    ld [w_bank_rom], a
    ld [rROMB0], a
    pop hl
    pop af
    inc sp
    inc sp
    ret

function_00_0a6d::
    ld [w_bank_temp], a
    ld16 w_farcall_target, hl
    pop hl
    ld16 w_c319, hl
    pop hl
    pop af
    ld [w_c31b], a
    ld16 w_c31c, hl
    ld hl, w_c319
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld hl, w_c31c
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [w_c31b]
    push af
    push af
    push af
    push af
    push hl
    ld hl, sp + 4
    ld a, [w_farcall_target + 0]
    ld [hl+], a
    ld a, [w_farcall_target + 1]
    ld [hl+], a
    ld a, LOW(function_00_0a5d)
    ld [hl+], a
    ld a, HIGH(function_00_0a5d)
    ld [hl+], a
    ld a, [w_bank_rom]
    ld [hl], a
    ld a, [w_bank_temp]
    ld [w_bank_rom], a
    ld [rROMB0], a
    pop hl
    pop af
    ret

string_print_dark_function_00_0ac3::
    push_bank_rom $02 ; BANK(???)

    ; Get text coordinates
    ld a, [w_text_pos_x]
    ld b, a
    ld a, [w_text_pos_y]
    ld c, a

.string_loop
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    and e
    cp TX_END
    jr z, .done

    push bc
    push hl
    call text_draw_char_dark
    pop hl
    pop bc

    ; Leave one pixel between each character
    add b
    inc a
    ld b, a
    jr .string_loop

.done
    pop_bank_rom
    ret

function_00_0af4::
    push de
    ld b, 0
    ld a, d
    cpl
    ld d, a
    ld a, e
    cpl
    ld e, a
    inc de
.loop
    add hl, de
    inc b
    bit 7, h
    jr z, .loop
    dec b
    pop de
    add hl, de
    ld a, l
    ret

function_00_0b09:
    push af
    ld a, b
    cp $01
    jr c, .done
    jr nz, .continue
    ld a, c
    and a
    jr nz, .continue
.done
    pop af
    call function_00_0b2e
    ret

.continue
    pop af
    push af
    push bc
    push hl
    ld bc, $0100
    call function_00_0b2e
    pop hl
    ld bc, $0100
    add hl, bc
    pop bc
    dec b
    pop af
    jr function_00_0b09

function_00_0b2e::
    push af
    push bc
    push de
    ld de, w_c100
    call mem_copy
    pop de
    pop bc
    pop af
    ld l, a
    ld a, [w_c316]
    push af
    ld a, l
    ld [w_c316], a
    ld [rRAMB], a
    ld hl, w_c100
    call mem_copy
    pop af
    ld [w_c316], a
    ld [rRAMB], a
    ret

function_00_0b54::
    ld [w_bank_temp], a
    push_bank_rom [w_bank_temp]

    ld a, [w_c357]
    and a
    jp nz, .jump_000_0b84
    ld bc, $800
.loop
    inc hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    dec bc
    ld a, c
    or b
    jp nz, .loop

    pop_bank_rom
    ret

.jump_000_0b84
    push hl
    ld hl, w_dbee
    ld a, e
    ld [hl+], a
    ld [hl], d
    pop hl
    push hl
    ld hl, w_dbf0
    ld a, e
    ld [hl+], a
    ld [hl], d
    pop hl
    push hl
    ld hl, w_dbe4
    ld a, c
    ld [hl+], a
    ld [hl], b
    pop hl
.loop_000_0b9c
    call function_00_0bc0
    ld de, 3
    add hl, de
    push hl
    ld hl, w_dbe4
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    pop hl
    dec de
    push hl
    ld hl, w_dbe4
    ld a, e
    ld [hl+], a
    ld [hl], d
    pop hl
    ld a, d
    or e
    jr nz, .loop_000_0b9c

    pop_bank_rom
    ret

function_00_0bc0::
    push hl

    ld e, 0
    ld d, 0
    ld c, 0
    ld b, 0
    ld a, $08
    ld [w_dbe6], a
    ld a, [hl+]
    ld [w_dbe8], a
    ld a, [hl+]
    ld [w_dbea], a
    ld a, [hl+]
    ld [w_dbec], a

.jump_000_0bda
    ld a, [w_dbe8]
    bit 7, a
    jr nz, .jump_000_0c00
    sla a
    ld [w_dbe8], a
    ld a, [w_dbea]
    sla a
    ld [w_dbea], a
    rl e
    ld a, [w_dbec]
    sla a
    ld [w_dbec], a
    rl d
    sla c
    sla b
    jr .jump_000_0c1d
.jump_000_0c00
    sla a
    ld [w_dbe8], a
    ld a, [w_dbea]
    sla a
    ld [w_dbea], a
    rl c
    ld a, [w_dbec]
    sla a
    ld [w_dbec], a
    rl  b
    sla e
    sla d
.jump_000_0c1d
    ld a, [w_dbe6]
    dec a
    ld [w_dbe6], a
    and a
    jp nz, .jump_000_0bda

    ld hl, w_dbee
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call hblank_wait
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld16 w_dbee, hl
    ld a, 1
    call set_bank_vram

    ld hl, w_dbf0
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call hblank_wait
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld16 w_dbf0, hl
    ld a, 0
    call set_bank_vram

    pop hl
    ret

hblank_wait::
    ldh a, [rLCDC]
    bit LCDCF_ON_BIT, a
    ret z
.hblank_finish
    ldh a, [rSTAT]
    and STATF_LCD
    jr z, .hblank_finish
.hblank_enter
    ldh a, [rSTAT]
    and STATF_LCD
    jr nz, .hblank_enter
    ret

function_00_0c70::
    ld a, [w_d6c8]
    and a
    ret nz

    push_bank_rom $09 ; BANK(???)

    ld hl, $4000 ; ???
    ld a, [w_level_index + 0]
    ld c, a
    ld a, [w_level_index + 1]
    ld b, a
    sla c
    rl b
    add hl, bc
    ld a, [hl+]
    ld h, [hl]
    ld l, a

.loop
    ld a, [hl]
    and a
    jr z, .done

    ; Get text coordinates
    call function_00_0cc3
    ld a, [hl+]
    add b
    sub $80
    ld b, a
    inc hl

.string_loop
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    and e
    cp TX_END
    jr z, .loop

    ld a, e
    cp "　"
    jr z, .done

    push bc
    push hl
    call text_draw_char
    pop hl
    pop bc

    ; Leave one pixel between each character
    add b
    inc a
    ld b, a
    jr .string_loop

.done
    pop_bank_rom
    ret

function_00_0cc3::
    push hl
    ld a, [w_d628 + 0]
    add a
    ld c, a
    ld a, [w_d628 + 1]
    add c
    add a
    add a
    ld c, a
    ld a, [w_d628 + 2]
    add c
    add a
    ld l, a
    ld h, 0
    ld de, .data
    add hl, de
    ld a, [hl+]
    ld b, a
    ld c, [hl]
    pop hl
    ret

.data
    db $68, $1c, $00, $00, $00, $00, $00, $00
    db $68, $2c, $00, $00, $00, $00, $00, $00
    db $68, $1c, $38, $1c, $38, $6c, $68, $6c
    db $50, $34, $48, $34, $48, $54, $50, $54
    db $50, $1c, $00, $00, $00, $00, $00, $00

farcall_table_entry::
    ld e, a
    add a
    add e
    pop hl
    ld e, a
    ld d, 0
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    push_bank_rom [hl]

    ld l, e
    ld h, d
    ld de, .return
    push de
    ld a, [w_bank_rom]
    ld e, a
    push de
    jp hl

.return
    pop_bank_rom
    jp farcall_ret

farcall_a_hl::
    ld [w_bank_temp], a
    push_bank_rom [w_bank_temp]

    ld de, .return
    push de
    ld a, [w_bank_rom]
    ld e, a
    push de
    jp hl

.return
    pop_bank_rom
    ret

function_00_0d58::
    push hl
    ldh a, [rLCDC]
    bit LCDCF_ON_BIT, a
    jr nz, .lcd_on

; Wait for 70,000 clock cycles (17,500 machine cycles)
    ld de, 1750
.wait_loop
    nop
    nop
    nop
    dec de
    ld a, d
    or e
    jr nz, .wait_loop

    pop hl
    ret

.lcd_on
    xor a
    ld [w_c325], a
    ld [w_c326], a
    ld [w_c329], a
    ld [w_c32c], a
    rst vblank_wait

    xor a
    ld [w_c327], a
    ld [w_c32a], a
    ld [w_c32d], a
    ld a, $1
    ld [w_c325], a

.wait_ly
    ldh a, [rLY]
    cp 64
    jr c, .wait_ly

    pop hl
    ret

function_00_0d91::
    push af
    push bc
    push de
    push hl

    cp $1
    jr nz, .jr_000_0d9f
    push af
    ld a, c
    ld [w_df47], a
    pop af
.jr_000_0d9f
    ld l, a

.wait_ly
    ldh a, [rLY]
    and a
    jr z, .ly_ready
    cp 48
    jr c, .wait_ly
    cp 130
    jr nc, .wait_ly
    ccf
.ly_ready

    ldh a, [rIE]
    push af
    res IEF_VBLANK_BIT, a
    ldh [rIE], a
    di
    ld a, [w_c35a]
    ld [rROMB0], a

.main_loop
    push bc
    push hl
    ld a, l
    cp $1
    jr nz, .skip_bankswitch
    ld a, c
    cp $80
    jr c, .bank_7e
    and $7f
    ld c, a
    ld a, $7f
    jr .got_bank
.bank_7e
    ld a, $7e
.got_bank
    ld [w_c35a], a
    ld [rROMB0], a
    ld a, l
.skip_bankswitch
    call $4000 ; ???
    pop hl
    pop bc
    jr nc, .done
    nop
    nop
    nop
    nop
    nop
    jr .main_loop
.done

    ld a, [w_bank_rom]
    ld [rROMB0], a
    pop af
    ldh [rIE], a
    ei

    pop hl
    pop de
    pop bc
    pop af
    ret

function_00_0df5::
    push af
    push bc
    push de
    push hl

    ld a, [w_c301]
    and a
    jr nz, .skip
    ld a, [w_c302]
    and a
    jr nz, .skip

    ld a, [w_c35a]
    ld [rROMB0], a
    cp BANK(function_19_4180)
    jr nz, .not_function_19_4180
    call function_19_4180
    jr .done
.not_function_19_4180
    call $4003 ; ???
.done
    ld a, [w_bank_rom]
    ld [rROMB0], a

.skip
    pop hl
    pop de
    pop bc
    pop af
    ret

function_00_0e22::
    ld a, [w_c35a]
    cp BANK(function_19_4000)
    jr z, .not_bank_19
    ld a, BANK(function_19_4000)
    ld [w_c35a], a
    ld [rROMB0], a
    call function_19_4000
    ld a, [w_bank_rom]
    ld [rROMB0], a
    ret

.not_bank_19
    ld a, $7e ; BANK(???)
    ld [w_c35a], a
    ld a, $0
    call function_00_0d91
    ret

function_00_0e46::
    ld a, BANK(function_19_40f0)
    ld [rROMB0], a
    call function_19_40f0
    ld a, [w_bank_rom]
    ld [rROMB0], a
    ret

SECTION "mem functions", ROM0[$0f38]
; Zeroes out RAM
; Parameters:
; hl - dest
; bc - length
mem_clear::
    xor a
    ld [hl+], a
    dec bc
    ld a, c
    or b
    jr nz, mem_clear
    ret

; Zeroes out RAM
; Parameters:
; hl - dest
; bc - length
function_00_0f40::
    ldh a, [rLCDC]
    bit LCDCF_ON_BIT, a
    jr z, .hblank_enter
.hblank_finish
    ldh a, [rSTAT]
    and STATF_LCD
    jr z, .hblank_finish
.hblank_enter
    ldh a, [rSTAT]
    and STATF_LCD
    jr nz, .hblank_enter

    xor a
rept 4
    ld [hl+], a
endr
rept 4
    dec bc
endr
    ld a, b
    or c
    jr nz, function_00_0f40
    ret

; Parameters:
; hl - source
; de - dest
; bc - length
mem_copy::
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, c
    or b
    jr nz, mem_copy
    ret

; Parameters:
; a - bank
; hl - source
; de - dest
; bc - length
far_mem_copy::
    ld [w_bank_temp], a
    push_bank_rom [w_bank_temp]

.loop
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, c
    or b
    jr nz, .loop

    pop_bank_rom
    ret

; Parameters:
; a - bank
; hl - source
; de - dest
; bc - length
far_mem_mask::
    ld [w_bank_temp], a
    push_bank_rom [w_bank_temp]

    srl b
    rr c
.loop
    push bc
    ld a, [hl+]
    ld b, a
    or [hl]
    xor $ff
    ld c, a
    ld a, [de]
    and c
    or b
    ld [de], a
    inc de
    ld a, [de]
    and c
    or [hl]
    ld [de], a
    inc de
    inc hl
    pop bc
    dec bc
    ld a, c
    or b
    jr nz, .loop

    pop_bank_rom
    ret

; Parameters:
; a - bank
; hl - source
; de - dest
; bc - length
vram_copy::
    ld [w_bank_temp], a
    push_bank_rom [w_bank_temp]

.loop
    ldh a, [rLCDC]
    bit 7, a
    jr z, .in_vblank

.wait_vblank
    ldh a, [rSTAT]
    and STATF_LCD
    jr z, .wait_vblank

.in_vblank
    ldh a, [rSTAT]
    and STATF_LCD
    jr nz, .in_vblank

    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    dec bc
    dec bc
    dec bc
    ld a, b
    or c
    jr nz, .loop

    pop_bank_rom
    ret

SECTION "function_00_1085", ROM0[$1085]
; Fills $c000--$c0ff with $f0 and sets [w_c314] = 0
function_00_1085::
    ld a, $f0
    ld hl, _RAM
.loop
    ld [hl+], a
    bit 0, h
    jr z, .loop
    xor a
    ld [w_c314], a
    ret

SECTION "farjp", ROM0[$10b4]
; Jump to w_farcall_target in w_bank_temp
_farjp::
    push af
    push af
    push hl
    ld hl, sp + 4
    ld a, [w_farcall_target + 0]
    ld [hl+], a
    ld a, [w_farcall_target + 1]
    ld [hl], a
    ld a, [w_bank_temp]
    ld [w_bank_rom], a
    ld [rROMB0], a
    pop hl
    pop af
    ret

SECTION "clear_scrn0", ROM0[$1031]
; Fills _SCRN0 ($9800--$9BFF) with tile $01
clear_scrn0::
    ld a, $01
    ld hl, _SCRN0
.loop
    ld [hl+], a
    bit 2, h
    jr z, .loop
    ret

SECTION "farcall", ROM0[$10cd]
; Save current bank and jump to w_farcall_target in w_bank_temp
_farcall::
    push af
    push af
    push af
    push hl
    ld hl, sp + 4
    ld a, [w_farcall_target + 0]
    ld [hl+], a
    ld a, [w_farcall_target + 1]
    ld [hl+], a
    ld a, [w_bank_rom]
    ld [hl], a
    ld a, [w_bank_temp]
    ld [w_bank_rom], a
    ld [rROMB0], a
    pop hl
    pop af
    ret

; Return to bank and address in stack
farcall_ret::
    push af
    push hl
    ld hl, sp + 4
    ld a, [hl]
    ld [w_bank_rom], a
    ld [rROMB0], a
    pop hl
    pop af
    inc sp
    inc sp
    ret

SECTION "busy_wait", ROM0[$1120]
; Wait for 70,000 * bc clock cycles (17,500 * bc machine cycles).
; This is approximately bc / 60 seconds.
busy_wait::
    ld de, 1750
.wait_loop
    nop
    nop
    nop
    dec de
    ld a, d
    or e
    jr nz, .wait_loop
    dec bc
    ld a, b
    or c
    jr nz, busy_wait
    ret

SECTION "home_text", ROM0[$1883]
level_name_print::
    push_bank_rom BANK(level_names)

    ; Get string address
    ld hl, level_names
    ld a, [w_level_index + 0]
    ld c, a
    ld a, [w_level_index + 1]
    ld b, a
    sla c
    rl b
    add hl, bc
    ld a, [hl+]
    ld h, [hl]
    ld l, a

.loop
    ld a, [hl]
    and a
    jr z, .done

    ; Get text coordinates
    ld a, [w_text_pos_x]
    ld b, a
    inc hl
    ld a, [w_text_pos_y]
    inc a
    inc a
    ld c, a
    inc hl

.string_loop
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    and e
    cp TX_END
    jr z, .loop

    push bc
    push hl
    call text_draw_char
    pop hl
    pop bc

    ; Leave one pixel between each character
    add b
    inc a
    ld b, a
    jr .string_loop

.done
    pop_bank_rom
    ret

; Returns:
; a - character width
; Parameters:
; de - character to print
; b - x position
; c - y position
text_draw_char:
    push_bank_rom BANK(text_chars_offsets)

    ; Get char address
    push de
    sla e
    rl d
    ld hl, text_chars_offsets
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, gfx_text_chars_bw
    add hl, de
    ld16 w_vwf_char_addr, hl
    ld a, BANK(gfx_text_chars_bw)
    ld [w_vwf_char_bank], a
    ld a, b
    ld [w_vwf_char_start_x], a
    pop de

    ; Get character width
    ld hl, text_chars_widths
    add hl, de
    ld a, [hl]
    and a
    jr z, .done
    push af
    add b
    ld [w_vwf_char_end_x], a

    ; Draw ピ one pixel higher
    ld a, e
    cp "ピ"
    jr nz, .not_pi
    ld a, d
    and a
    jr nz, .not_pi
    dec c
.not_pi

    ; Set y coordinates for the character
    ld a, c
    ld [w_vwf_char_start_y], a
    add 9
    ld [w_vwf_char_end_y], a

    call vwf_char_draw
    pop af
.done

    ld e, a
    pop_bank_rom
    ld a, e
    ret

SECTION "set_bank_vram, etc", ROM0[$1bd5]
set_bank_vram::
    push af
    ldh a, [rLCDC]
    bit LCDCF_ON_BIT, a
    jr z, .hblank_enter
.hblank_finish
    ldh a, [rSTAT]
    and STATF_LCD
    jr z, .hblank_finish
.hblank_enter
    ldh a, [rSTAT]
    and STATF_LCD
    jr nz, .hblank_enter
    pop af
    ldh [rVBK], a
    ret

function_00_1bec::
    ld bc, 0
.loop_c
    cp $64
    jr c, .loop_b
    sub $64
    inc c
    jr .loop_c
.loop_b
    cp $0a
    jr c, .next
    sub $0a
    inc b
    jr .loop_b
.next
    swap b
    or b
    ld b, a
    ld a, c
    and a
    jr nz, .done
    ld c, $0a
    ld a, b
    and $f0
    jr nz, .done
    ld a, b
    and $0f
    or $a0
    ld b, a
.done
    ld a, b
    ret

copy_level_name::
    ld l, a
    push_bank_rom BANK(level_names)

    ld h, 0
    add hl, hl
    ld de, level_names
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a

    inc hl ; skip dw before text
    inc hl
    ld e, 6 ; only copies first 6 characters of level name
.loop
    ld a, [hl+]
    ld [bc], a
    inc hl ; skip character's high byte
    inc bc
    dec e
    jr nz, .loop

    pop_bank_rom
    ret

send_sgb_packets::
    ld [w_bank_temp], a
    push_bank_rom [w_bank_temp]
    call _send_sgb_packets
    pop_bank_rom
    ret

_send_sgb_packets::
    ld a, [hl] ; number of packets
    and $7
    ret z

    ld b, a
    ld c, LOW(rP1)
    ld a, $ff
    ld [w_c345], a

.packet_loop
    push bc
    ld a, $00 ; RESET pulse
    ldh [c], a
    ld a, P1F_4 | P1F_5
    ldh [c], a
    ld b, $10 ; bytes per packet
.byte_loop
    ld e, 8 ; bits per byte
    ld a, [hl+]
    ld d, a
.bit_loop
    bit 0, d
    ld a, P1F_4
    jr nz, .got_bit
    ld a, P1F_5
.got_bit
    ldh [c], a
    ld a, P1F_4 | P1F_5
    ldh [c], a
    rr d
    dec e
    jr nz, .bit_loop
    dec b
    jr nz, .byte_loop
    ld a, P1F_5 ; stop bit (0)
    ldh [c], a
    ld a, P1F_4 | P1F_5
    ldh [c], a
    pop bc
    dec b
    jr z, .done
    call sgb_delay_cycles
    jr .packet_loop

.done
    xor a
    ld [w_c345], a
    ret

sgb_delay_cycles::
    ld de, 7000
.loop
    nop
    nop
    nop
    dec de
    ld a, d
    or e
    jr nz, .loop
    ret

SECTION "decompress", ROM0[$20cf]
decompress::
; Parameters:
; hl - source
; de - dest
; bc - length (not the actual source or dest length)
    ld [w_bank_temp], a
    push_bank_rom [w_bank_temp]

    xor a
    ld [w_c300], a

.main_loop
    push bc
    ld a, [hl+]
    bit 7, a
    jr nz, .alternating

; uses the next a + 1 bytes of compressed data
; to output a + 1 bytes of decompressed data
    inc a
    ld c, a
    ld a, [w_c300]
.seq_loop
    xor [hl]
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, .seq_loop
    ld [w_c300], a
    jr .next

; uses the next one byte of compressed data
; to output a - $7e bytes of decompressed data,
; alternating between two different values
.alternating
    sub $7e
    ld c, a
    ld a, [w_c300]
.alt_loop
    xor [hl]
    ld [de], a
    inc de
    dec c
    jr nz, .alt_loop
    ld [w_c300], a
    inc hl

.next
    pop bc
    dec bc
    ld a, c
    or b
    jr nz, .main_loop

    pop_bank_rom
    ret

SECTION "function_00_24b7", ROM0[$24b7]
function_00_24b7::
    xor a
    ldh [rSB], a
    ldh [rSC], a
    ld [s_a03e], a
    dec a
    ld [s_a058], a
    ld [s_a059], a
    call .sub
    ret

.sub
    xor a
    ld [s_a056], a
    ld [s_a05b], a
    ld [s_a06c], a
    xor a
    ld [s_a040], a
    ld [s_a041], a
    ld [s_a042], a
    ld [s_a043], a
    ld [s_a057], a
    ld [s_a054], a
    ld [s_a055], a
    ld [s_a04a], a
    ld [s_a04b], a
    ld [s_a06d], a
    ld [s_a073], a
    ret

SECTION "serial, etc", ROM0[$2836]
serial::
    push af
    ldh a, [rSC]
    bit SC_TRANSFER_START_FLAG_BIT, a
    jr nz, .skip
    push bc
    push de
    push hl
    ld a, $01
    ld [s_a05b], a
    call function_00_2312
    pop hl
    pop de
    pop bc
.skip
    pop af
    reti

function_00_284d::
    ld a, [s_a03e]
    cp $01
    ret nz
    ld a, [s_a058]
    cp $ff
    ret z
    ld a, [s_a06c]
    and a
    ret nz
    ld hl, s_a071
    inc [hl]
    ld a, [hl]
    cp $06
    ret c
    xor a
    ld [hl], a
    ld [s_a073], a
    call function_00_26c1
    ret
