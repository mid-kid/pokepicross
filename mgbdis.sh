#!/bin/sh

if ! fgrep -qx ';APPEND' picross.sym; then
    echo ';APPEND' >> picross.sym
    cat shim_mgbdis.sym >> picross.sym
fi

./mgbdis/mgbdis.py --overwrite \
    --disable-auto-ldh \
    --ld_c ldh_c \
    --print-hex \
    "$@" picross.gbc
