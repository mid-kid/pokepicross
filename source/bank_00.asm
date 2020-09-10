INCLUDE "hardware.inc"

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
    ld hl, .Data_000_0a2c
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

.Jump_000_07a9
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
    jp .Jump_000_0911

.jr_000_07d3
    push hl
    ld a, [w_bank_rom]
    push af
    ld a, $23
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
    jp z, .Jump_000_090b

.Jump_000_085f
    push af
    push hl
    ld a, [w_bank_rom]
    push af
    ld a, $23
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
    jp nz, .Jump_000_085f

.Jump_000_090b
    ld a, [w_c364]
    ld [w_c362], a

.Jump_000_0911
    ld a, [w_bank_rom]
    push af
    ld a, $23
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
    jp nc, .Jump_000_07a9

    xor a
    ld [de], a
    inc de
    ld [de], a

	; Write tiles stored in the buffer
    ld bc, w_vwf_char_buffer

	; Ignore hblank (update during vblank?)
    ld a, [w_c336]
    bit 7, a
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

.Data_000_0a2c:
	db $00

.pixel_masks_left:
	db $80, $c0, $e0, $f0, $f8, $fc, $fe, $ff

	db $00, $00, $68, $01, $d0, $02, $38, $04, $a0, $05, $08, $07, $70, $08, $d8, $09, $40, $0b, $a8, $0c, $fa, $57, $c3, $a7, $c8, $f0, $00, $f6, $30, $e0, $00, $f0, $4d, $3e, $01, $e0, $4d, $10, $6f

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

SECTION "farcall", ROM0[$10cd]
; Save current bank and jump to w_farcall_target in w_bank_temp
farcall::
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

SECTION "text_chars_offsets", ROM0[$286f]
text_chars_widths::
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 4
    db 7
    db 7
    db 6
    db 6
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 8
    db 7
    db 6
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 6
    db 6
    db 6
    db 6
    db 7
    db 6
    db 7
    db 6
    db 7
    db 5
    db 5
    db 5
    db 4
    db 9
    db 8
    db 7
    db 8
    db 8
    db 9
    db 7
    db 9
    db 8
    db 8
    db 8
    db 8
    db 8
    db 8
    db 8
    db 9
    db 9
    db 9
    db 8
    db 9
    db 9
    db 9
    db 9
    db 8
    db 10
    db 5
    db 5
    db 4
    db 4
    db 5
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 5
    db 7
    db 7
    db 6
    db 7
    db 6
    db 7
    db 7
    db 7
    db 8
    db 7
    db 7
    db 6
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 6
    db 7
    db 6
    db 7
    db 7
    db 7
    db 7
    db 5
    db 5
    db 5
    db 4
    db 9
    db 8
    db 9
    db 9
    db 9
    db 8
    db 8
    db 9
    db 9
    db 9
    db 9
    db 8
    db 8
    db 9
    db 6
    db 8
    db 8
    db 9
    db 8
    db 8
    db 9
    db 7
    db 8
    db 8
    db 8
    db 5
    db 4
    db 5
    db 5
    db 5
    db 6
    db 4
    db 6
    db 6
    db 6
    db 6
    db 6
    db 6
    db 6
    db 6
    db 5
    db 7
    db 6
    db 7
    db 6
    db 6
    db 6
    db 7
    db 6
    db 3
    db 7
    db 6
    db 6
    db 7
    db 7
    db 7
    db 6
    db 7
    db 6
    db 6
    db 7
    db 7
    db 7
    db 7
    db 7
    db 7
    db 6
    db 6
    db 5
    db 5
    db 5
    db 5
    db 6
    db 6
    db 5
    db 1
    db 5
    db 5
    db 2
    db 7
    db 5
    db 5
    db 5
    db 5
    db 5
    db 5
    db 5
    db 5
    db 5
    db 7
    db 6
    db 6
    db 5
    db 0
    db 4
    db 4
    db 5
    db 5
    db 8
    db 5
    db 5
    db 4
    db 5
    db 5
    db 2
    db 2
    db 2
    db 4
    db 3
    db 3
    db 7
    db 8
    db 5
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0

