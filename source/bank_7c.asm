SECTION "gfx_alphabets", ROMX[$4000], BANK[$7c]
gfx_alphabets::
INCBIN "gfx/fonts/alphabets.bin"
.end::

SECTION "compressed_tilemap_attrmap_album_pic", ROMX[$7000], BANK[$7c]
compressed_tilemap_attrmap_album_pic::
INCBIN "gfx/safari_zone_album/album_pic.tilemap_attrmap.xor"
.end::

SECTION "compressed_tilemap_attrmap_album_list", ROMX[$7482], BANK[$7c]
compressed_tilemap_attrmap_album_list::
INCBIN "gfx/safari_zone_album/album_list.tilemap_attrmap.xor"
.end::
