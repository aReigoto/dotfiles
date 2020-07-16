#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
       echo -e "Aborting the install process: This script must be run as root\n"
       exit;
fi

echo "Installing dotfiles"

#echo "Initializing submodule(s)"
#git submodule update --init --recursive

echo "Linking scripts to $HOME/.local/scripts"
source install/link.sh

if [ "$(uname)" == "Darwin" ]; then
    echo -e "\n\nRunning on OSX"

    source install/osxbasics.sh
    source install/brew_install.sh
    source install/cask.sh
    source install/brew.sh
    source install/git.sh
    source install/python.sh
    source install/latex.sh     # included in cask but not working
    source install/root.sh
    source install/hep.sh
    source install/powerline-fonts.sh
    source install/bash.sh
fi

#echo "creating vim directories"
#mkdir -p ~/.vim-tmp


#echo "Configuring zsh as default shell"
#chsh -s $(which zsh)

echo "Done."

###############################################################################################
#
#                                       TODO or not TODO
#
#gfortran from
#https://gcc.gnu.org/wiki/GFortranBinaries#MacOS
#MacOS
#The gfortran maintainers offer nice Apple-style installers for…….
#NOT from source
