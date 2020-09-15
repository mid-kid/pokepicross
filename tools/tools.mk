tools := \
tools/scan_includes \
tools/xor_compress

CC := gcc
CFLAGS := -O3 -std=c99 -Wall -Wextra -pedantic

tools/%: tools/%.c
	$(CC) $(CFLAGS) -o $@ $<
