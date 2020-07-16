#!/usr/bin/env bash

cd $HOME/.dotfiles
echo -e"\ncrontab backUp dotfiles at $( time )" >> $HOME/logs/crontabLogs/dotfiles.log
gitFiles.sh * "chronos" >> $HOME/logs/crontabLogs/dotfiles.log

