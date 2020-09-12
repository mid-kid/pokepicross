SECTION "bank73", ROMX[$4800], BANK[$73]

gfx_lv_0_home::
INCBIN "gfx/levels/lv_0_home.bin"
.end::

gfx_lv_0_home_sgb::
INCBIN "gfx/levels/lv_0_home_sgb.bin"
.end::

; The edges of the unused house roof tiles are dark gray
; like the rest of the roof, not white.
gfx_lv_0_home_duplicate::
INCBIN "gfx/levels/lv_0_home_unused.bin"
.end::
