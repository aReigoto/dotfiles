#!/usr/bin/env bash

echo -e "To edte the script run with -e flag."

cd ~/Dropbox/00-NotSharing/02-Informatica/python/Projects/music/m21V2/

if [[ $1 =~ '-e' ]] ; then
    subl earTraningChordsCmdL.py
    exit 0
fi

pipenv run python earTraningChordsCmdL.py $@
/Applications/Logic\ Pro\ X.app/Contents/MacOS/Logic\ Pro\ X Midi_files/earTraining.midi &

# earTraining.sh --n_chord_notes=3 --root_random='D3' --voice_leading=false
# earTraining.sh --n_chord_notes=3 --root_random='D3' 

#earTraining.sh --n_chord_notes=3 --root_random='D3' --voice_leading='{"0":1,"1":1}'
#earTraining.sh --voice_leading='{"0":1,"1":1,"2":1}'
#earTraining.sh  --voice_leading='{"0":1,"1":null,"2":1,"sum":2}'
#earTraining.sh --voice_leading='{"0":1,"1":1,"sum":2}'