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
    bit LCDCF_ON_F, a
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

SECTION "_start, etc", ROM0[$0150]
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
    bit KEY1F_DBLSPEED_F, [hl]
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
    db $10, $6f ; corrupted stop
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
    bit LCDCF_ON_F, a
    jr nz, .lcd_on
    set LCDCF_ON_F, a
    ldh [rLCDC], a
.lcd_on
    ld bc, 2
    call function_00_1120
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
    call function_00_1120

    call function_00_0ecf
    ld a, CART_SRAM_ENABLE
    ld [rRAMG], a
    ld a, $01
    ld [rROMB0], a
    ld a, $00
    ld [rRAMB], a
    ld a, $01
    ld [w_bank_rom], a

    ld a, [w_c344]
    push af
    ld a, [w_c357]
    push af
    ld a, [w_c358]
    push af
    ld hl, _RAM
    ld bc, $1fff
    call clear_mem
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
    call function_00_1120

    di
    xor a
    ldh [rIF], a
    ld sp, h_stack_bottom

    call function_00_0ecf
    ld a, CART_SRAM_ENABLE
    ld [rRAMG], a
    ld a, $01
    ld [rROMB0], a
    ld a, $00
    ld [rRAMB], a
    ld a, $01
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
    call clear_mem
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
    set 4, a ; LCDCF_BG8000
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
    bit LCDCF_ON_F, a
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

SECTION "vwf_draw_char", ROM0[$0723]
vwf_char_draw::
    ld a, [w_vwf_char_start_x]
    and $07
    ld c, a
    ld b, $00
    ld hl, .pixel_masks_right
    add hl, bc
    ld a, [hl]
    ld [w_c363], a
    ld a, [w_vwf_char_end_x]
    and $07
    ld c, a
    ld b, $00
    ld hl, .pixel_masks_left
    add hl, bc
    ld a, [hl]
    ld [w_c364], a
    ld a, [w_vwf_char_start_x]
    and $f8
    ld c, a
    ld a, [w_vwf_char_end_x]
    and $f8
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
    and $07
    ld c, a
    add $38
    ld [w_c368], a
    ld b, $00
    ld hl, .pixel_masks_right
    add hl, bc
    ld a, [hl]
    ld [w_c369], a
    ld hl, .data_00_0a2c
    add hl, bc
    ld a, [hl]
    ld [w_c36a], a
    ld a, [w_vwf_char_addr + 0]
    ld c, a
    ld a, [w_vwf_char_addr + 1]
    ld b, a
    ld a, [w_bank_rom]
    push af
    ld a, [w_vwf_char_bank]
    ld [w_bank_rom], a
    ld [rROMB0], a

    ld de, w_vwf_char_buffer
    ld a, [w_vwf_char_start_y]
    ld l, a
    ld a, [w_vwf_char_start_x]
    and $f8
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
    ld a, [w_bank_rom]
    push af
    ld a, $23 ; BANK(???)
    ld [w_bank_rom], a
    ld [rROMB0], a
    push bc
    push de
    ld b, h
    ld c, l
    ld a, l
    and $f8
    srl a
    srl a
    ld e, a
    ld d, $00
    ld a, [w_cd6d]
    ld l, a
    ld a, [w_cd6e]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, b
    and $f8
    srl a
    srl a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, c
    and $07
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
    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
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
    adc $00
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
    ld a, [w_bank_rom]
    push af
    ld a, $23 ; BANK(???)
    ld [w_bank_rom], a
    ld [rROMB0], a
    push bc
    push de
    ld b, h
    ld c, l
    ld a, l
    and $f8
    srl a
    srl a
    ld e, a
    ld d, $00
    ld a, [w_cd6d]
    ld l, a
    ld a, [w_cd6e]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, b
    and $f8
    srl a
    srl a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, c
    and $07
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
    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
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
    adc $00
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
    ld a, [w_bank_rom]
    push af
    ld a, $23 ; BANK(???)
    ld [w_bank_rom], a
    ld [rROMB0], a
    push bc
    push de
    ld b, h
    ld c, l
    ld a, l
    and $f8
    srl a
    srl a
    ld e, a
    ld d, $00
    ld a, [w_cd6d]
    ld l, a
    ld a, [w_cd6e]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, b
    and $f8
    srl a
    srl a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, c
    and $07
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
    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
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
    adc $00
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
    and $0f
    jr nz, .jr_000_09bc

    ld a, c
    add $f0
    ld c, a
    ld a, b
    adc $00
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
    bit LCDCF_ON_F, a
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
    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
    ret

