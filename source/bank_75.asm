SECTION "bank75", ROMX[$4000], BANK[$75]

gfx_lv_4_s_s_anne::
INCBIN "gfx/levels/lv_4_s_s_anne.bin"
.end::

gfx_lv_4_s_s_anne_sgb::
INCBIN "gfx/levels/lv_4_s_s_anne_sgb.bin"
.end::

gfx_lv_4_s_s_anne_duplicate::
INCBIN "gfx/levels/lv_4_s_s_anne.bin"
.end::

gfx_lv_5_pokemon_tower::
INCBIN "gfx/levels/lv_5_pokemon_tower.bin"
.end::

gfx_lv_5_pokemon_tower_sgb::
INCBIN "gfx/levels/lv_5_pokemon_tower_sgb.bin"
.end::

gfx_lv_5_pokemon_tower_duplicate::
INCBIN "gfx/levels/lv_5_pokemon_tower.bin"
.end::

SECTION "compressed_gfx_copyright", ROMX[$7d35], BANK[$75]
compressed_gfx_copyright::
INCBIN "gfx/copyright/copyright.bin.xor"
.end::
