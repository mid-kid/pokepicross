RGBGFXFLAGS :=
$(dir_build)/%.bin: %.png | $$(dir $$@)
	$(RGBGFX) $(RGBGFXFLAGS) -o $@ $<

$(dir_build)/gfx/sprites/%.bin: RGBGFXFLAGS = -h

# data_select.bin.xor decompresses to 2bpp-encoded data_select.png with an extra byte $33 (ASCII "3") appended
$(dir_build)/gfx/data_select/data_select.bin: gfx/data_select/data_select.png | $$(dir $$@)
	$(RGBGFX) $(RGBGFXFLAGS) -o $@ $<
	printf 3 >> $@

$(dir_build)/%.xor: $(dir_build)/% | $$(dir $$@)
	tools/xor_compress.py $< > $@
$(dir_build)/%.xor: % | $$(dir $$@)
	tools/xor_compress.py $< > $@

$(dir_build)/%.tilemap_attrmap.xor: %.tilemap %.attrmap | $$(dir $$@)
	tools/xor_compress.py $^ > $@
