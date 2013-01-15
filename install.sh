#!/bin/bash

WHERE=$(dirname $0)
cd "$WHERE"

now=$(date '+%Y%m%d%H%M')
for file in dot.*; do
    file=$(echo "$file" | sed 's/^dot//')
    fullfile="$HOME/$file"
    echo "# Making backup of $file"
    echo mv "$fullfile" "$fullfile.$now"
    echo ln -s "$PWD/dot$file" "$fullfile"
done
