#!/bin/bash

WHERE=$(dirname $0)
cd "$WHERE"

now=$(date '+%Y%m%d%H%M')
for file in dot.*; do
    file=$(echo "$file" | sed 's/^dot//')
    fullfile="$HOME/$file"
    dotfile="$PWD/dot$file"

    # Ignore files that are already linked to the repository.
    if [ -L "$fullfile" ]; then
        realfile=$(readlink -f "$fullfile")
        if [ "$realfile" = "$dotfile" ]; then
            echo "# Ignoring $file: Already linked";
            continue
        fi
    fi

    if [ -e "$fullfile" ]; then
        echo "# Making backup of $file"
        mv "$fullfile" "$fullfile.$now"
    fi

    ln -s "$dotfile" "$fullfile"

    # The .ssh directory and its contents require some special logic, since
    # git doesn't respect modes (AFAICT).
    if [ "$file" = ".ssh" ]; then
        echo "Fixing modes on ~/.ssh/*"
        chmod 700 $HOME/.ssh
        chmod 600 $HOME/.ssh/*
    fi
done
