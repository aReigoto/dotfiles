echo -e "To edte the script run with -e flag."

cd ~/Dropbox/00-NotSharing/02-Informatica/python/Projects/music/m21_python3

if [[ $1 =~ '-e' ]] ; then
    subl 2_earTraninTriades.py
    exit 0
fi

pipenv run python 2_earTraninTriades.py $@
/Applications/Logic\ Pro\ X.app/Contents/MacOS/Logic\ Pro\ X Midi_files/earTraing.midi &
