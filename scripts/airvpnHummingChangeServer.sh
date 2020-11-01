#!/usr/bin/env bash

storeFolder="/home/pi/.airvpn/hummingbird/servers"
currenServer="/home/pi/.airvpn/hummingbird/currentServer.env"

if [[ ${#@} != 1 ]]; then
	echo "Please provide the tar config file!"
	echo "$(ls -1 ${storeFolder}/*.ovpn)"
	exit 0
fi

if [ -f $1 ] ; then
	
	if ! [[ $1 =~ .*ovpn ]] ; then echo "A .ovpn file is requierd as a argument!" ; exit 0 ; fi

	echo "ovpnServerPath=$1" > "${currenServer}"

	sudo systemctl restart airvpn.service
fi
