#!/usr/bin/env bash

if ! ( tex -v ); then
    cd $TMPDIR
    curl -O http://tug.org/cgi-bin/mactex-download/MacTeX.pkg
    sudo installer -pkg MacTeX.pkg -target /                    # check the target !!
fi
