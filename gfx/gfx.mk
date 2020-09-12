gfx := $(patsubst %.png, $(dir_build)/%.bin, \
        $(call rwildcard, gfx, *.png))

RGBGFXFLAGS :=
$(dir_build)/%.bin: %.png | $$(dir $$@)
	$(RGBGFX) $(RGBGFXFLAGS) -o $@ $<

$(dir_build)/gfx/sprites/%.bin: RGBGFXFLAGS = -h
