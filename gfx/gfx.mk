gfx := $(patsubst %.png, $(dir_build)/%.bin, \
        $(call rwildcard, gfx, *.png))

RGBGFXFLAGS :=
$(dir_build)/%.bin: %.png | $$(dir $$@)
	$(RGBGFX) $(RGBGFXFLAGS) -o $@ $<

$(dir_build)/gfx/pikachu_walk.bin: RGBGFXFLAGS = -h
$(dir_build)/gfx/bulbasaur_walk.bin: RGBGFXFLAGS = -h
$(dir_build)/gfx/charmander_walk.bin: RGBGFXFLAGS = -h
$(dir_build)/gfx/squirtle_walk.bin: RGBGFXFLAGS = -h
$(dir_build)/gfx/clefairy_walk.bin: RGBGFXFLAGS = -h
$(dir_build)/gfx/jigglypuff_walk.bin: RGBGFXFLAGS = -h
$(dir_build)/gfx/misty_walk.bin: RGBGFXFLAGS = -h
$(dir_build)/gfx/mew_walk.bin: RGBGFXFLAGS = -h
$(dir_build)/gfx/mew_silhouette_walk.bin: RGBGFXFLAGS = -h
$(dir_build)/gfx/psyduck_walk.bin: RGBGFXFLAGS = -h
$(dir_build)/gfx/bill_walk.bin: RGBGFXFLAGS = -h
