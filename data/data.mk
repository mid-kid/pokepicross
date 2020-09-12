data :=

data += $(dir_build)/charmap.inc
$(dir_build)/charmap.inc: data/charmap.txt
	./tools/charmap.py $< > $@

data += $(dir_build)/data/messages.asm
objects += $(dir_build)/data/messages.o
$(dir_build)/data/messages.asm: data/charmap.txt data/messages.txt | $$(dir $$@)
	./tools/messages.py $^ > $@
