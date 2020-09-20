SECTION "bank76", ROMX[$4000], BANK[$76]

gfx_lv_6_silph_company::
INCBIN "gfx/town_map/lv_6_silph_company.2bpp"
.end::
gfx_lv_6_silph_company_sgb::
INCBIN "gfx/town_map/lv_6_silph_company_sgb.2bpp"
.end::
; The unused "6" in "6/10" is taller.
gfx_lv_6_silph_company_duplicate::
INCBIN "gfx/town_map/lv_6_silph_company_unused.2bpp"
.end::

gfx_lv_7_cycling_road::
INCBIN "gfx/town_map/lv_7_cycling_road.2bpp"
.end::
gfx_lv_7_cycling_road_sgb::
INCBIN "gfx/town_map/lv_7_cycling_road_sgb.2bpp"
.end::
; The unused "/10" in "7/10" and "LV" are taller.
gfx_lv_7_cycling_road_duplicate::
INCBIN "gfx/town_map/lv_7_cycling_road_unused.2bpp"
.end::

SECTION "compressed_tilemap_attrmap_safari_map", ROMX[$7000], BANK[$76]
compressed_tilemap_attrmap_safari_map::
INCBIN "gfx/safari_map/safari_map.tilemap_attrmap.xor"
.end::

SECTION "compressed_tilemap_attrmap_safari_picross", ROMX[$7c35], BANK[$76]
compressed_tilemap_attrmap_safari_picross::
INCBIN "gfx/game_select/safari_picross.tilemap_attrmap.xor"
.end::
