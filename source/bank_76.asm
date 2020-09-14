SECTION "bank76", ROMX[$4000], BANK[$76]

gfx_lv_6_silph_company::
INCBIN "gfx/levels/lv_6_silph_company.bin"
.end::

gfx_lv_6_silph_company_sgb::
INCBIN "gfx/levels/lv_6_silph_company_sgb.bin"
.end::

; The unused "6" in "6/10" is taller.
gfx_lv_6_silph_company_duplicate::
INCBIN "gfx/levels/lv_6_silph_company_unused.bin"
.end::

gfx_lv_7_cycling_road::
INCBIN "gfx/levels/lv_7_cycling_road.bin"
.end::

gfx_lv_7_cycling_road_sgb::
INCBIN "gfx/levels/lv_7_cycling_road_sgb.bin"
.end::

; The unused "/10" in "7/10" and "LV" are taller.
gfx_lv_7_cycling_road_duplicate::
INCBIN "gfx/levels/lv_7_cycling_road_unused.bin"
.end::

SECTION "compressed_tilemap_attrmap_safari_picross", ROMX[$7c35], BANK[$76]
compressed_tilemap_attrmap_safari_picross::
INCBIN "gfx/game_select/safari_picross.tilemap_attrmap.xor"
.end::
