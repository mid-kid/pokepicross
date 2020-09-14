SECTION "gfx_text_chars_light", ROMX[$4000], BANK[$57]
gfx_text_chars_light::
INCBIN "gfx/fonts/text_chars_light.bin"
.end::

SECTION "tilemap_how_to_play", ROMX[$7c00], BANK[$57]
tilemap_how_to_play::
INCBIN "gfx/how_to_play/how_to_play.tilemap"
.end::
