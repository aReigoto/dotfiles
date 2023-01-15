#!/usr/bin/env bash

##################################
##########   Variables  ##########
##################################


defaultVolumes=("SSD_Boot" "Quatro.Tera" "Dois.Tera")
availableVolumes=$(ls /Volumes/)
destinyFolder="$HOME/Desktop/RipedCds/"


##################################
##########   Functions  ##########
##################################

copyAiffFolder()
{
echo "this folther has aiff files so is good to go!"
echo '-------------------------------------'
echo "copying files"
mkdir -vp $destinyFolder
cp -v *.aiff "${destinyFolder}/"
}

aiffToMp3Lame()
{
#cd ${destinyFolder}
echo '-------------------------------------'
echo "converting aiff files to mp3 in ${PWD}"
# VERY GOOD METHOD TO DEAL WITH WITHE SAPACES ON FILE NAMES
for f in * ; do
  [[ "$f" != *.aiff ]] && continue
  lame --preset insane "$f" "${f%.aiff}.mp3"
done
#find . -name '*.aiff' -exec lameInsaneUsingFor.sh {} \;
#find . -name '*.aiff' exec bash -c 'aiffToMp3Lame' {} \;
#find . -name '*.aiff' | while read file; do aiffToMp3Lame "$file"; done
}

cleanTempFiles()
{
echo '-------------------------------------'
echo "If you want to remove the .aiff files type 1"
echo "If you want to open the folder whit the mp3s type 2"
echo "If you want to exacute all previos options type 3"
echo '-------------------------------------'
echo -e "\n"
echo -e "Please chose 1,2,3 \n >"

read RESPOSTA
case $RESPOSTA in
  1)  rm *.aiff
      ;;
  2)  open .
      ;;
  3)  rm *.aiff
      open .
      ;;
esac
}

##################################
###########    MAIN   ############
##################################

if (( "$#" == 0 )) ; then
  aiffInPWD=$(ls -1 *.aiff)
  if [[ $aiffInPWD ]] ; then
    lastFolderOfPWD=${PWD##/*/}
    destinyFolder="${destinyFolder}${lastFolderOfPWD}"
    copyAiffFolder
    cd ${destinyFolder}
    aiffToMp3Lame
    cleanTempFiles
    cd - > /dev/null
  fi
fi
