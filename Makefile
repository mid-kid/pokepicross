name := picross
baserom := DMGAKVJ0.1

dir_build := build

RGBDS ?=
RGBASM  ?= $(RGBDS)rgbasm
RGBFIX  ?= $(RGBDS)rgbfix
RGBGFX  ?= $(RGBDS)rgbgfx
RGBLINK ?= $(RGBDS)rgblink

RGBASMFLAGS := -p 0xff -L -h -E
RGBLINKFLAGS := -p 0xff -d
RGBFIXFLAGS := -p 0xff -c -m 0x1b -r 0x03 -k "01" -i "AKVJ" -t "POKEPICROSS"

rwildcard = $(foreach d, $(wildcard $1*), $(filter $(subst *, %, $2), $d) $(call rwildcard, $d/, $2))

objects := $(patsubst %.asm, $(dir_build)/%.o, \
            $(call rwildcard, source data, *.asm))
objects += $(dir_build)/shim.o

.SECONDEXPANSION:

.PHONY: all
all: $(name).gbc
	cmp $(name).gbc $(baserom)

include data/data.mk
include gfx/gfx.mk
include tools/tools.mk
.PRECIOUS: $(gfx) $(data) $(tools)

.PHONY: tools
tools: $(tools)

.PHONY: clean
clean:
	rm -rf $(name).gbc $(name).sym $(name).map $(dir_build) $(tools)

$(name).gbc: layout.link $(objects) | $(baserom)
	$(RGBLINK) $(RGBLINKFLAGS) -O $(baserom) -l $< -n $(@:.gbc=.sym) -m $(@:.gbc=.map) -o $@ $(filter-out $<, $^)
	$(RGBFIX) $(RGBFIXFLAGS) -v $@

$(dir_build)/shim.asm: shim.sym | $$(dir $$@)
	tools/makeshim.py $< > $@

$(dir_build)/%.o: $(dir_build)/%.asm | $$(dir $$@)
	$(RGBASM) $(RGBASMFLAGS) -i $(dir_build)/ -i include/ -o $@ $<
$(dir_build)/%.o: %.asm | $$(dir $$@)
	$(RGBASM) $(RGBASMFLAGS) -i $(dir_build)/ -i include/ -o $@ $<

$(dir_build)/%.d: %.asm tools/scan_includes | $$(dir $$@)
	@./tools/scan_includes -b $(dir_build)/ -i $(dir_build)/ -i include/ -o $@ -t $(@:.d=.o) $<

.PRECIOUS: %/
%/:
	@mkdir -p $@

ifeq (,$(filter clean tools,$(MAKECMDGOALS)))
-include $(patsubst %.o, %.d, $(objects))
endif
