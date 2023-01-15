#!/usr/bin/env bash

#=# Declare variables
dir_source="/Volumes/DISK01/MG5_aMC_v2_2_2/bin/BackgSig_SET_01/"
dir_target="/Volumes/im/just/the/destination/folder/"
#=# Declare array
declare -a files_name=('tag_1_pythia_events.hep.gz' 'tag_1_events_delphes_card_ATLAS.root')

#=# Go to dir_source
cd "${dir_source}"

#=# Copy the files
for file_name in ${files_name[@]} ; do
    echo "/------------------------------------------------\\"
    echo "Copying the files: ${file_name}"

    # Option 1
    #find -L . -iname "${file_name}" | cpio -pdmL "${dir_target}"
    # Option 2
    rsync -varmRL --include="*/" --include="${file_name}" --exclude="*" . "${dir_target}"

done
