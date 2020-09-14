gfx_exceptions := \
$(dir_build)/gfx/data_select/data_select.bin

gfx := $(filter-out $(gfx_exceptions), \
       $(patsubst %.png, $(dir_build)/%.bin, \
       $(call rwildcard, gfx, *.png)))

RGBGFXFLAGS :=
$(dir_build)/%.bin: %.png | $$(dir $$@)
	$(RGBGFX) $(RGBGFXFLAGS) -o $@ $<

$(dir_build)/gfx/sprites/%.bin: RGBGFXFLAGS = -h

# data_select.tilemap_attrmap.xor decompresses to data_select.tilemap concatenated with data_select.attrmap
$(dir_build)/gfx/data_select/data_select.tilemap_attrmap: gfx/data_select/data_select.tilemap gfx/data_select/data_select.attrmap | $$(dir $$@)
	cat $^ > $@

# data_select.bin.xor decompresses to 2bpp-encoded data_select.png with an extra byte $33 (ASCII "3") appended
$(dir_build)/gfx/data_select/data_select.bin: gfx/data_select/data_select.bin.png | $$(dir $$@)
	$(RGBGFX) $(RGBGFXFLAGS) -o $@ $<
	printf 3 >> $@
