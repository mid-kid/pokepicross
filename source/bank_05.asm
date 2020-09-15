INCLUDE "hardware.inc"
INCLUDE "macros.inc"

SECTION "tutorial", ROMX[$4000], BANK[$05]

tutorial::
    ld a, [w_cdd2_jumptable_index]
    rst jumptable
    const_def
    const_dw TUTORIAL_0, function_05_400a
    const_dw TUTORIAL_1, function_05_401b
    const_dw TUTORIAL_2, function_05_4028

function_05_400a:
    xor a
    ld [w_d535], a
    ld a, $00
    ld [w_d550], a
    ld a, TUTORIAL_2
    ld [w_cdd2_jumptable_index], a
    jp farcall_ret

function_05_401b:
    ld a, $01
    ld [w_d550], a
    ld a, TUTORIAL_2
    ld [w_cdd2_jumptable_index], a
    jp farcall_ret

function_05_4028:
    xor a ; TUTORIAL_0
    ld [w_cdd2_jumptable_index], a
    ld a, [w_c357]
    and a
    jr z, .jr_005_4048
    ld a, $01
    call function_00_1bd5
    call function_00_1bd5
    ld hl, _VRAM
    ld bc, $1000
    call mem_clear
    ld a, $00
    call function_00_1bd5
.jr_005_4048

    ld a, 13
    ld [w_textbox_x], a
    ld [w_textbox_cur_x], a
    ld a, 95
    ld [w_textbox_y], a
    ld [w_textbox_cur_y], a
    ld a, 147
    ld [w_textbox_width], a
    ld a, 141
    ld [w_textbox_height], a
    ld16 w_textbox_cur_string, tutorial_message_00
    ld a, $01
    ld [w_d6ca], a
    ld a, [w_d61b]
    push af
    xor a
    ld [w_d61b], a
    xor a
    ld [w_d647], a
    ld [w_tutorial_scene], a
    ld [w_d642], a

.loop
    call function_00_1094
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
    ld a, $01
    ld [w_c325], a

    ld a, [w_c326]
    bit 3, a
    jp nz, .done

    ld a, [w_d550]
    and a
    jr z, .jr_005_40b8

    ld a, [w_c326]
    and a
    jp nz, .done

.jr_005_40b8
    ld a, [w_c329]
    ld [w_d6c9], a
    farcall function_09_5a50
    farcall tutorial_scene
    farcall function_29_4461
    ld a, [w_d647]
    and a
    jp nz, .done
    jp .loop

.done
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
    ld a, $01
    ld [w_c325], a
    ld a, $01
    ld c, $00
    call function_00_0d91
    call function_00_0d58
    ld c, $00
    ld a, $01
    call function_00_0d91
    ld bc, $003c
    call function_00_10fb
    ld a, $05
    call function_00_0d91
    farcall function_02_4f6d
    call function_00_1de7
    call function_00_0ecf
    farcall function_29_5e90
    pop af
    ld [w_d61b], a
    ld a, $00
    ld [w_d550], a
    ld a, [w_d630]
    ld [w_cdd2_jumptable_index], a
    ld a, [w_d62d]
    ld [w_cdd1], a
    jp farcall_ret

