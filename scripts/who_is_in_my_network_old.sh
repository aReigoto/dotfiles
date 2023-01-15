#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

location_of_map=~/.dotfiles/localFiles/mac_addres_names.sh
location_folder_map=~/.dotfiles/localFiles

echo -e "MAC's list file is located at:\n$location_of_map\n"

save_to_file(){
    echo "declare -A macs" > $location_of_map
    for key in "${!macs[@]}"; do
		echo "macs[\"$key\"]=\"${macs[$key]}\"" >> $location_of_map;
    done
}

# Create folder
if [[ ! -d $location_folder_map ]]; then
	mkdir -p $location_folder_map
fi

# Declare/load macs map/dict
if [[ -e $location_of_map ]]; then
	# Load macs map/dict
	source $location_of_map
else
	declare -A macs
fi

declare -a Unknown_macs

loaclIpBase=$(ifconfig | perl -ne "print if s/\s+inet (192\.168\.\d+\.).*/\1/")

nmap_out=$(sudo nmap -sn ${loaclIpBase}0/24)
# ip_detected=($(echo "$nmap_out" | sed -nE "s/^Nmap scan report for (([0-9]{1,3}.?){4}).*$/\1/p"))
ip_detected=($(echo "$nmap_out" | perl -nle 'print $1 while(/(([0-9]{1,3}\.){3}[0-9]{1,3})/g)'))
mac_detected=($(echo "$nmap_out" | sed -nE "s/^MAC Address: (([0-9A-Z]{2}:?){6}) (.*)$/\1/p"))
description_detected=($(echo "$nmap_out" | sed -nE "s/^MAC Address: (([0-9A-Z]{2}:?){6}) (.*)$/\3/p" | sed  "s/ /_/g"))

for ((i=0; i < ${#mac_detected[@]}; i++)) ; do
    ip=${ip_detected[i]}
    mac=${mac_detected[i]}
    description=${description_detected[i]}
    # Check if mac is on macs map
	name=${macs[$mac]}
    if [[ $name = '' ]] ; then 
        name="!!! NEW MAC ADDRESS !!!"
        Unknown_macs+=("$mac")
    fi
    #echo -e "$ip \t $mac \t  $name \t $description"
	printf "%-17s %20s %26s %-26s\n" "$ip" "$mac" "$name" "$description"
done

if [[ ${#Unknown_macs} > 0 ]] ; then
    echo
    for ((i=0; i < ${#Unknown_macs[@]}; i++)) ; do
        echo -e "MAC: ${Unknown_macs["$i"]} added to $location_of_map as Unknown Machine"
        macs["${Unknown_macs[$i]}"]=">--!Unknown Machine!--<"
    done
    save_to_file
fi
