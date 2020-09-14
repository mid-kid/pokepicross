RGBGFXFLAGS :=
$(dir_build)/%.bin: %.png | $$(dir $$@)
	$(RGBGFX) $(RGBGFXFLAGS) -o $@ $<

$(dir_build)/%.tilemap_attrmap: %.tilemap %.attrmap | $$(dir $$@)
	cat $^ > $@

$(dir_build)/gfx/sprites/%.bin: RGBGFXFLAGS = -h

# data_select.bin.xor decompresses to 2bpp-encoded data_select.png with an extra byte $33 (ASCII "3") appended
$(dir_build)/gfx/data_select/data_select.bin: gfx/data_select/data_select.bin.png | $$(dir $$@)
	$(RGBGFX) $(RGBGFXFLAGS) -o $@ $<
	printf 3 >> $@
