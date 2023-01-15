#!/usr/bin/env bash

# tmux_sessions=$(tmux ls | sed -n "s/\([A-Za-z0-9_.,]*\):.*/\1/p")

unset tmux_sessions
unset in_var
unset n

declare -a tmux_sessions
tmux_sessions=($(tmux ls | grep -o '^[A-Za-z0-9_.,]\+'))

if [[ -z "$tmux_sessions" ]]; then
  tmux new -As ARC
  exit
else
  echo "Current open sessions are:"
  n=0
  for i in ${tmux_sessions[*]} ; do 
    echo "$n -> $i"
    ((n++))
  done
fi

echo -e "                       ====  Choose your path  ===="
echo -e "-- Attach to one existing session            > session_number"
echo -e "-- Create new simple session                 > new_session_name"
echo -e "-- Create a new session and attach to other  > new_session_name -t existing_session_name"
read -ep "$(echo $'\n> ')" in_var

if [[ "$in_var" =~ [0-9]+ ]] && (( "$in_var" <= "$n" )) 2> /dev/null; then 
  # echo "------"
  # echo "${tmux_sessions[$in_var]}"
  tmux a -t "${tmux_sessions[$in_var]}"
  exit
else
  tmux new -s ${in_var}
  exit
fi
