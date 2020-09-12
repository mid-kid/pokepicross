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

SECTION "gfx_textbox_border", ROMX[$6000], BANK[$69]
gfx_textbox_border::
INCBIN "gfx/textbox_border.bin"
.end::
