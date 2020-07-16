#!/usr/bin/env bash

###############################################################################################
#
#                                       TODO or not TODO
#
#   Install and Use GNU Command Line Tools on Mac OS X
#   https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
#   brew install coreutils
#
###############################################################################################


# This function accepts two var not arrays!
# The for loop is in charge of expanding the vars
# Work arroud for arrys:
# "${array[*]}"
check_interception(){
  for i in ${2} ; do
    echo "$1" 2>&1 /dev/null | grep "$i"  && return 0
  done
  return 1
}

# Get the path of the scrip
SCRIPT_DIR="${BASH_SOURCE[0]}";
if ([ -h "${SCRIPT_DIR}" ]) then
  while([ -h "${SCRIPT_DIR}" ]) do SCRIPT_DIR=`readlink "${SCRIPT_DIR}"`; done
fi
pushd . > /dev/null
cd `dirname ${SCRIPT_DIR}` > /dev/null
SCRIPT_DIR=`pwd`;
popd  > /dev/null

DOTFILES=${SCRIPT_DIR%/*}

logFolderBrew="$HOME/logs/dotfilesLogs/brewLogs/brewUpgrade/"

if [[ ! $OSTYPE =~ darwin* ]]; then
  echo "You are not on a osX machine!"
  exit 1
fi

if ! ( brew -v &> /dev/null ) ; then
  echo "No brew installed!"
  exit 1
fi

if [[ ! -d ${logFolderBrew} ]]; then
    mkdir -p ${logFolderBrew}
fi

brew_list=($(brew list))

echo "brew update"
brew update

# Get upgratable programs
readarray -t  brew_upgarde_list < <(cat ${DOTFILES}/install/brew_install_list.txt | grep -v "#" | grep -v "^//")

# Get not upgratable programs and deleat spaces
readarray -t  not_list < <(cat ${DOTFILES}/install/brew_install_list.txt | grep "#" | grep -v "^//" | sed -n -E 's/\s*#\s*//g p')

#readarray -t  brew_upgarde_list < <( cat ${DOTFILES}/install/brew_install_list.txt | sed -n 's/.*#.*$//g ; s/^\/\/.*// ; /^$/!p')

for program in "${brew_upgarde_list[@]}"
do
  program="${program%% *}"

  # Check if is installed
  if ( echo "${brew_list[@]}" | grep "${program}" &> /dev/null ) ; then

    # Check for bad dependencies
    program_dep=$( brew deps "${program}" )
    dep_name=$(check_interception "$program_dep" "${not_list[*]}")
    # The $? is the retirn code form the last commad "check_interception"
    if [[ $? -eq 0 ]] ; then echo -e "${program} has the bad dependencie => $dep_name\n" ; continue ; fi

    echo -e "<===========> ${program} start <===========>" | tee -a "${logFolderBrew}${program}.log"

    # Try the upgrade
    #eval 'brew upgrade ${program}' 2>&1 | tee -a "${logFolderBrew}${program}.log" | grep "already installed"
    eval brew upgrade "${program}" | tee -a "${logFolderBrew}${program}.log" | grep "already installed"

    # Check the upgrade or grep exit code
    if [[ ${PIPESTATUS[0]} -eq 0 || ${PIPESTATUS[2]} -eq 0 ]] ; then
      echo -e "<===========> ${program} done <===========>\n" | tee -a "${logFolderBrew}${program}.log"
    else
      echo -e "<===========> ${program} erro <===========>\n" | tee -a "${logFolderBrew}${program}.log"
    fi
  fi
done
echo "done"



