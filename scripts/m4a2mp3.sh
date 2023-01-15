#!/usr/bin/env bash

if [[ $1 == '' ]]; then
	base_folder='.'
else
	base_folder="$1"
fi

find "$base_folder" -name '*.m4a' -print0 |
    while IFS= read -r -d $'\0' f; do
    [[ "$f" != *.m4a ]] && continue
    album="$(mp4info "$f" | grep -E "^\sAlbum:" | sed 's/.*: //')"
    artist="$(mp4info "$f" | grep -E "^\sArtist:" | sed 's/.*: //')"
    date="$(mp4info "$f" | grep -E "^\sRelease Date:" | sed 's/.*: //' | sed -E 's/(^[0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/')"
    title="$(mp4info "$f" | grep -E "^\sName:" | sed 's/.*: //')"
    year="$(mp4info "$f" | grep -E "^\sRelease Date:" | sed 's/.*: //' | sed -E 's/(^[0-9]{4}).*/\1/')"
    genre="$(mp4info "$f" | grep -E "^\sGenreType:" | sed 's/.*: //')"
    tracknumber="$(mp4info "$f" | grep -E "^\sTrack:" | sed 's/.*: //' | sed 's/ of /\//')"

    faad "$f"
    lame --preset insane --add-id3v2 --tt "$title" --ta "$artist" --tl "$album" --ty "$year" --tn "$tracknumber" --tg "$genre"  "${f%.m4a}.wav" "${f%.m4a}.mp3"
    rm "${f%.m4a}.wav"
done
