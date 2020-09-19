# These intermediate build products need specifying here to be PRECIOUS
gfx := \
$(dir_build)/gfx/copyright/copyright.2bpp \
$(dir_build)/gfx/game_select/game_select.2bpp \
$(dir_build)/gfx/title/title_1.2bpp \
$(dir_build)/gfx/title/title_2.2bpp

RGBGFXFLAGS :=
$(dir_build)/%.2bpp: %.png | $$(dir $$@)
	$(RGBGFX) $(RGBGFXFLAGS) -o $@ $<

SUPERFAMICONVFLAGS :=
$(dir_build)/%.4bpp: %.png | $$(dir $$@)
	superfamiconv tiles -i $< -d $@ -R $(SUPERFAMICONVFLAGS)

$(dir_build)/gfx/sprites/%.2bpp: RGBGFXFLAGS = -h

$(dir_build)/gfx/sgb_border/sgb_border.4bpp: SUPERFAMICONVFLAGS = -T 257

# data_select.2bpp.xor decompresses to 2bpp-encoded data_select.png with an extra byte $33 (ASCII "3") appended
$(dir_build)/gfx/data_select/data_select.2bpp: gfx/data_select/data_select.png | $$(dir $$@)
	$(RGBGFX) $(RGBGFXFLAGS) -o $@ $<
	printf 3 >> $@


XOR_COMPRESS := tools/xor_compress

$(dir_build)/%.xor: $(dir_build)/% | $$(dir $$@) $(XOR_COMPRESS)
	$(XOR_COMPRESS) $< $@
$(dir_build)/%.xor: % | $$(dir $$@) $(XOR_COMPRESS)
	$(XOR_COMPRESS) $< $@

$(dir_build)/%.tilemap_attrmap.xor: %.tilemap %.attrmap | $$(dir $$@) $(XOR_COMPRESS)
	$(XOR_COMPRESS) $^ $@

$(dir_build)/gfx/save/save_sgb.xor: $(dir_build)/gfx/sprites/joy_jenny.2bpp $(dir_build)/gfx/save/save_sgb.2bpp | $$(dir $$@) $(XOR_COMPRESS)
	$(XOR_COMPRESS) $^ $@