tutorial_scene::
    ld a, [w_tutorial_scene]
    rst jumptable
    const_def
    const_dw TUTORIAL_SCENE_00, tutorial_scene_00
    const_dw TUTORIAL_SCENE_01, tutorial_scene_01
    const_dw TUTORIAL_SCENE_02, tutorial_scene_02
    const_dw TUTORIAL_SCENE_03, tutorial_scene_03
    const_dw TUTORIAL_SCENE_04, tutorial_scene_04
    const_dw TUTORIAL_SCENE_05, tutorial_scene_05
    const_dw TUTORIAL_SCENE_06, tutorial_scene_06
    const_dw TUTORIAL_SCENE_07, tutorial_scene_07
    const_dw TUTORIAL_SCENE_08, tutorial_scene_08
    const_dw TUTORIAL_SCENE_09, tutorial_scene_09
    const_dw TUTORIAL_SCENE_10, tutorial_scene_10
    const_dw TUTORIAL_SCENE_11, tutorial_scene_11
    const_dw TUTORIAL_SCENE_12, tutorial_scene_12
    const_dw TUTORIAL_SCENE_13, tutorial_scene_13
    const_dw TUTORIAL_SCENE_14, tutorial_scene_14
    const_dw TUTORIAL_SCENE_15, tutorial_scene_15
    const_dw TUTORIAL_SCENE_16, tutorial_scene_16
    const_dw TUTORIAL_SCENE_17, tutorial_scene_17
    const_dw TUTORIAL_SCENE_18, tutorial_scene_18
    const_dw TUTORIAL_SCENE_19, tutorial_scene_19
    const_dw TUTORIAL_SCENE_20, tutorial_scene_20
    const_dw TUTORIAL_SCENE_21, tutorial_scene_21
    const_dw TUTORIAL_SCENE_22, tutorial_scene_22
    const_dw TUTORIAL_SCENE_23, tutorial_scene_23
    const_dw TUTORIAL_SCENE_24, tutorial_scene_24
    const_dw TUTORIAL_SCENE_25, tutorial_scene_25
    const_dw TUTORIAL_SCENE_26, tutorial_scene_26
    const_dw TUTORIAL_SCENE_27, tutorial_scene_27
    const_dw TUTORIAL_SCENE_28, tutorial_scene_28
    const_dw TUTORIAL_SCENE_29, tutorial_scene_29
    const_dw TUTORIAL_SCENE_30, tutorial_scene_30
    const_dw TUTORIAL_SCENE_31, tutorial_scene_31
    const_dw TUTORIAL_SCENE_32, tutorial_scene_32
    const_dw TUTORIAL_SCENE_33, tutorial_scene_33
    const_dw TUTORIAL_SCENE_34, tutorial_scene_34
    const_dw TUTORIAL_SCENE_35, tutorial_scene_35
    const_dw TUTORIAL_SCENE_36, tutorial_scene_36
    const_dw TUTORIAL_SCENE_37, tutorial_scene_37
    const_dw TUTORIAL_SCENE_38, tutorial_scene_38
    const_dw TUTORIAL_SCENE_39, tutorial_scene_39
    const_dw TUTORIAL_SCENE_40, tutorial_scene_40
    const_dw TUTORIAL_SCENE_41, tutorial_scene_41
    const_dw TUTORIAL_SCENE_42, tutorial_scene_42
    const_dw TUTORIAL_SCENE_43, tutorial_scene_43
    const_dw TUTORIAL_SCENE_44, tutorial_scene_44
    const_dw TUTORIAL_SCENE_45, tutorial_scene_45
    const_dw TUTORIAL_SCENE_46, tutorial_scene_46
    const_dw TUTORIAL_SCENE_47, tutorial_scene_47
    const_dw TUTORIAL_SCENE_48, tutorial_scene_48
    const_dw TUTORIAL_SCENE_49, tutorial_scene_49
    const_dw TUTORIAL_SCENE_50, tutorial_scene_50
    const_dw TUTORIAL_SCENE_51, tutorial_scene_51
    const_dw TUTORIAL_SCENE_52, tutorial_scene_52
    const_dw TUTORIAL_SCENE_53, tutorial_scene_53
    const_dw TUTORIAL_SCENE_54, tutorial_scene_54
    const_dw TUTORIAL_SCENE_55, tutorial_scene_55
    const_dw TUTORIAL_SCENE_56, tutorial_scene_56
    const_dw TUTORIAL_SCENE_57, tutorial_scene_57
    const_dw TUTORIAL_SCENE_58, tutorial_scene_58
    const_dw TUTORIAL_SCENE_59, tutorial_scene_59
    const_dw TUTORIAL_SCENE_60, tutorial_scene_60
NUM_TUTORIAL_SCENES EQU const_value

tutorial_scene_00:
    ld a, [w_cdd2_jumptable_index]
    cp 4
    jr nz, .not_done
    ld hl, w_tutorial_scene
    inc [hl]
.not_done
    jp farcall_ret

