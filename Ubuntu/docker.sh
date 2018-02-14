#!/bin/bash

function install_docker_ubuntu()
{   
    sudo docker version 2> /dev/null
    if [ $? == "0" ]
    then
    	echo "Docker already installed!"
    else
    	echo "Setting up Docker"
		#update the apt package index
		sudo apt-get update
		#Dependnecy packages packages to install docker
		sudo apt-get install apt-transport-https ca-certificates curl software-properties-common wget -y
		#Add docker official GPG key
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		#Download docker repository
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
		#Update the apt package index
		sudo apt-get update
		#Install docker 
		sudo apt-get install docker-ce=17.12.0~ce-0~ubuntu -y 
		#Add user to the docker group
		sudo usermod -aG docker $USER
	fi
}

install_docker_ubuntu