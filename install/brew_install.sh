#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
  echo -e "Aborting the install process: This script must be run as root\n"
  return 1 2>/dev/null || exit 
fi

logFolderBrew="$HOME/logs/dotfilesLogs/brewLogs/brew/"

if [[ ! -d $logFolderBrew ]]; then
  mkdir -p $logFolderBrew
fi


if [[ $OSTYPE =~ "darwin" ]]; then
  if ! ( xcode-select -v ) ; then
    xcode-select --install ||  { echo -e "<===========> \nErro installing xcode!" ; return 1 ; }
  #return 0
  fi

  if ! ( brew -v &> /dev/null ) ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" | \
    tee ${logFolderBrew}brewInstall.log || { echo -e "<===========> \nErro brew install!" ; return 1 ; }
    brew doctor | tee ${logFolderBrew}brewDoctor.log || { echo -e "<===========> \nErro brew doc!" ; return 1  ; }
  #return 0
  fi
fi
