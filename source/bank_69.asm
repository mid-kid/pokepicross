SECTION "lv_1_tok", ROMX[$4800], BANK[$69]

gfx_lv_1_tokiwa_forest::
INCBIN "gfx/levels/lv_1_tokiwa_forest.bin"
.end::

gfx_lv_1_tokiwa_forest_sgb::
INCBIN "gfx/levels/lv_1_tokiwa_forest_sgb.bin"
.end::

; The unused tree trunk tiles are darker.
gfx_lv_1_tokiwa_forest_duplicate::
INCBIN "gfx/levels/lv_1_tokiwa_forest_unused.bin"
.end::

SECTION "gfx_textbox_border_dark", ROMX[$6000], BANK[$69]
gfx_textbox_border_dark::
INCBIN "gfx/fonts/textbox_border_dark.bin"
.end::

SECTION "gfx_textbox_border", ROMX[$6800], BANK[$69]
gfx_textbox_border_bw::
INCBIN "gfx/fonts/textbox_border_bw.bin"
.end::

SECTION "compressed_gfx_data_select", ROMX[$7000], BANK[$69]
compressed_gfx_data_select::
INCBIN "gfx/data_select/data_select.bin.xor"
.end::