tutorial_scene_01:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_01

    xor a
    ld [w_cdb0], a
    ld [w_cdaf], a
    ld a, $39
    ld [w_cdac], a
    ld a, $0e
    ld [w_cdad], a
    ld16 w_cdb1, tutorial_data_42c8
    ld a, $05
    ld [w_cdb3], a
    ld a, 60
    ld [w_textbox_delay_timer], a
    farcall function_02_5b67

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_data_42c8:
    db $08, $00, $00, $e5, $08, $00, $00, $e6, $08, $00, $00, $e7, $08, $00, $00, $e6, $00

tutorial_scene_02:
    ld a, $00
    call function_00_17fb
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_03:
    ld a, $00
    call function_00_17fb
    farcall function_29_5de4
    farcall textbox_delay
    jp nz, farcall_ret

    ld16 w_textbox_cur_string, tutorial_message_02

    xor a
    ld [w_cdb0], a
    ld [w_cdaf], a
    ld a, $16
    ld [w_cdac], a
    ld a, $31
    ld [w_cdad], a
    ld16 w_cdb1, tutorial_data_42c8
    ld a, $05
    ld [w_cdb3], a
    ld a, 60
    ld [w_textbox_delay_timer], a
    farcall function_02_5b67

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_04:
    ld a, $00
    call function_00_17fb
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_05:
    ld a, $00
    call function_00_17fb
    farcall function_29_5de4
    farcall textbox_delay
    jp nz, farcall_ret

    ld16 w_textbox_cur_string, tutorial_message_03

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_06:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_04
    ld a, 10
    ld [w_textbox_delay_timer], a

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_07:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_08:
    farcall function_29_5de4
    farcall textbox_delay
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_09:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    xor a
    ld [w_d54a], a
    ld [w_d54b], a
    ld16 w_d54c, .data
    farcall function_02_5b67
    ld a, $00
    ld [w_d6ca], a

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

.data:
    db $00, $00, $01, $80, $01, $80, $01, $80, $01, $80, $01, $00, $00, $40, $40, $40, $40, $10, $00, $00, $01, $80, $01, $80, $01, $80, $01, $80, $01, $00, $00, $40, $40, $40, $40, $10, $00, $00, $01, $80, $01, $80, $01, $80, $01, $80, $01, $00, $00, $40, $40, $40, $40, $10, $10, $00, $00, $01, $80, $01, $80, $01, $80, $01, $80, $01, $00, $00, $40, $40, $40, $40, $20, $00, $00, $01, $80, $80, $01, $80, $01, $80, $01, $00, $00, $00, $00, $00, $00, $ff

tutorial_scene_10:
    farcall function_29_5de4
    farcall textbox_delay
    farcall function_05_5f2f
    jp nz, farcall_ret

    ld a, $01
    ld [w_d6ca], a
    farcall function_06_4964
    farcall function_29_4ef5
    ld a, 10
    ld [w_textbox_delay_timer], a
    farcall function_02_5b67

    ld16 w_textbox_cur_string, tutorial_message_05

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_11:
    farcall function_06_4964
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_06_4964
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_06

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_12:
    farcall function_06_4964
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink
    call function_00_1085
    farcall function_06_4964
    farcall function_02_5b98
    farcall function_02_5560
    farcall function_02_5a82

    ld16 w_textbox_cur_string, tutorial_message_07

    xor a
    ld [w_cdb0], a
    ld [w_cdaf], a
    ld a, $39
    ld [w_cdac], a
    ld a, $0e
    ld [w_cdad], a
    ld16 w_cdb1, tutorial_data_42c8
    ld a, $05
    ld [w_cdb3], a
    ld a, 60
    ld [w_textbox_delay_timer], a
    farcall function_02_5b67

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_13:
    ld a, $00
    call function_00_17fb
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_14:
    ld a, $00
    call function_00_17fb
    farcall function_29_5de4
    farcall textbox_delay
    jp nz, farcall_ret

    ld16 w_textbox_cur_string, tutorial_message_08

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_15:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_09

    xor a
    ld [w_cdb0], a
    ld [w_cdaf], a
    ld a, $39
    ld [w_cdac], a
    ld a, $0e
    ld [w_cdad], a
    ld16 w_cdb1, tutorial_data_497d
    ld a, $05
    ld [w_cdb3], a
    ld a, 60
    ld [w_textbox_delay_timer], a
    farcall function_02_5b67

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_data_497d:
    db $08, $00, $00, $df, $08, $00, $00, $e0, $08, $00, $00, $e1, $08, $00, $00, $e0, $00

