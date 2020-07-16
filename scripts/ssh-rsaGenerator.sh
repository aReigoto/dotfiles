#!/usr/bin/env bash

if ( ssh -V ) ; then 
ssh-keygen
cat ~/.ssh/id_rsa.pub
pbcopy < ~/.ssh/id_rsa.pub
echo "Key copied to the clipboard"
fi
