#!/usr/bin/env bash

#OSX only
users_list=($( dscl . list /Users | grep -v "^_" ))
re='^[0-9]+$'

get_valid_user(){
  n=0
  for i in ${users_list[@]} ; do
    echo "$n -> $i"
    ((n++))
  done
  read -ep "$(echo Please enter a number$'\n> ')" user_number
  if ! [[ ! $user_number =~ $re ]] || [ $user_number -ge $n ]; then
    echo "no match"
    get_valid_user
  else
    user_name=${users_list[$user_number]}
  fi
}

if [[ ! $EUID -ne 0 ]]; then
  echo -e "Aborting the install process: This script must NOT be run as root"
  echo -e "Select user to change bash\n"
  get_valid_user
  # echo "$user_name"
  # return 1 2>/dev/null || exit
fi

bash_GNU=$( brew --prefix bash 2> /dev/null )
if [[ ! -z $bash_GNU ]]; then
  bash_GNU+="/bin/bash"
  { cat /private/etc/shells | gerp $bash_GNU &> /dev/null; }  && \
    { sudo bash -c "echo $bash_GNU >> /private/etc/shells" ; }
  echo "$bash_GNU $user_name"
  chsh -s "${bash_GNU}" "${user_name}"
fi
