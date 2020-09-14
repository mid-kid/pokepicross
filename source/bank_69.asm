SECTION "gfx_lv_1_tokiwa_forest", ROMX[$4800], BANK[$69]
gfx_lv_1_tokiwa_forest::
INCBIN "gfx/town_map/lv_1_tokiwa_forest.2bpp"
.end::
gfx_lv_1_tokiwa_forest_sgb::
INCBIN "gfx/town_map/lv_1_tokiwa_forest_sgb.2bpp"
.end::
; The unused tree trunk tiles are darker.
gfx_lv_1_tokiwa_forest_duplicate::
INCBIN "gfx/town_map/lv_1_tokiwa_forest_unused.2bpp"
.end::

SECTION "gfx_textbox_border_dark", ROMX[$6000], BANK[$69]
gfx_textbox_border_dark::
INCBIN "gfx/fonts/textbox_border_dark.2bpp"
.end::

SECTION "gfx_textbox_border", ROMX[$6800], BANK[$69]
gfx_textbox_border_bw::
INCBIN "gfx/fonts/textbox_border_bw.2bpp"
.end::

SECTION "compressed_gfx_data_select", ROMX[$7000], BANK[$69]
compressed_gfx_data_select::
INCBIN "gfx/data_select/data_select.2bpp.xor"
.end::
