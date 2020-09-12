#!/bin/sh

./mgbdis/mgbdis.py --overwrite \
    --disable-auto-ldh \
    --ld_c ldh_c \
    --print-hex \
    "$@" picross.gbc
