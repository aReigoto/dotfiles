#!/usr/bin/env bash

# for file in *.mp3 ; do  newName=` echo $file | perl -pe 's/(^[0-9-]+) - (.*\.mp3)/\1 \2 /' ` ;  mv "$file" "$newName" ; done

# regex='s/(^[0-9-]+) (.*\.mp3) $/\1 \2/'
# regex='s/(^[0-9-]+) - (.*\.mp3)$/\1 \2/'

# perl -ne 'if (/([0-9]+)(?: - )(.*mp3)/) { print "$1 $2" } '
# perl -ne 'if (/^([0-9-]+)?(?: - |-| -| -|\.|\. )?(.*mp3)$/) { print "$1 $2" } '

#---------- ----------#
# declare defouts
#---------- ----------#
arrayOfFolders="."
# arrayOfFolders="*/"
executeFlag="testMode"
fileExtention="*.mp3"
# fileExtention="*.mp3*" # get files with space at the end
regex='/^([0-9-]+)(?: - |-| -| -|\.|\. )(.*\.mp3)$/'

# regex='/^([0-9-]+)(.*)(\.mp3\s+)$/'
#  perl -ne 'if ('"$regex"') { print "$1 $2" } '

usage="$(basename ${BASH_SOURCE[0]}) [-e] [-d] [-E] [-r]

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
rename() {
  # newName=` echo $1 | perl -pe "$regex" `
  newName=` echo $1 | perl -ne 'if ('"$regex"') { print "$1 $2" } ' `
  if [[ -z $newName ]] ; then
    return 1
  elif [[ ! -z "$2" ]] && [[ "$2" == 'testMode' ]] ; then
    printf "%-70s -> %-70s\n" "$file" "$newName"
    return 0
  elif [[ ! -z $newName ]] ; then
    mv -iv "$1" "$newName"
    return 0
  fi
}


#---------- ----------#
# Store folders in a array and print the total number of elements
# for folder in */ ; do arrayOfFolders+=("$folder") ; done ; echo ${#arrayOfFolders[@]}
# Check the array content
# for folder in "${arrayOfFolders[@]}" ; do echo "$folder" ; done

echo -e "\nThe current regex is: \n $regex\n"
if [ "$executeFlag" == 'testMode' ] ; then
  echo -e "\n TEST MODE! \n Use -e flag to execute\n"
elif [ "$executeFlag" == 'Run' ] ; then
  echo -e "\n Executing \n"
fi

for folder in "${arrayOfFolders[@]}" ; do
    if [[ -d "$folder" ]]; then
      echo -e "\n$folder"
      cd "$folder"
      matchOnFolder=0
      for file in $fileExtention ; do
        rename "$file" "$executeFlag" && (( matchOnFolder++ ))
      done
      if [[ $matchOnFolder -eq 0 ]] ; then
        echo "No match found in folder above!"
        echo "Try -h flag for help."
      fi
      cd - &>/dev/null
    fi
done
