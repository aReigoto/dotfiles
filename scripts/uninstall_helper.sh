
declare -a folders=( ~/Library /Library ~/Applications /Applications  )

for f in ${folders[@]} ; do
    echo -e "\n\t$f"
    find $f -d -iname $1
done
