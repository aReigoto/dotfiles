#!/bin/bash

# Set up global ignore files
git config --global core.excludesfile ~/.gitignore_global

# Set alias
git config --global alias.ca 'commit -a -m'
git config --global alias.s 'status -uall'
git config --global alias.p 'pull'
git config --global alias.f 'fetch --quiet'

git config --global alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'
git config --global alias.lg "log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)— %an%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"
git config --global alias.la "!git config -l | grep alias | cut -c 7-"
git config --global alias.lb 'for-each-ref --count=10 --sort=-committerdate refs/heads/ --format="%(refname:short)"'

