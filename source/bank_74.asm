SECTION "bank74", ROMX[$4000], BANK[$74]

gfx_lv_4_jungle_zone::
INCBIN "gfx/levels/lv_4_jungle_zone.bin"
.end::

gfx_lv_4_jungle_zone_sgb::
INCBIN "gfx/levels/lv_4_jungle_zone_sgb.bin"
.end::

; The edges of the unused tree trunk tiles are light and dark gray
; like the rest of the tree, not white and light gray.
gfx_lv_4_jungle_zone_duplicate::
INCBIN "gfx/levels/lv_4_jungle_zone_unused.bin"
.end::

gfx_lv_3_sea_cottage::
INCBIN "gfx/levels/lv_3_sea_cottage.bin"
.end::

gfx_lv_3_sea_cottage_sgb::
INCBIN "gfx/levels/lv_3_sea_cottage_sgb.bin"
.end::

; The unused "3" in "3/10" is has less of a black border.
gfx_lv_3_sea_cottage_duplicate::
INCBIN "gfx/levels/lv_3_sea_cottage_unused.bin"
.end::

SECTION "compressed_tilemap_attrmap_easy_picross", ROMX[$7ddc], BANK[$74]
compressed_tilemap_attrmap_easy_picross::
INCBIN "gfx/easy_picross/easy_picross.tilemap_attrmap.xor"
.end::
