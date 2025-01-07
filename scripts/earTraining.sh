#!/usr/bin/env zsh

echo -e "To edte the script run with -e flag."

cd ~/Dropbox/00-NotSharing/02-Informatica/python/Projects/music/m21V2/

if [[ $1 =~ '-e' ]] ; then
  code .  
  #subl earTraningChordsCmdL.py
  exit 0
fi

#pipenv run python earTraningChordsCmdL.py $@
#conda run -n music python earTraningChordsCmdL.py $@
conda activate music
python earTraningChordsCmdL.py $@
conda deactivate

exit_code=$?

if [ $exit_code -eq 0 ]; then
    echo "Command succeeded"
    #/Applications/Logic\ Pro\ X.app/Contents/MacOS/Logic\ Pro\ X Midi_files/earTraining.midi &
else
    echo "earTraningChordsCmdL.py failed with exit code $exit_code"
fi



# earTraining.sh --n_chord_notes=3 --root_random='D3' --voice_leading=false
# earTraining.sh --n_chord_notes=3 --root_random='D3' 

#earTraining.sh --n_chord_notes=3 --root_random='D3' --voice_leading='{"0":1,"1":1}'
#earTraining.sh --voice_leading='{"0":1,"1":1,"2":1}'
#earTraining.sh  --voice_leading='{"0":1,"1":null,"2":1,"sum":2}'
#earTraining.sh --voice_leading='{"0":1,"1":1,"sum":2}'
