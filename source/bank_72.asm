SECTION "bank72", ROMX[$4800], BANK[$72]

; The Safari Zone level 1 was renamed from Forest Zone to Plain Zone,
; but only the CGB graphics were updated, leaving the old name in
; the SGB and duplicate CGB graphics.

gfx_lv_1_plain_zone::
INCBIN "gfx/levels/lv_1_plain_zone.bin"
.end::

gfx_lv_1_plain_zone_sgb::
INCBIN "gfx/levels/lv_1_forest_zone_sgb.bin"
.end::

gfx_lv_1_plain_zone_duplicate::
INCBIN "gfx/levels/lv_1_forest_zone.bin"
.end::
