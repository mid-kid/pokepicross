SECTION "bank78", ROMX[$4000], BANK[$78]

gfx_lv_10_hanada_cave::
INCBIN "gfx/levels/lv_10_hanada_cave.bin"
.end::

gfx_lv_10_hanada_cave_sgb::
INCBIN "gfx/levels/lv_10_hanada_cave_sgb.bin"
.end::

; The water behind cliff corner tiles is dark gray
; like the rest of the water, not white.
gfx_lv_10_hanada_cave_duplicate::
INCBIN "gfx/levels/lv_10_hanada_cave_unused.bin"
.end::
