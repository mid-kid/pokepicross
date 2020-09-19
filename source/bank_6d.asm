SECTION "gfx_album_picture_frames_light", ROMX[$4000], BANK[$6d]
gfx_album_picture_frames_light::
INCBIN "gfx/safari_zone_album/picture_frames_light.2bpp"
.end::

SECTION "compressed_gfx_save_sgb", ROMX[$7000], BANK[$6d]
compressed_gfx_save_sgb::
INCBIN "gfx/save/save_sgb.xor"
.end::
