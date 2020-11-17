#!/usr/bin/env bash

program=$1

if [ -z $program ] ; then 
    echo "You must name a program."
    exit 0
fi

declare -a folders=(
"/Applications/Native Instruments"
"/Library/Preferences" 
"/Library/Audio/Plug-Ins/Components"
"/Library/Audio/Plug-Ins/VST"
"/Library/Application Support/Digidesign"
"/Library/Application Support/Avid/Audio/Plug-Ins"
"/Library/Application Support/Native Instruments"
"/Library/Application Support/Native Instruments/Service Center"
"/Users/$USER/Library/Preferences"
"/Users/$USER/Library/Application Support/Native Instruments"
)

for folder in "${folders[@]}" ; do 
    echo -e "\nSearch on folder: ${folder}"
    find "${folder}" -iname *$program* -maxdepth 1
done

read -ep "Enter yes to deleat the files $(echo $'\n> ')" remove_opt

if [[ $remove_opt =~ ^[yY](es)? ]] ; then
	for folder in "${folders[@]}" ; do 
		#echo -e "\nSearch on folder: ${folder}"
		find "${folder}" -iname *$program* -maxdepth 1 -exec rm -rf {} \;
	done
fi

unset remove_opt

