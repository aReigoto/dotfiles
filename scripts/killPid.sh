#!/usr/bin/env bash

echo

unset program_to_kill
unset all_infoPid
unset number_of_matches
unset var


my_name=`basename "$0"`

program_to_kill=$( echo $@ | awk '{print $1}' )
programs_found=$( ps aux | grep -i "$program_to_kill"  | grep -v "grep"  | grep -v "$my_name" )

all_infoPid=$( echo "$programs_found" | awk '{$1=$3=$4=$5=$6=$7=$8=$9=$10="" ; print $0 }' )
number_of_matches=$( echo "$all_infoPid" | wc -l | sed "s/ *\([1-9]*\)*/\1/" )
var=1

if [[ -z $programs_found ]]; then
  echo "No match found!"
  exit 0
fi


echo " PID       Index    COMMAND"

while (( $number_of_matches >=  $var )); do
	echo "============ $var ============"
	echo -e "$all_infoPid" | sed -n "${var}p"
	((var+=1))
done

echo -e "===========================\n"
read -ep "Please choose indices to kill separated with a sapace $(echo $'\n> ')" killNumber

echo -e "$all_infoPid"
echo "####################-#################"

var=1

while (( $number_of_matches >=  $var )); do
  if [[ $killNumber =~ ^[Aa](ll)? ]]; then
    echo -e "$all_infoPid" | sed -n "${var}p" | awk '/killPid.sh/{ print $1 }' | xargs kill -9 && echo -e "$all_infoPid" | sed -n "${var}p" | awk '{ print $0 " !! Was killd !!" }'
  else
    for i in $killNumber ;
    do
      if [[ "$var" =~ "$i"$ ]]; then
        echo -e "$all_infoPid" | sed -n "${var}p" | awk '{ print $1 }' | xargs kill -9 && echo -e "$all_infoPid" | sed -n "${var}p" | awk '{ print $0 " !! Was killd !!" }'
      fi
    done
  fi
	((var+=1))
done

unset program_to_kill
unset all_infoPid
unset number_of_matches
unset var
