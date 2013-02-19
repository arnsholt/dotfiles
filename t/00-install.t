#!/bin/bash

BASH_TAP_ROOT="$PWD/bash-tap"
. bash-tap/bash-tap-bootstrap
. functions.sh

function exists() {
    if [ -e "$1" ]; then
        ok 1 "$2"
    else
        ok 0 "$2"
    fi
}

plan tests 3 # TODO: Fix when I have some tests

now="old"
echo "old file" > t/file
backup "t/file" &>/dev/null
exists "t/file.old" "backup function"

# Clean up after us.
rm -f t/file{,.old}


echo "stuff" > t/source
install "t/source" "t" "target" &>/dev/null
exists "t/target" "install file creation"
is $(cat t/target) $(cat t/source) "install file contents"

# Clean up.
rm -f t/source t/target

# vim: ft=sh
