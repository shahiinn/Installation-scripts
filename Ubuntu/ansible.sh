#!/bin/bash

function install_ubuntu_ansible()
{
	ansible --version 2> /dev/null
    if [ $? == '0' ]
    then
        echo "Ansible is already Installed.."
    else
	    pip --version 2> /dev/null
	    if [ $? != '0' ]
	    then
			sudo apt-get update
			sudo apt-get install -y python-pip
			sudo apt-get install python-dev libffi-dev libssl-dev -y
	    fi
	    echo "Setting up Ansible"
		sudo pip install --upgrade pip
	    sudo pip install ansible==$ANSIBLE_VERSION
	    sudo apt-get install -y sshpass
	fi
}

install_ubuntu_ansible