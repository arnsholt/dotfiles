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

WHERE=$(dirname $0)
cd "$WHERE"

now=$(date '+%Y%m%d%H%M')
for file in dot.*; do
    shortname=$(echo "$file" | sed 's/^dot//')

    install "$file" "$HOME" "$shortname"

    # The .ssh directory and its contents require some special logic, since
    # git doesn't respect modes (AFAICT).
    if [ "$shortname" = ".ssh" ]; then
        echo "Fixing modes on ~/.ssh/*"
        chmod 700 $HOME/.ssh
        chmod 600 $HOME/.ssh/*
    fi
done
