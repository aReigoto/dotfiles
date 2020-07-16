#!/usr/bin/env bash

trap "exit 1" TERM
export TOP_PID=$$

unset i
unset venvs_folder

cmd=0
opn=0
inf=0
atm=0

myName="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

usage="Help Option
Usage:
        ${myName} env_number [-c|-o|-i|-h]
Where:
        env_number          Number of the virtualenv
        -c | --command      Send a command to a virtualenv
        -o | --open         Open a shell in the virtualenv
        -i | --info         Info about the virtualenv
        -a | --atom         Open atom from virtualenv
        -h | --help         Help?"

declare -A dic_folders

venvs_folder=~/.local/share/virtualenvs/*

for folder in $venvs_folder ; do
  let i++
  # echo $env
  dic_folders+=(["$i"]="$folder")
done

print_dic(){
echo ""
for key in "${!dic_folders[@]}"; do
  printf "%-2s ->> %s\n" "$key" "$(basename ${dic_folders[$key]})"
done
}

log_in_by_key(){
for key in "${!dic_folders[@]}"; do
  if [[ $key =~ $1 ]]; then
    #echo -e "\nTo activate run:"

    echo "${dic_folders[$key]}"
    # Launch Venv in the current directory
    # bash --rcfile <(echo ". ~/.bashrc; source ${dic_folders[$key]}/bin/activate")

    # Run a command and quit venv
    # source ${dic_folders[$key]}/bin/activate; atom .

    # echo -e "\nTo exit type deactivate"
   # break
  fi
done
}

choice_handler(){

    if (( $# > 2 )) ; then
        echo "Error: $# are manny options!" >&2
        kill -s TERM $TOP_PID
        #return 1 2>/dev/null || exit
    fi


    while (( $# > 0 )) ; do
      #echo $#
      case $1 in
        [0-9] | [0-9][0-9] | [0-9][0-9][0-9])
            #echo "Env number"
            #echo $@
            #echo $1
            env_n=$1
            shift
             ;;
        c | -c | --command)
            #echo "Command Otion"
            #echo $1 $2
            #echo $@
            cmd=1
            shift
            ;;
        a | -a | --atom)
            #echo "Command Otion"
            #echo $1 $2
            #echo $@
            atm=1
            shift
            ;;
        o | -o | --open)
            #echo "Open Option"
            #echo $@
            #echo $1
            opn=1
            shift
            ;;
        i | -i | --info)
            #echo "Info Option"
            #echo $@
            #echo $1
            inf=1
            shift
            ;;
        h | -h | --help)
            echo "$usage"
            return 1 2>/dev/null || exit
            ;;
        -*)
            echo "Error: Unknown option: $1" >&2
            kill -s TERM $TOP_PID
            #return 1 2>/dev/null || exit
        esac
    done
}

#_.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
#									Main
#_.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

echo "$usage"

echo -e "\nVirtual environments available:"
print_dic

if [[ $# == 2 ]]; then 
	echo -e "Pick a number\n> $@"
	choice_handler $@
else
	read -ep "Pick a number$(echo $'\n> ')" choice
	choice_handler $choice
fi

if (( $atm == 1 && $env_n > 0 )) ; then
    source $(log_in_by_key $env_n)/bin/activate; atom .
elif (( $cmd == 1 && $env_n > 0 )) ; then
    read -e -p "Type your command`echo $'\n> '`" cmmd
    source $(log_in_by_key $env_n)/bin/activate; $cmmd
elif (( $opn == 1 && $env_n > 0 )) ; then
    bash --rcfile <(echo ". ~/.bashrc; source $(log_in_by_key $env_n)/bin/activate")
elif (( $inf == 1 && $env_n > 0 )) ; then
    echo -e "\nTo activate manualy:"
    echo "source $(log_in_by_key $env_n)/bin/activate"
    echo
    echo "Execatable and site-packages:"
    echo $(log_in_by_key $env_n)/bin/python
    echo $(log_in_by_key $env_n)/python*/site-packages
fi


unset env_n
unset cmd
unset opn
unset inf
unset atm
unset cmmd

unset i
unset venvs_folder
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
