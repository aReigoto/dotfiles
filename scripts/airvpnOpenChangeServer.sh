#!/usr/bin/env bash

storeFolder="/home/pi/.airvpn/openvpn/servers"
currenServer="/home/pi/.airvpn/openvpn/currentServer"

if [[ ${#@} != 1 ]]; then
	echo "Please provide the tar config file!"
	echo "$(ls -1 ${storeFolder}/*.ovpn)"
	exit 0
fi

if [ -f $1 ] ; then

	if ! [[ $1 =~ .*ovpn ]] ; then echo "A .ovpn file is requierd as a argument!" ; exit 0 ; fi

	perl -pe 's/((ca|user|ta)\.\w+)/\/etc\/openvpn\/$1/' "$1" > "${currenServer}/client.conf"

	cp -r ${storeFolder}/{ca.crt,ta.key,user.crt,user.key} $currenServer

	cd $currenServer

	echo -e '\ncript-security 2 \nup /etc/openvpn/update-resolv-conf \ndown /etc/openvpn/update-resolv-conf' >> client.conf

	sudo cp -f client.conf ca.crt ta.key user.crt user.key /etc/openvpn/

	sudo systemctl restart openvpn.service
fi
