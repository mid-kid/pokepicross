SECTION "gfx_lv_0_home", ROMX[$4800], BANK[$73]
gfx_lv_0_home::
INCBIN "gfx/easy_picross/lv_0_home.2bpp"
.end::
gfx_lv_0_home_sgb::
INCBIN "gfx/easy_picross/lv_0_home_sgb.2bpp"
.end::
; The edges of the unused house roof tiles are dark gray
; like the rest of the roof, not white.
gfx_lv_0_home_duplicate::
INCBIN "gfx/easy_picross/lv_0_home_unused.2bpp"
.end::
