#!/usr/bin/env bash

location_of_dic=~/.dotfiles/localFiles/teleport_folders.sh
location_folder_dic=~/.dotfiles/localFiles

if [[ ! -d $location_folder_dic ]]; then
  mkdir -p $location_folder_dic
fi

if [[ -e $location_of_dic ]]; then
  source $location_of_dic
else
  declare -A dic_folders
fi

#
# Some functions
#

add_destination(){
    if [[ -z $1  ]] ; then
      folder=$PWD
    else
      folder=$1
    fi

    echo -e "\nName this teleportation destination:"
    read -ep "$folder $(echo $'\n> ')" folder_alias
    unset dic_folders["$folder_alias"]
    dic_folders+=(["$folder_alias"]="$folder")
}

print_dic(){
    echo ""
    counter=1
    echo "debug"
    for key in "${!dic_folders[@]}"; do
      printf "%-2s - %-20s => %s\n" "$counter" "$key" "${dic_folders[$key]}"
      ((counter++))
    done
}

save_to_file(){
    echo "declare -A dic_folders=(" > $location_of_dic
    for key in "${!dic_folders[@]}"; do
      echo "[\"$key\"]=\"${dic_folders[$key]}\"" >> $location_of_dic;
    done
    echo ")" >> $location_of_dic
}

folder_by_index(){
    if [[ $1 -le "${#dic_folders[@]}" ]]; then
      counter=1
      for key in "${!dic_folders[@]}"; do
        if [[ $1 -ne $counter ]]; then
          ((counter++))
          continue
        else
          echo "${dic_folders[$key]}"
          break
        fi
      done
    fi
}

folder_by_key(){
    for key in "${!dic_folders[@]}"; do
      if [[ $key =~ $1 ]]; then
        echo "${dic_folders[$key]}"
        break
      fi
    done
}

usage="$(basename ${BASH_SOURCE[0]}) [ (-a | -add) [path]] [-e | -edit] [-h | -help] [destination]

where:
    -a | -add   :  make this spot teleportable
    -e | -edit  :  edit the possible destination
    -p | -print :  print a destination by evoquing it's short name
    -h | -help  :  show this help text"

#define options via flagged input arguments
check_args(){
    if [[ $# -eq 0 ]] ; then
      echo "$usage"
      print_dic
      echo ""
      read -ep "Where to go?$(echo $'\n> ')" choice
    elif [[ $# -eq 1 ]] ; then
      choice=$1
    # Handeling options with arguments
    # Adding destination
	elif [[ $# -eq 2 ]] && [[ $1 =~ ^(a|-a)$ ]] ; then
        add_destination $2
        save_to_file
        return 0
    # Printing destination
	elif [[ $# -eq 2 ]] && [[ $1 =~ ^(p|-p)$ ]] ; then
        if [[ $2 =~ ^[0-9]+ ]]; then
          echo "$( folder_by_index $2 )"
          return 0
        else
          echo "$( folder_by_key $2 )"
          return 0
        fi
    fi

    case $choice in
      [0-9] | [0-9][0-9])
        cd "$( folder_by_index $choice )"
        return 0
        ;;
      -a | a | -add)
        add_destination
        save_to_file
        return 0
        ;;
      -e | e | -edit)
        vim $location_of_dic
        return 0
        ;;
      '' | -h)
        echo "$usage"
        return 0
        ;;
      *)
        cd "$( folder_by_key $choice )"
        return 0
        ;;
    esac
}

#---------- ----------#

check_args $@

unset location_of_dic
unset location_folder_dic
unset dic_folders
unset folder_alias
unset folder
unset counter
unset key
unset choice
unset -f add_destination
unset -f print_dic
unset -f save_to_file
unset -f folder_by_key
unset -f folder_by_index
unset -f check_args

#---------- ----------#

#
# while getopts 'ae' OPTION; do
#   case $OPTION in
#     e | --execute)
#       executeFlag="Run"
#        ;;
#     r )
#       readarray -t arrayOfFolders < <( find . -name $fileExtention -print0 | xargs -0 -n1 dirname | sort --unique )
#       ;;
#     d )
#       arrayOfFolders=$OPTARG
#       ;;
#     E )
#       regex=$OPTARG
#       ;;
#     h )
#       echo "$usage"
#       ;;
#     \?)
#       echo "$usage"
#       exit 1
#       ;;
#   esac
# done
# shift "$(($OPTIND -1))"
