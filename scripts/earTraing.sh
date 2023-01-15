#!/usr/bin/env bash

echo -e "To edte the script run with -e flag."

cd ~/Dropbox/00-NotSharing/02-Informatica/python/Projects/music/m21V2/

if [[ $1 =~ '-e' ]] ; then
    subl earTraningChordsCmdL.py
    exit 0
fi

pipenv run python earTraningChordsCmdL.py $@
/Applications/Logic\ Pro\ X.app/Contents/MacOS/Logic\ Pro\ X Midi_files/earTraing.midi &
