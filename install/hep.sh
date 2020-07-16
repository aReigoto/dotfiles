#!/usr/bin/env bash

#HEP tools 
#https://github.com/veprbl/homebrew-hep
#https://github.com/davidchall/homebrew-hep

hepLogFolder="$HOME/dotfilesLogs/brewLogs/hep/"

list_hep=(  "davidchall/hep/madgraph5_amcatnlo"
            "davidchall/hep/rivet" )

if ( brew -v &> /dev/null ) ; then
        
    brew tap davidchall/hep
        
    if [[ ! -d ${hepLogFolder} ]]; then
        mkdir -p ${hepLogFolder}
    fi
    
    for i in `seq 0 $(( ${#list_hep[@]} -1 ))`
    do
        fileName="${list_hep[$i]%% *}"
        fileName="${fileName##*/}"
        if ! ( brew list | grep "${list_hep[$i]%% *}" ); then { { eval brew install "${list_hep[$i]}" 2>&1 | tee ${hepLogFolder}/"${fileName}".log && echo -e "<===========> \n${list_hep[$i]%% *} done" ; } || echo -e "<===========> \n${list_hep[$i]%% *} erro" ; return 1 ; } ; fi
    done
    #return 0
fi
return 0
