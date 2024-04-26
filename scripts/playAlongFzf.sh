#!/usr/bin/env zsh

cd '/Volumes/Dois.Tera/!Livros and Stuff/Songbooks/Play-A-Longs'

fzf --multi --query ".mp3" --print0 | xargs -0 vlc ; cd -

