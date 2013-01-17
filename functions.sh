#!/bin/bash

function backup() {
    file=$1
    shortname=$(basename "$file")
    echo "Making backup of $shortname"
    mv "$file" "$file.$now"
}

# Install $1 to directory $2 with name $3
function install() {
    src=$1
    target=$3
    fullfile="$2/$target"

    # Ignore files that are already linked to the repository.
    if [ -L "$fullfile" ]; then
        realfile=$(readlink -f "$fullfile")
        if [ "$realfile" = "$PWD/$src" ]; then
            echo "# Ignoring $target: Already linked";
            continue
        fi
    fi

    if [ -e "$fullfile" ]; then
        backup "$fullfile"
    fi

    ln -s "$PWD/$src" "$fullfile"
}
