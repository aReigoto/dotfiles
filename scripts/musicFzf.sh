#!/usr/bin/env zsh

declare -A folders=( 
    [playAlong]='/Volumes/Dois.Tera/!Livros and Stuff/Songbooks/Play-A-Longs' 
    [Jazz]='/Volumes/Dois.Tera/Music/ORGANIZANDO/Jazz'
    [Organizado]='/Volumes/Dois.Tera/Music/ORGANIZANDO'
    [MusicFolder]='/Volumes/Dois.Tera/Music'
)

declare -a folders_i=( ${(k)folders} )

for i in {1..${#folders_i[@]}}; do
  echo "$i : ${folders_i[$i]}"
done

read 'idx?Where to shearch: ' 

if [[ $idx -gt ${#folders_i} ]] || [[ $idx -lt 1 ]]; then
    echo "Index not valid"
    exit 1
fi

folder=${folders[${folders_i[idx]}]}

cd "${folder}"

fzf --multi --query ".mp3" --print0 | xargs -0 vlc ; cd -