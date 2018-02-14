#!/bin/bash

function wget_install(){
    test_wget=`which wget`
    if test "${test_wget#*/wget}" == "$test_wget"; then
        echo "wget isn't installed. Installing..."
        sudo apt-get update
        sudo apt-get install wget
    else
        echo "wget is already installed. Skipping..."
    fi
}

function python_install(){
	    echo "Setting up Python3..."
        sudo apt-get update
        sudo apt-get install -y build-essential checkinstall
        sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
        cd /usr/src
        sudo wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
        sudo tar xzf Python-3.5.2.tgz
        GROUP=`(id -g -n)`
        sudo chown -R $USER:$GROUP /usr/src/Python-3.5.2
        cd /usr/src/Python-3.5.2 && sudo ./configure
        cd /usr/src/Python-3.5.2 && sudo make altinstall
        sudo ln -s /usr/local/bin/python3.5 /usr/local/bin/python3
        sudo apt-get install -y python-pip python3-pip
}

wget_install
python_install