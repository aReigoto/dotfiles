#!/usr/bin/env zsh

cd "/Volumes/Dois.Tera/Music"

fzf --multi --query ".mp3" --print0 | xargs -0 vlc ; cd -