text_chars_offsets::
    dw $0000
    dw $0020
    dw $0040
    dw $0060
    dw $0080
    dw $00a0
    dw $00c0
    dw $00e0
    dw $0104
    dw $0124
    dw $0144
    dw $0164
    dw $0184
    dw $01a4
    dw $01c4
    dw $01e4
    dw $0208
    dw $0228
    dw $0248
    dw $0268
    dw $0288
    dw $02a8
    dw $02c8
    dw $02e8
    dw $030c
    dw $032c
    dw $034c
    dw $036c
    dw $038c
    dw $03ac
    dw $03cc
    dw $03ec
    dw $0500
    dw $0520
    dw $0540
    dw $0560
    dw $0580
    dw $05a0
    dw $05c0
    dw $05e0
    dw $0604
    dw $0624
    dw $0644
    dw $0664
    dw $0684
    dw $06a4
    dw $06c4
    dw $06e4
    dw $0708
    dw $0728
    dw $0748
    dw $0768
    dw $0788
    dw $07a8
    dw $07c8
    dw $07e8
    dw $080c
    dw $082c
    dw $084c
    dw $086c
    dw $088c
    dw $08ac
    dw $08cc
    dw $08ec
    dw $0a00
    dw $0a20
    dw $0a40
    dw $0a60
    dw $0a80
    dw $0aa0
    dw $0ac0
    dw $0ae0
    dw $0b04
    dw $0b24
    dw $0b44
    dw $0b64
    dw $0b84
    dw $0ba4
    dw $0bc4
    dw $0be4
    dw $0c08
    dw $0c28
    dw $0c48
    dw $0c68
    dw $0c88
    dw $0ca8
    dw $0cc8
    dw $0ce8
    dw $0d0c
    dw $0d2c
    dw $0d4c
    dw $0d6c
    dw $0d8c
    dw $0dac
    dw $0dcc
    dw $0dec
    dw $0f00
    dw $0f20
    dw $0f40
    dw $0f60
    dw $0f80
    dw $0fa0
    dw $0fc0
    dw $0fe0
    dw $1004
    dw $1024
    dw $1044
    dw $1064
    dw $1084
    dw $10a4
    dw $10c4
    dw $10e4
    dw $1108
    dw $1128
    dw $1148
    dw $1168
    dw $1188
    dw $11a8
    dw $11c8
    dw $11e8
    dw $120c
    dw $122c
    dw $124c
    dw $126c
    dw $128c
    dw $12ac
    dw $12cc
    dw $12ec
    dw $1400
    dw $1420
    dw $1440
    dw $1460
    dw $1480
    dw $14a0
    dw $14c0
    dw $14e0
    dw $1504
    dw $1524
    dw $1544
    dw $1564
    dw $1584
    dw $15a4
    dw $15c4
    dw $15e4
    dw $1608
    dw $1628
    dw $1648
    dw $1668
    dw $1688
    dw $16a8
    dw $16c8
    dw $16e8
    dw $170c
    dw $172c
    dw $174c
    dw $176c
    dw $178c
    dw $17ac
    dw $17cc
    dw $17ec
    dw $1900
    dw $1920
    dw $1940
    dw $1960
    dw $1980
    dw $19a0
    dw $19c0
    dw $19e0
    dw $1a04
    dw $1a24
    dw $1a44
    dw $1a64
    dw $1a84
    dw $1aa4
    dw $1ac4
    dw $1ae4
    dw $1b08
    dw $1b28
    dw $1b48
    dw $1b68
    dw $1b88
    dw $1ba8
    dw $1bc8
    dw $1be8
    dw $1c0c
    dw $1c2c
    dw $1c4c
    dw $1c6c
    dw $1c8c
    dw $1cac
    dw $1ccc
    dw $1cec
    dw $1e00
    dw $1e20
    dw $1e40
    dw $1e60
    dw $1e80
    dw $1ea0
    dw $1ec0
    dw $1ee0
    dw $1f04
    dw $1f24
    dw $1f44
    dw $1f64
    dw $1f84
    dw $1fa4
    dw $1fc4
    dw $1fe4
    dw $2008
    dw $2028
    dw $2048
    dw $2068
    dw $2088
    dw $20a8
    dw $20c8
    dw $20e8
    dw $210c
    dw $212c
    dw $214c
    dw $216c
    dw $218c
    dw $21ac
    dw $21cc
    dw $21ec
    dw $2300
    dw $2320
    dw $2340
    dw $2360
    dw $2380
    dw $23a0
    dw $23c0
    dw $23e0
    dw $2404
    dw $2424
    dw $2444
    dw $2464
    dw $2484
    dw $24a4
    dw $24c4
    dw $24e4
    dw $2508
    dw $2528
    dw $2548
    dw $2568
    dw $2588
    dw $25a8
    dw $25c8
    dw $25e8
    dw $260c
    dw $262c
    dw $264c
    dw $266c
    dw $268c
    dw $26ac
    dw $26cc
    dw $26ec
