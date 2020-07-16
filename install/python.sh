#!/usr/bin/env bash

logFolderPip="$HOME/dotfilesLogs/brewLogs/pip/"

pip_list=(  "numpy"
            "scipy"
            "matplotlib"
            "pandas"
            "pandas-datareader"
            "plotly"
            "cufflinks"
            "ipython"
            '"ipython[notebook]"'
            "flask"
            "flask_mysqldb"
            "tensorflow"
            "tensorflow-tensorboard"
            "termcolor"
            "neovim" )


if !( brew -v &> /dev/null ) ; then
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install python
#return 0
fi

if ( brew -v &> /dev/null ) ; then
    
    if ! $(python -V) ; then
        brew install python
    fi

    if [[ ! -d ${logFolderPip} ]]; then
        mkdir -p ${logFolderPip}
    fi
    pip install --upgrade pip setuptools
    for i in `seq 0 $(( ${#pip_list[@]} -1 ))`
    do
        fileName="${pip_list[$i]%% *}"
        fileName="${fileName##*/}"
        if ! ( pip list | grep "${pip_list[$i]}" ); then { { eval pip install "${pip_list[$i]}" 2>&1 | tee ${logFolderPip}"${fileName}".log && echo -e "<===========> \n${pip_list[$i]%% *} done" ; } || echo -e "<===========> \n${pip_list[$i]%% *} erro" ; } ; fi
    done
#return 0
fi
#pip3 install neovim
return 0
