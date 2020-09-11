name := picross
baserom := DMGAKVJ0.1

dir_build := build

RGBASM := rgbasm
RGBGFX := rgbgfx
RGBLINK := rgblink
RGBFIX := rgbfix

RGBASMFLAGS := -p 0xff -L -h -E
RGBLINKFLAGS := -p 0xff -d
RGBFIXFLAGS := -p 0xff -c -m 0x1b -r 0x03 -k "01" -i "AKVJ" -t "POKEPICROSS"

rwildcard = $(foreach d, $(wildcard $1*), $(filter $(subst *, %, $2), $d) $(call rwildcard, $d/, $2))

objects := $(patsubst %.asm, $(dir_build)/%.o, \
            $(call rwildcard, source data, *.asm))
objects += $(dir_build)/shim.o

gfx := $(patsubst %.png, $(dir_build)/%.bin, \
        $(call rwildcard, gfx, *.png))

.PRECIOUS: $(gfx)
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
	tools/makeshim.py $< > $@

$(dir_build)/%.o: $(dir_build)/%.asm | $(gfx) $$(dir $$@)
	$(RGBASM) $(RGBASMFLAGS) -i $(dir_build)/ -i include/ -M $(@:.o=.d) -o $@ $<
$(dir_build)/%.o: %.asm | $(gfx) $$(dir $$@)
	$(RGBASM) $(RGBASMFLAGS) -i $(dir_build)/ -i include/ -M $(@:.o=.d) -o $@ $<

$(dir_build)/%.bin: %.png | $$(dir $$@)
	$(RGBGFX) -o $@ $<

.PRECIOUS: %/
%/:
	mkdir -p $@

-include $(patsubst %.o, %.d, $(objects))