tutorial_scene_16:
    farcall function_29_5de4
    farcall function_02_56c0
    ld a, $00
    call function_00_17fb
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_17:
    farcall function_29_5de4
    ld a, $00
    call function_00_17fb
    farcall textbox_delay
    jp nz, farcall_ret

    ld16 w_textbox_cur_string, tutorial_message_10

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_18:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    xor a
    ld [w_d54a], a
    ld [w_d54b], a
    ld16 w_d54c, .data
    ld a, $00
    ld [w_cdd6], a
    ld a, $00
    ld [w_cdd7], a
    farcall function_02_5b67
    ld a, $00
    ld [w_d6ca], a

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

.data:
    db $00, $00, $01, $80, $01, $80, $01, $80, $01, $80, $01, $00, $00, $ff

tutorial_scene_19:
    farcall function_29_5de4
    farcall textbox_delay
    farcall function_05_5f2f
    jp nz, farcall_ret

    ld a, $01
    ld [w_d6ca], a
    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98
    farcall function_02_5a82

    xor a
    ld [w_cdb0], a
    ld [w_cdaf], a
    ld a, $16
    ld [w_cdac], a
    ld a, $31
    ld [w_cdad], a
    ld16 w_cdb1, tutorial_data_42c8
    ld a, $05
    ld [w_cdb3], a
    ld a, 60
    ld [w_textbox_delay_timer], a

    ld16 w_textbox_cur_string, tutorial_message_11

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_20:
    farcall function_29_5de4
    farcall function_02_56c0
    ld a, $00
    call function_00_17fb
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_21:
    farcall function_29_5de4
    ld a, $00
    call function_00_17fb
    farcall textbox_delay
    jp nz, farcall_ret

    ld16 w_textbox_cur_string, tutorial_message_12

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_22:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    ld16 w_textbox_cur_string, tutorial_message_13

    call function_00_1085
    farcall function_02_5b98

    xor a
    ld [w_cdb0], a
    ld [w_cdaf], a
    ld a, $16
    ld [w_cdac], a
    ld a, $37
    ld [w_cdad], a
    ld16 w_cdb1, tutorial_data_4c91
    ld a, $05
    ld [w_cdb3], a
    ld a, 60
    ld [w_textbox_delay_timer], a

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_data_4c91:
    db $08, $00, $00, $e2, $08, $00, $00, $e3, $08, $00, $00, $e4, $08, $00, $00, $e3, $00

tutorial_scene_23:
    farcall function_29_5de4
    farcall function_02_56c0
    ld a, $00
    call function_00_17fb
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_24:
    farcall function_29_5de4
    ld a, $00
    call function_00_17fb
    farcall textbox_delay
    jp nz, farcall_ret

    ld16 w_textbox_cur_string, tutorial_message_14

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_25:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    xor a
    ld [w_d54a], a
    ld [w_d54b], a
    ld16 w_d54c, .data
    ld a, $00
    ld [w_cdd6], a
    ld a, $01
    ld [w_cdd7], a
    farcall function_02_5b67
    ld a, $00
    ld [w_d6ca], a

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

.data:
    db $00, $00, $01, $10, $01, $10, $01, $10, $10, $01, $00, $00, $ff

tutorial_scene_26:
    farcall function_29_5de4
    farcall textbox_delay
    farcall function_05_5f2f
    jp nz, farcall_ret

    ld a, $01
    ld [w_d6ca], a
    call function_00_1085
    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    ld hl, w_tutorial_scene
    inc [hl]

    ld16 w_textbox_cur_string, tutorial_message_15

    call function_00_1085
    farcall function_02_5b98
    jp farcall_ret

