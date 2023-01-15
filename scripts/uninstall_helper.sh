#!/usr/bin/env bash

declare -a folders=( ~/Library /Library ~/Applications /Applications  )

for f in ${folders[@]} ; do
    echo -e "\n\t$f"
    #sudo find $f -d -iname $1 2>&1 | grep -v "^find:"
    sudo find $f -iname $1 2>&1 | grep -v "^find:"
done
