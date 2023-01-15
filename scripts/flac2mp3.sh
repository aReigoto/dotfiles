#!/usr/bin/env bash

if [[ $1 == '' ]]; then
  base_folder='.'
else
  base_folder="$1"
fi

find "$base_folder" -name '*.flac' -print0 | 
    while IFS= read -r -d $'\0' f; do 
    [[ "$f" != *.flac ]] && continue
    album="$(metaflac --show-tag=album "$f" | sed 's/[^=]*=//')"
    artist="$(metaflac --show-tag=artist "$f" | sed 's/[^=]*=//')"
    date="$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')"
    title="$(metaflac --show-tag=title "$f" | sed 's/[^=]*=//')"
    year="$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')"
    genre="$(metaflac --show-tag=genre "$f" | sed 's/[^=]*=//')"
    tracknumber="$(metaflac --show-tag=tracknumber "$f" | sed 's/[^=]*=//')"

    flac --decode --stdout "$f" | lame --preset insane --add-id3v2 --tt "$title" --ta "$artist" --tl "$album" --ty "$year" --tn "$tracknumber" --tg "$genre" - "${f%.flac}.mp3"
done
