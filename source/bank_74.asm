SECTION "bank74", ROMX[$4000], BANK[$74]

gfx_lv_4_jungle_zone::
INCBIN "gfx/safari_map/lv_4_jungle_zone.2bpp"
.end::
gfx_lv_4_jungle_zone_sgb::
INCBIN "gfx/safari_map/lv_4_jungle_zone_sgb.2bpp"
.end::
; The edges of the unused tree trunk tiles are light and dark gray
; like the rest of the tree, not white and light gray.
gfx_lv_4_jungle_zone_duplicate::
INCBIN "gfx/safari_map/lv_4_jungle_zone_unused.2bpp"
.end::

gfx_lv_3_sea_cottage::
INCBIN "gfx/town_map/lv_3_sea_cottage.2bpp"
.end::
gfx_lv_3_sea_cottage_sgb::
INCBIN "gfx/town_map/lv_3_sea_cottage_sgb.2bpp"
.end::
; The unused "3" in "3/10" is has less of a black border.
gfx_lv_3_sea_cottage_duplicate::
INCBIN "gfx/town_map/lv_3_sea_cottage_unused.2bpp"
.end::

SECTION "tilemap_sgb_border", ROMX[$7010], BANK[$74]
tilemap_sgb_border::
INCBIN "gfx/sgb_border/sgb_border.bin"
.end::

SECTION "compressed_tilemap_attrmap_easy_picross", ROMX[$7ddc], BANK[$74]
compressed_tilemap_attrmap_easy_picross::
INCBIN "gfx/easy_picross/easy_picross.tilemap_attrmap.xor"
.end::
