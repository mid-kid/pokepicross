SECTION "gfx_unknown_6c_4000", ROMX[$4000], BANK[$6c]
gfx_unknown_6c_4000::
INCBIN "gfx/unknown/unknown_6c_4000.2bpp"
.end::

SECTION "gfx_unknown_6c_7000", ROMX[$7000], BANK[$6c]
gfx_unknown_6c_7000::
INCBIN "gfx/unknown/unknown_6c_7000.2bpp"
.end::

SECTION "compressed_tilemap_attrmap_pokedex_pic", ROMX[$7c00], BANK[$6c]
compressed_tilemap_attrmap_pokedex_pic::
INCBIN "gfx/pokedex/pokedex_pic.tilemap_attrmap.xor"
.end::

SECTION "compressed_tilemap_copyright", ROMX[$7eec], BANK[$6c]
compressed_tilemap_copyright::
INCBIN "gfx/copyright/copyright.tilemap.xor"
.end::
