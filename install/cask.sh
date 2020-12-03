#!/usr/bin/env bash

# brew cask list to check installed programs
# check bash-completion cask development 
# if brew cask install doesn't work try brew tap caskroom/cask
# brew install Caskroom/cask/xquartz

logFolderCask="$HOME/dotfilesLogs/brewLogs/cask/"

list_install_cask=( "xquartz"
            "iterm2"
            "sublime-text"
            "visual-studio-code"
            "google-chrome"
            "firefox"
            "keka"
            "flux"
            "openemu"
            "vlc"
            "stremio"
            "djview"
            "dropbox"
            "skype"
            "cheatsheet"
            "tor-browser"
            "virtualbox"
            "virtualbox-extension-pack"
            #"soundflower"
            "deluge"
            "soulseek"
            "musicbrainz-picard"
            "mipony"
            "jdownloader"
            "kid3"
            "spotify"
            "mounty"
            "mactex"
            "bonjour-browser"
            "docker"
            "whatsapp"
            "cyberduck" 
			"balenaetcher" 
			"karabiner-elements" 
			"snappy"
			"sketchbook"
			"musescore")


# Cog is from
# https://github.com/kode54/Cog
# https://kode54.net/cog

IFS_ORIGINAL=$IFS
IFS=$'\n'
brew_list=()
for A in $(brew cask list)
do
    brew_list+=($A)
done

if ( brew -v &> /dev/null ) ; then
        
    if [[ ! -d ${logFolderCask} ]]; then
        mkdir -p ${logFolderCask}
    fi
    
    for list in ${list_install_cask[@]}
    do
        IFS=$IFS_ORIGINAL
        fileName="${list%% *}"
        fileName="${fileName##*/}"
        if ! ( echo ${brew_list[@]} | grep "${list%% *}" ); then 
            { 
                {
                echo -e "<===========> start ${list%% *} start <===========> ";
                eval 'brew cask install ${list}' 2>&1 | tee ${logFolderCask}/"${fileName}".log && \
                echo -e "<===========> done ${list%% *} done <===========> " ;
                } || \
                echo -e "<===========> erro ${list%% *} erro <===========> " ;
                }
        fi
    done
    #return 0
fi
return 0
