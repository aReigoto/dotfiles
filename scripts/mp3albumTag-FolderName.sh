#!/usr/bin/env bash

echo "This script runs recursively!"
echo "Album Tag will use a regex folder album name."

regex='/^(\[[0-9- ]+\] ?)(.*)$/'

echo -e "\nThe current regex is: \n $regex\n"

executeFlag="testMode"
fileExtention="*.mp3"
readarray -t arrayOfFolders < <( find . -name *.mp3 -print0 | xargs -0 -n1 dirname | sort --unique )

usage="$(basename "$0") [-e] [-d] [-E] [-r]

where:
    -e execute
    -d directory
    -E regex
    -r recursive
    -h show this help text

NOTE : The script will only change file's name with the flag -e"


#---------- ----------#
while getopts 'ehd:E:r' OPTION; do
  case $OPTION in
    e | --execute)
      executeFlag="Run"
       ;;
    r )
      readarray -t arrayOfFolders < <( find . -name $fileExtention -print0 | xargs -0 -n1 dirname | sort --unique )
      ;;
    d )
      arrayOfFolders=$OPTARG
      ;;
    E )
      regex=$OPTARG
      ;;
    h )
      echo "$usage"
      ;;
    \?)
      echo "$usage"
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

#---------- ----------#
if [[ $executeFlag ==  'testMode' ]] ; then
  echo -e "\n TEST MODE! \n Use -e flag to execute\n"
elif  [[ $executeFlag == 'Run' ]]; then
  echo -e "\n Executing \n"
fi

for folder in "${arrayOfFolders[@]}" ; do
  echo "On folder: $folder"
  albumTag="${folder##*/}"
  # Using a Regex
  albumTag=` echo $albumTag | perl -ne 'if ('"$regex"') { print "$2" } ' `

  if [[ -z $albumTag ]] ; then
    echo "No match found in folder above!"
    echo "Try -h flag for help."
    exit 1
  elif [[ ! -z $albumTag ]] && [[ $executeFlag ==  'testMode' ]] ; then
    printf "%-70s -> %-70s\n" "${folder##*/}" "$albumTag"
  elif [[ ! -z $albumTag ]] && [[ $executeFlag == 'Run' ]]; then
    id3tag --album="${albumTag}" *.mp3
  fi
  cd - &>/dev/null
  echo
done



