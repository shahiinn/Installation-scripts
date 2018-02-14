#!/bin/bash

function ubuntu_nmap_install()
{
	nmap --version 2> /dev/null
	if [ $? == '0' ]
	then
		echo "Nmap already installed"
	else
		echo "Setting up nmap-latest-stable..."
		sudo apt-get update
		sudo apt-get install nmap -y
    	sudo ln -s /usr/bin/nmap /usr/local/bin/nmap
    fi
}

ubuntu_nmap_install