#!/usr/bin/env bash

if [[ $1 == '' ]]; then
	base_folder='.'
else
	base_folder="$1"
fi

find "$base_folder" -name '*.aif*' -print0 |
    while IFS= read -r -d $'\0' f; do
    [[ "$f" != *.aif* ]] && continue

    lame --preset insane "$f" "${f%.aiff}.mp3"
done
