#!/usr/bin/env bash

#Check if scrip is being sourced on Linux
#[[ $_ != $0 ]] && sourceStatus=1 || sourceStatus=0

#Get the folder were the script is
#This last one will work with any combination of aliases, source, bash -c, symlinks, etc.
DIR()
{
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
}

#For Sudo user
sudoCheck(){
if [[ $EUID -ne 0 ]]; then
  echo -e "Aborting the install process: This script must be run as root\n"
  return 1
else
  return 0
fi
}

sourceChek()
{
#Check if scrip is being sourced, sourceStatus=0 if sourced
[ "$0" = "$BASH_SOURCE" ] && { sourceStatus=1 ; return 1 ; } || { sourceStatus=0 ; return 0 ; }
#[[ $_ != $0 ]] && { sourceStatus1=0 ; return 0 ; }  || { sourceStatus1=1 ; return 1 ; }
}

ostype(){
ostype=$( echo $OSTYPE | tr '[A-Z]' '[a-z]' )
#export SHELL_PLATFORM='unknown'
case "$ostype" in
  *'linux'* ) SHELL_PLATFORM='linux'  ;;
  *'darwin'*  ) SHELL_PLATFORM='osx'    ;;
  *'bsd'*   ) SHELL_PLATFORM='bsd'    ;;
esac
}


#Exit the script from a script or function, just call killMe but not for sourced!!!!
trap "exit 1" TERM
export TOP_PID=$$
function killMe()
{
   echo "Goodbye"
   kill -s TERM $TOP_PID
}

#Exit script if sourcerd or not; no good for functions
#return 1 2>/dev/null || exit

#yes_or_no function that will return 0 our 1
yes_or_no()
{
    #Possible argument for yes_or_no
    if [[ $1 =~ ^[yY](es)? ]] ; then
        return 0
    elif [[ $1 =~ ^[nN]o? ]] ; then
        return 1
    fi

    #Promp interaction
    unset yes_or_no_option
    read -p "Type Yes(y) or No(n) `echo $'\n> '`" yes_or_no_option
    if [[ $yes_or_no_option =~ ^[yY](es)? ]] ; then
        return 0
    elif [[ $yes_or_no_option =~ ^[nN]o? ]] ; then
        return 1
    else
        echo "Invalid option!"
        yes_or_no
    fi
}

##define options via flagged input arguments
#while [[ $1 =~ ^- ]] ; do
#    case $1 in
#        -F | --Force)
#            ForceYes="yes"
#            shift
#             ;;
#        -f | --file)
#            if [[ -f $2 ]]; then
#                dotComFileIn=$2
#                shift
#                shift
#            else
#                echo -e "\nFile not found\n"
#                return 1 2>/dev/null || exit
#            fi
#            ;;
#        -h | --help)
#            echo -e "\nUsage:"
#cat <<EOF
#[optional]
#Create your helper here!!!
#        -F --Force executing bypassin all chekpoints
#        -f --file for file input regex subtitution
#        -h --help
#EOF
#
#            return 1 2>/dev/null || exit
#            ;;
#        -*)
#            echo "Error: Unknown option: $1" >&2
#            return 1 2>/dev/null || exit
#    esac
#done