tutorial_scene_27:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, $00
    ld [w_d521], a
    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_28:
    farcall function_29_5de4
    farcall textbox_delay
    farcall function_02_58fe

    ld hl, w_cdfd
    ld a, [hl+]
    or [hl]
    inc hl
    or [hl]
    inc hl
    or [hl]
    jp nz, farcall_ret

    ld a, $02
    ld [w_ce00], a
    farcall function_3c_4377

    ld16 w_textbox_cur_string, tutorial_message_16

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_29:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    ld hl, w_tutorial_scene
    inc [hl]

    ld16 w_textbox_cur_string, tutorial_message_17

    call function_00_1085
    farcall function_02_5b98
    farcall function_27_4bf4
    farcall function_02_5790
    jp farcall_ret

tutorial_scene_30:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    xor a
    ld [w_d6ca], a
    xor a
    ld [w_d54a], a
    ld [w_d54b], a
    ld16 w_d54c, .data
    ld a, $03
    ld [w_cdd6], a
    ld a, $01
    ld [w_cdd7], a
    farcall function_02_5b67

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

.data:
    db $00, $00, $01, $00, $00, $00, $00, $ff

tutorial_scene_31:
    farcall function_29_5de4
    farcall textbox_delay
    farcall function_05_5f2f
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_32:
    farcall function_29_5de4
    farcall textbox_delay
    ld a, [$cde0]
    and a
    jp nz, farcall_ret

    call function_00_1085

    ld16 w_textbox_cur_string, tutorial_message_18

    ld a, $01
    ld [w_d6ca], a

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_33:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    ld hl, w_tutorial_scene
    inc [hl]

    ld16 w_textbox_cur_string, tutorial_message_19

    call function_00_1085
    farcall function_02_5b98
    jp farcall_ret

tutorial_scene_34:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, $00
    ld [w_d6ca], a
    xor a
    ld [w_d54a], a
    ld [w_d54b], a
    ld16 w_d54c, .data
    ld a, $03
    ld [w_cdd6], a
    ld a, $01
    ld [w_cdd7], a
    farcall function_02_5b67

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

.data:
    db $00, $00, $02, $00, $00, $00, $00, $ff

tutorial_scene_35:
    farcall function_29_5de4
    farcall textbox_delay
    farcall function_05_5f2f
    jp nz, farcall_ret

    ld a, [w_cde0]
    and a
    jp nz, farcall_ret

    ld a, $01
    ld [w_d6ca], a
    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98
    farcall function_02_5a82
    farcall function_29_7421

    ld16 w_textbox_cur_string, tutorial_message_20

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_36:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, $01
    ld [w_d60f], a
    farcall function_29_5579
    ld a, TUTORIAL_2
    ld [w_cdd2_jumptable_index], a
    xor a
    ld [w_d54a], a
    ld [w_d54b], a
    ld16 w_d54c, .data

    ld hl, w_tutorial_scene
    inc [hl]

    xor a
    ld [w_c326], a
    ld [w_c329], a
    ld [w_c32c], a
    ld [w_c327], a
    ld [w_c32a], a
    ld [w_c32d], a
    ld a, $ff
    ld [w_c330], a
    jp farcall_ret

.data:
    db $20, $00, $00, $ff

tutorial_scene_37:
    farcall function_29_5de4
    farcall textbox_delay
    farcall function_05_5f2f
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_21

    ld a, $01
    ld [w_c329], a

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret


tutorial_scene_38:
    farcall function_29_5de4
    ld hl, w_d538
    ld a, $01
    ld [hl+], a
    ld [hl], a
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    ld a, $01
    ld [w_c329], a

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_39:
    farcall function_29_5de4
    farcall textbox_delay
    ld a, [w_d536]
    cp $3f
    jp c, farcall_ret

    ld16 w_textbox_cur_string, tutorial_message_22

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_40:
    farcall function_29_5de4
    ld hl, w_d538
    ld a, $01
    ld [hl+], a
    ld [hl], a
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    ld a, $01
    ld [w_c329], a

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_41:
    farcall function_29_5de4
    farcall textbox_delay
    ld a, [w_d537]
    cp $3f
    jp c, farcall_ret

    ld16 w_textbox_cur_string, tutorial_message_23

    call function_00_1085
    farcall function_02_5b98

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_42:
    farcall function_29_5de4
    farcall function_09_5a50
    farcall function_08_42b8
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    farcall function_22_61e8
    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_24

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_43:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98
    farcall function_02_5a82

    ld16 w_textbox_cur_string, tutorial_message_25

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_44:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    xor a
    ld [w_d54a], a
    ld [w_d54b], a
    ld16 w_d54c, .data
    farcall function_02_5b67
    xor a
    ld [w_cdd6], a
    ld [w_cdd7], a
    ld a, $00
    ld [w_d6ca], a
    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

