SECTION "bank7a", ROMX[$7020], BANK[$7a]

tilemap_title::
INCBIN "gfx/title/title.tilemap"
.end::

attrmap_title::
INCBIN "gfx/title/title.attrmap"
.end::

SECTION "compressed_tilemap_attrmap_pokemon_picross", ROMX[$7d18], BANK[$7a]
compressed_tilemap_attrmap_pokemon_picross::
INCBIN "gfx/game_select/pokemon_picross.tilemap_attrmap.xor"
.end::
