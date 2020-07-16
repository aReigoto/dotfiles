
program=$1

if [ -z $program ] ; then 
    echo "You must name a program."
    exit 0
fi

declare -a folders=(
"/Applications/Native Instruments"
"/Library/Preferences" # ... com.native-instruments."
"/Library/Audio/Plug-Ins/Components"
"/Library/Audio/Plug-Ins/VST"
"/Library/Application Support/Digidesign"
"/Library/Application Support/Avid/Audio/Plug-Ins"
"/Library/Application Support/Native Instruments"
"/Library/Application Support/Native Instruments/Service Center"
"/Users/$USER/Library/Preferences" #... com.native-instruments."
"/Users/$USER/Library/Application Support/Native Instruments"
)

for folder in "${folders[@]}" ; do 
    # ls "${folder}"*"${program}"*
    echo -e "\n Search on folder: ${folder}"
    find "${folder}" -iname *$program*
done