.data:
    db $00, $00, $01, $80, $01, $80, $01, $80, $01, $80, $01, $00, $00, $40, $40, $40, $40, $10, $00, $00, $01, $80, $01, $80, $01, $80, $01, $80, $01, $00, $00, $40, $40, $40, $40, $10, $00, $00, $01, $80, $01, $80, $01, $80, $01, $80, $01, $00, $00, $40, $40, $40, $40, $10, $10, $00, $00, $01, $80, $01, $80, $01, $80, $01, $80, $01, $00, $00, $40, $40, $40, $40, $20, $00, $00, $01, $80, $80, $01, $80, $01, $80, $00, $00, $00, $00, $00, $00, $ff

tutorial_scene_45:
    farcall function_29_5de4
    farcall textbox_delay
    farcall function_05_5f2f
    jp nz, farcall_ret

    ld a, $01
    ld [w_d6ca], a
    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    ld16 w_textbox_cur_string, tutorial_message_26

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_46:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    ld a, $04
    ld [w_c326], a
    farcall function_22_47e2
    ld a, $00
    ld [w_c326], a
    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_27

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_47:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_28

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_48:
    ld a, $04
    ld [w_c329], a
    ld [w_c326], a
    ld [w_c32c], a
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    xor a
    ld [w_c326], a
    ld [w_c329], a
    ld [w_c32c], a
    ld [w_c327], a
    ld [w_c32a], a
    ld [w_c32d], a
    ld a, $ff
    ld [w_c330], a
    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall function_02_4147
    farcall function_22_47e2
    call function_00_1085
    farcall function_02_5b98
    farcall function_02_5a82

    ld16 w_textbox_cur_string, tutorial_message_29

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_49:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_30

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_50:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_31

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_51:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_32

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_52:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]

    ld a, 120
    ld [w_textbox_delay_timer], a
    xor a
    ld [w_cdb0], a
    ld [w_cdaf], a
    ld a, $0c
    ld [w_cdac], a
    ld a, $27
    ld [w_cdad], a

    ld16 w_cdb1, tutorial_data_5b4e
    ld a, $05
    ld [w_cdb3], a
    jp farcall_ret

tutorial_data_5b4e:
    db $08, $00, $00, $ee, $08, $00, $00, $ef, $08, $00, $00, $f0, $08, $00, $00, $ef, $00

tutorial_scene_53:
    ld a, $00
    call function_00_17fb
    farcall textbox_delay
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_33

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_54:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld hl, w_tutorial_scene
    inc [hl]

    ld c, $17
    ld a, $02
    call function_00_0d91
    ld a, $01
    ld [w_d52e], a
    farcall function_27_4bf4

    ld a, 120
    ld [w_textbox_delay_timer], a
    xor a
    ld [w_cdb0], a
    ld [w_cdaf], a
    ld a, $0c
    ld [w_cdac], a
    ld a, $27
    ld [w_cdad], a
    ld16 w_cdb1, tutorial_data_5b4e
    ld a, $05
    ld [w_cdb3], a
    jp farcall_ret

tutorial_scene_55:
    ld a, $00
    call function_00_17fb
    farcall textbox_delay
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_34

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_56:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_35

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_57:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_36

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_58:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_37

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_59:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98

    ld16 w_textbox_cur_string, tutorial_message_38

    ld hl, w_tutorial_scene
    inc [hl]
    jp farcall_ret

tutorial_scene_60:
    farcall function_29_5de4
    farcall function_02_56c0
    farcall far_textbox_print_char
    jp nz, farcall_ret

    ld a, BANK(function_02_5b77)
    ld hl, function_02_5b77
    farcall wait_press_a_blink

    call function_00_1085
    farcall function_02_5b98
    farcall function_02_5a82
    ld a, $01
    ld [w_d647], a
    jp farcall_ret
