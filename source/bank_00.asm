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
