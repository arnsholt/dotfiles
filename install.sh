#!/bin/bash

WHERE=$(dirname $0)
cd "$WHERE"

. functions.sh

now=$(date '+%Y%m%d%H%M')
for file in dot.*; do
    shortname=$(echo "$file" | sed 's/^dot//')

    # The .ssh directory and its contents require some special logic, since
    # SSH really doesn't seem to like the directory itself being a symlink.
    if [ "$shortname" = ".ssh" ]; then
        if [ ! -e "$HOME/.ssh" ]; then
            diag "Creating ~/.ssh"
            mkdir "$HOME/.ssh"
            chmod 700 "$HOME/.ssh"
        fi

        for f in "$file/"*; do
            install "$f" "$HOME/.ssh" "$(basename $f)"
        done

        continue
    fi

    install "$file" "$HOME" "$shortname"
done
