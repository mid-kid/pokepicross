INCLUDE "macros.inc"
INCLUDE "level_constants.inc"
INCLUDE "puzzle_constants.inc"

SECTION "calc_safari_map_puzzle_index", ROMX[$46B5], BANK[$20]
calc_safari_map_puzzle_index::
    ld a, [w_safari_map_level]
    cp LEVEL_JUNGLE_ZONE
    jp z, calc_safari_map_level_4_puzzle_index
    ld a, [w_safari_map_y]
    ld c, a
    add a
    add a
    add c
    ld c, a
    ld a, [w_safari_map_x]
    add c
    ld c, a
    ld a, [w_safari_map_level]
    add a
    add a
    add a
    add a
    add c
    ld c, a
    ld a, [w_safari_map_level]
    xor $ff
    inc a
    add c
    add SAFARI_ZONE_PUZZLES
    jp farcall_ret

SECTION "calc_safari_map_level_4_puzzle_index", ROMX[$5258], BANK[$20]
calc_safari_map_level_4_puzzle_index::
    ld a, [w_safari_map_y]
    add a
    add a
    ld c, a
    ld a, [w_safari_map_x]
    add c
    ld l, a
    ld h, 0
    ld de, .level_4_puzzles
    add hl, de
    ld a, [hl]
    jp farcall_ret

.level_4_puzzles:
    db PUZZLE_THREE_POKEMON,  PUZZLE_SAFARI_GLOOM,       0, 0
    db PUZZLE_TEAM_ROCKET,    PUZZLE_PIKACHU_AND_TOGEPI, 0, 0
    db PUZZLE_HIDDEN_VILLAGE, PUZZLE_SNOWMAN,            0, 0
    db 0,                     0,                         0, 0
