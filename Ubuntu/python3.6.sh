#!/bin/bash

function py3_install(){
    python3.6 --version 2> /dev/null
    if [ $? == '0' ]
           then
                echo "Python already setup. Skipping."
                python_version=3.6
            else
                echo "Python3 isn't installed. Installing..."
                sudo apt-get update
                sudo apt-get install -y build-essential checkinstall
                sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
                cd /usr/src
                sudo wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tar.xz
                sudo tar -xvf Python-3.6.1.tar.xz
                GROUP=`(id -g -n)`
                sudo chown -R $USER:$GROUP /usr/src/Python-3.6.1
                cd /usr/src/Python-3.6.1 && sudo ./configure
                cd /usr/src/Python-3.6.1 && sudo make altinstall
                sudo apt-get install -y python-pip python3-pip
            fi
        fi
}

py3_install