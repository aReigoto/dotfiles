#!/usr/bin/env bash

# ./gitUpdate.sh file1 file2 .... fileN -m "commit mesage"

source functions_and_tools.sh

if [[ $# == 0 ]] ; then echo "No input, no fun!" ; exit ; fi

cmmMsg=""
gitignore=""
in=("$@")
[ -f .gitignore ] && gitignore=($(cat .gitignore))
# echo "$gitignore"
# echo $in
echo "------   adding to git rep   ------"
for (( i = 0; i < ${#in[@]}; i++ )); do
  addFile=true
  for (( j = 0 ; j < ${#gitignore[@]} ; ++j )); do
    if [[ "${in[i]}" == ${gitignore[j]} ]] ; then 
      addFile=false ; break ;
    fi
  done
  if [[ "${in[i]}" == "-m" ]] ; then
      addFile=false ; cmmMsg=${in[i+1]} ; (( i++ )) ; 
  fi
  if ( $addFile ) ; then
    git add ${in[i]}
    echo ${in[i]}
  fi
done
echo "-----------------------------------"

if [[ -z $cmmMsg ]] ; then read -ep "Please enter a commit mesage `echo $'\n> '`" cmmMsg ; fi

echo "Proced with the commit ?"
if yes_or_no ; then
  git commit -m \""$cmmMsg"\"
  git pull
  git push
fi
# echo "git commit -m $cmmMsg"
# while (( "$#" )); do
#   if [ $# -gt 1 ]; then
#
#     echo git add \"$1\"
#   fi
#
#   if [ $# == 1 ]; then
#     echo "git commit -m \"$1\""
#     echo "git pull"
#     echo "git push"
#   fi
#
#   shift
# done

#git fetch --all
#git reset --hard origin/master
#or
#git reset --hard origin/your_branch #will remove all uncommitted changes from your working directory.
#or
#git pull

#1st do some commits?
#git checkout master 
#git branch new-branch-to-save-current-commits 
#git fetch --all 
#git reset --hard origin/master

#git reset git.sh
#git checkout git.sh
#git pull


#git checkout master
#git fetch --all
#git pull
