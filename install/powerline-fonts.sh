#!/usr/bin/env bash

mkdir -p ~/TEMP

cd ~/TEMP 

git clone https://github.com/powerline/fonts.git

cd fonts

./install.sh

cd 

rm -rf ~/TEMP
