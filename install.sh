#!/bin/bash

. functions.sh

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
