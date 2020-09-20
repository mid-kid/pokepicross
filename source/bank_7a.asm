SECTION "gfx_sgb_border_2", ROMX[$4010], BANK[$7a]
gfx_sgb_border_2::
INCBIN "gfx/sgb_border/sgb_border_2.4bpp"
.end::

SECTION "gfx_sgb_border_1", ROMX[$5020], BANK[$7a]
gfx_sgb_border_1::
INCBIN "gfx/sgb_border/sgb_border_1.4bpp"
.end::

SECTION "tilemap_unknown_7a_6020", ROMX[$6020], BANK[$7a]
tilemap_unknown_7a_6020::
INCBIN "gfx/unknown/unknown_7a_6020.tilemap"
.end::
attrmap_unknown_7a_6420::
INCBIN "gfx/unknown/unknown_7a_6420.attrmap"
.end::

SECTION "tilemap_title", ROMX[$7020], BANK[$7a]
tilemap_title::
INCBIN "gfx/title/title.tilemap"
.end::
attrmap_title::
INCBIN "gfx/title/title.attrmap"
.end::

SECTION "compressed_tilemap_attrmap_pokedex_list", ROMX[$7820], BANK[$7a]
compressed_tilemap_attrmap_pokedex_list::
INCBIN "gfx/pokedex/pokedex_list.tilemap_attrmap.xor"
.end::

SECTION "compressed_tilemap_attrmap_pokemon_picross", ROMX[$7d18], BANK[$7a]
compressed_tilemap_attrmap_pokemon_picross::
INCBIN "gfx/game_select/pokemon_picross.tilemap_attrmap.xor"
.end::
