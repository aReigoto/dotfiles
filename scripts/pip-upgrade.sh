#!/bin/bash

list=( $(pip list --outdated --format=columns | awk '{ print $1 }') )

for pack in "${list[@]}" ; do
  echo -e "\n \t -$pack- \n"
  pip install $pack --upgrade
done
