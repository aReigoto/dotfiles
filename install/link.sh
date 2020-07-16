#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES=${SCRIPT_DIR%/install}
BASH_PROFILES="${DOTFILES#$HOME/}/bash"
BASHSCRIPTS="$DOTFILES/scripts"
BASHSCRIPTS_LINKS="$HOME/.local/scripts"
SUBLIME_USR_SETINGS="$DOTFILES/sublime"
SUBLIME_BASE_DIR="$HOME/Library/Application Support/Sublime Text 3"
SUBLIME_LINKS="$SUBLIME_BASE_DIR/Packages/User"
ATOM_BASE_DIR="$HOME/.atom"
ATOM_USR_SETINGS="$DOTFILES/atom"

# DOTFILES1=$HOME/.dotfiles
# BASHSCRIPTS1=$HOME/.dotfiles/.local/scripts

# Interactive login order
# ~/.bash_profile
# ~/.bash_login
# ~/.profile
# Only the fierst is automaticli sorced

# Check if bash_login or profile exist @ home and are not links
# if yes then make bash_profile source them

if [[ ! -f ~/.bash_profile ]] ; then
  touch ~/.bash_profile
fi

echo -e "\nCheck for other bash_profiles"
echo "=============================="
# Since if there is a ~/.bash_profile it will be the only loaded bash file @ HOME
# In this logic ~/.bash_profile will load ~/.bash_login or ~/.profile if they exist
profiles_conflict=( ~/.bash_login ~/.profile )
for j in ${profiles_conflict[@]} ; do
  if [[ -f $j && ! -L $j ]] ; then
    if ! grep -E --quiet "^\s*(source|\.)\s+(\")?([$]HOME|~|$HOME)?${j#$HOME}" ~/.bash_profile ; then
      echo -e "$j is now source by ~/.bash_profile"
      echo -e "\nif [ -f ~${j#$HOME} ]; then \n . ~${j#$HOME} \nfi" >> ~/.bash_profile
    fi
  fi
done

echo -e "\nMake bash_profile source my bashrc and profile"
echo "=============================="
# Make bash_profile source my bashrc and profile
my_profiles=( ".bashrc" ".profile" )
for i in ${my_profiles[@]} ; do
  if ! grep -E --quiet "^\s*(source|\.)\s+(\")?($HOME/$BASH_PROFILES|~/$BASH_PROFILES|[$]HOME/$BASH_PROFILES)/$i" ~/.bash_profile ; then
    echo -e "$BASH_PROFILES/$i is now source by ~/.bash_profile"
    echo -e "\nif [ -f ~/${BASH_PROFILES}/$i ]; then \n . ~/${BASH_PROFILES}/$i \nfi" >> ~/.bash_profile
  fi
done

echo -e "\nMake ~/.bashrc source my bashrc"
echo "=============================="
# Make ~/.bashrc source my bashrc
# This is for pipenv and things like that, to have my alaias
my_profiles=( ".bashrc" )
for i in ${my_profiles[@]} ; do
  if ! grep -E --quiet "^\s*(source|\.)\s+(\")?($HOME/$BASH_PROFILES|~/$BASH_PROFILES|[$]HOME/$BASH_PROFILES)/$i" ~/.bashrc ; then
    echo -e "$BASH_PROFILES/$i is now source by ~/.bashrc"
    echo -e "\nif [ -f ~/${BASH_PROFILES}/$i ]; then \n . ~/${BASH_PROFILES}/$i \nfi" >> ~/.bashrc
  fi
done


echo -e "\nCreating symlinks"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target="$HOME/.$( basename $file '.symlink' )"
    if [ -e $target ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s $file $target
    fi
done

####################
# Still tryning neovim
####################
echo -e "\n\nInstalling linking vimrc and neovim at ~/.config"
echo "=============================="
if [[ ! -d $HOME/.config/nvim ]]; then
    echo "Creating ~/.config"
    mkdir -p $HOME/.config/
    #curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    if [[ ! -d $HOME/.vim ]]; then
        mkdir -p $HOME/.vim
        ln -s $HOME/.vim $HOME/.config/nvim
    else
        ln -s $HOME/.vim $HOME/.config/nvim
    fi
fi

if [[ -e ~/.config/nvim/init.vim ]]; then
        echo "~${HOME}/.config/nvim/init.vim already exists... Skipping."
    else
        echo "Creating symlink for $HOME/.nvimrc to $HOME/.config/nvim/init.vim"
        echo 'source ~/.nvimrc' > $HOME/.config/nvim/init.vim
        #ln -s $DOTFILES/vim/vim.symlink $HOME/.config/nvim/init.vim
        ln -s $HOME/.vimrc $HOME/.nvimrc
fi
####################
# Linking scripts
####################

echo -e "\n\nInstalling $BASHSCRIPTS_LINKS"
echo "=============================="
if [[ ! -d $BASHSCRIPTS_LINKS ]]; then
    echo "Creating $BASHSCRIPTS_LINKS"
    mkdir -p $BASHSCRIPTS_LINKS
fi

linkablesScrips=$( find -H "$BASHSCRIPTS" -maxdepth 3 -name '*' )
for file in $linkablesScrips ; do
    target="$BASHSCRIPTS_LINKS/${file##/*/}"
    if [[ -e $target ]]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s $file $target
    fi
done

echo -e "\nSublime Text Configs"
echo "=============================="

if [[ -d $SUBLIME_BASE_DIR ]]; then
  if [[ ! -d $SUBLIME_LINKS  ]]; then
    install_package="${SUBLIME_BASE_DIR}/Installed Packages"
    mkdir -p "$install_package"
    cd "$install_package"
    wget https://packagecontrol.io/Package%20Control.sublime-package
    cd -
  fi
  # subl_sets=("$( find $SUBLIME_USR_SETINGS -name '*.sublime-*' )")
  # for i in "${subl_sets[@]}" ; do
  for i in $SUBLIME_USR_SETINGS/* ; do
    # echo "debug -> $i"
    # echo $i
    f_name=$(basename -a "$i")
    full_name="${SUBLIME_LINKS}/$f_name"
    if [[ -f "$full_name" ]]; then
      echo "~${full_name#$HOME} already exists... Skipping."
    else
      echo "Creating symlink for $full_name"
      ln -s "$i" "$full_name"
    fi
  done
fi

echo -e "\nAtom Configs"
echo "=============================="

if [[ -d $ATOM_BASE_DIR ]]; then
  #mkdir $ATOM_BASE_DIR
    for i in $( ls -1 $ATOM_USR_SETINGS | grep -E '\w+\.(cson|coffee|list|less)' ); do
      src_file=$ATOM_USR_SETINGS/$(basename $i)
      trg_file=$ATOM_BASE_DIR/$(basename $i)
      if [[ -f $trg_file ]] ; then
        echo "~${trg_file#$HOME} already exists... Skipping."
      else
        echo "Creating symlink for $trg_file"
        ln -s $src_file $trg_file
      fi
    done

    cd $ATOM_BASE_DIR
    apm list --installed --bare > packages_local.list
    for pkg in $(cat $ATOM_USR_SETINGS/packages.list); do
      if ! grep -q ${pkg%%@*} $ATOM_BASE_DIR/packages_local.list ; then
        apm install $pkg
        #echo $pkg
      fi
    done

    for pkg in $(cat $ATOM_BASE_DIR/packages_local.list); do
      if ! grep -q ${pkg%%@*} $ATOM_USR_SETINGS/packages.list ; then
        echo "!!! $pkg -> is not on $ATOM_USR_SETINGS/packages.list !!!"
      fi
    done
    cd - &> /dev/null
fi
