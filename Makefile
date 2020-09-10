name := picross
baserom := DMGAKVJ0.1

dir_source := source
dir_build := build
dir_gfx := gfx
dir_tools := tools

RGBASM := rgbasm
RGBGFX := rgbgfx
RGBLINK := rgblink
RGBFIX := rgbfix

RGBASMFLAGS := -p 0xff -L
RGBLINKFLAGS := -p 0xff -d
RGBFIXFLAGS := -p 0xff -c -m 0x1b -r 0x03 -k "01" -i "AKVJ" -t "POKEPICROSS"

rwildcard = $(foreach d, $(wildcard $1*), $(filter $(subst *, %, $2), $d) $(call rwildcard, $d/, $2))

objects := $(patsubst $(dir_source)/%.asm, $(dir_build)/%.o, \
            $(call rwildcard, $(dir_source)/, *.asm))
objects += $(dir_build)/shim.o

gfx := $(patsubst $(dir_gfx)/%.png, $(dir_build)/gfx/%.bin, \
        $(call rwildcard, $(dir_gfx)/, *.png))

.SECONDEXPANSION:

.PHONY: all
all: $(name).gbc
	cmp $(name).gbc $(baserom)

.PHONY: clean
clean:
	rm -rf $(name).gbc $(name).sym $(name).map $(dir_build)

$(name).gbc: layout.link $(objects) | $(baserom)
	$(RGBLINK) $(RGBLINKFLAGS) -O $(baserom) -l $< -n $(@:.gbc=.sym) -m $(@:.gbc=.map) -o $@ $(filter-out $<, $^)
	$(RGBFIX) $(RGBFIXFLAGS) -v $@

$(dir_build)/shim.asm: shim.sym | $$(dir $$@)
	$(dir_tools)/makeshim.py $< > $@

$(dir_build)/%.o: $(dir_build)/%.asm | $(gfx) $$(dir $$@)
	$(RGBASM) $(RGBASMFLAGS) -i $(dir_build)/ -i $(dir_source)/ -M $(@:.o=.d) -o $@ $<
$(dir_build)/%.o: $(dir_source)/%.asm | $(gfx) $$(dir $$@)
	$(RGBASM) $(RGBASMFLAGS) -i $(dir_build)/ -i $(dir_source)/ -M $(@:.o=.d) -o $@ $<

$(dir_build)/gfx/%.bin: $(dir_gfx)/%.png | $$(dir $$@)
	$(RGBGFX) -o $@ $<

.PRECIOUS: %/
%/:
	mkdir -p $@

-include $(patsubst %.o, %.d, $(objects))