.write_tile_ignore_hblank_loop
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

.pixel_masks_right:
    db $ff, $7f, $3f, $1f, $0f, $07, $03, $01

.data_00_0a2c:
    db $00

.pixel_masks_left:
    db $80, $c0, $e0, $f0, $f8, $fc, $fe, $ff

    db $00, $00, $68, $01, $d0, $02, $38, $04, $a0, $05, $08, $07, $70, $08, $d8, $09, $40, $0b, $a8, $0c, $fa, $57, $c3, $a7, $c8, $f0, $00, $f6, $30, $e0, $00, $f0, $4d, $3e, $01, $e0, $4d, $10, $6f

SECTION "farcall_a_hl", ROM0[$0d36]
farcall_a_hl::
    ld [w_bank_temp], a
    ld a, [w_bank_rom]
    push af
    ld a, [w_bank_temp]
    ld [w_bank_rom], a
    ld [rROMB0], a
    ld de, .return
    push de
    ld a, [w_bank_rom]
    ld e, a
    push de
    jp hl

.return
    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
    ret

SECTION "function_00_0d58, etc", ROM0[$0d58]
function_00_0d58::
    push hl
    ldh a, [rLCDC]
    bit LCDCF_ON_F, a
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
    res 0, a ; IEF_VBLANK
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
    call $4000
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

SECTION "clear_mem", ROM0[$0f38]
; Zeroes out RAM
; Parameters:
; hl - dest
; bc - length
clear_mem::
    xor a
    ld [hl+], a
    dec bc
    ld a, c
    or b
    jr nz, clear_mem
    ret

SECTION "vram_copy", ROM0[$0fbd]
; Parameters:
; a - bank
; hl - source
; de - dest
; bc - length
vram_copy::
    ld [w_bank_temp], a
    ld a, [w_bank_rom]
    push af
    ld a, [w_bank_temp]
    ld [w_bank_rom], a
    ld [rROMB0], a

.loop
    ldh a, [rLCDC]
    bit 7, a
    jr z, .in_vblank

.wait_vblank
    ldh a, [rSTAT]
    and $03
    jr z, .wait_vblank

.in_vblank
    ldh a, [rSTAT]
    and $03
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

    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
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

SECTION "function_00_1120", ROM0[$1120]
; Wait for 70,000 * bc clock cycles (17,500 * bc machine cycles)
function_00_1120::
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
    jr nz, function_00_1120
    ret

SECTION "home_text", ROM0[$1883]
text_print::
    ld a, [w_bank_rom]
    push af
    ld a, BANK(strings_pointers)
    ld [w_bank_rom], a
    ld [rROMB0], a

    ; Get string address
    ld hl, strings_pointers
    ld a, [w_text_index + 0]
    ld c, a
    ld a, [w_text_index + 1]
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

    ; Get text cooredinates
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
    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
    ret

; Returns:
; a - character width
; Parameters:
; de - character to print
; b - x position
; c - y position
text_draw_char:
    ld a, [w_bank_rom]
    push af
    ld a, BANK(text_chars_offsets)
    ld [w_bank_rom], a
    ld [rROMB0], a
    push de

    ; Get char address
    sla e
    rl d
    ld hl, text_chars_offsets
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, gfx_text_chars_bw
    add hl, de
    ld a, l
    ld [w_vwf_char_addr + 0], a
    ld a, h
    ld [w_vwf_char_addr + 1], a
    ld a, BANK(gfx_text_chars_bw)
    ld [w_vwf_char_bank], a

    ld a, b
    ld [w_vwf_char_start_x], a

    ; Get character width
    pop de
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
    pop af
    ld [w_bank_rom], a
    ld [rROMB0], a
    ld a, e
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
    bit 7, a ; transfer start flag
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
