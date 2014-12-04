#!/bin/bash

# Dracut is bash too, and it doesn't play nicely with our usual sets
# dib-lint: disable=setu sete setpipefail

check() {
    return 0
}

depends() {
    return 0
}

install() {
    inst_hook cmdline 80 "$moddir/deploy-cmdline.sh"
    inst_hook pre-mount 50 "$moddir/init.sh"
    $moddir/python-deps /bin/targetcli | while read dep; do
        case "$dep" in
            *.so) inst_library $dep ;;
            *.py) inst_simple $dep ;;
            *) inst $dep ;;
        esac
    done
}
