SECTION "bank75", ROMX[$4000], BANK[$75]

gfx_lv_4_s_s_anne::
INCBIN "gfx/town_map/lv_4_s_s_anne.2bpp"
.end::
gfx_lv_4_s_s_anne_sgb::
INCBIN "gfx/town_map/lv_4_s_s_anne_sgb.2bpp"
.end::
gfx_lv_4_s_s_anne_duplicate::
INCBIN "gfx/town_map/lv_4_s_s_anne.2bpp"
.end::

gfx_lv_5_pokemon_tower::
INCBIN "gfx/town_map/lv_5_pokemon_tower.2bpp"
.end::
gfx_lv_5_pokemon_tower_sgb::
INCBIN "gfx/town_map/lv_5_pokemon_tower_sgb.2bpp"
.end::
gfx_lv_5_pokemon_tower_duplicate::
INCBIN "gfx/town_map/lv_5_pokemon_tower.2bpp"
.end::

SECTION "compressed_gfx_copyright", ROMX[$7d35], BANK[$75]
compressed_gfx_copyright::
INCBIN "gfx/copyright/copyright.2bpp.xor"
.end::
