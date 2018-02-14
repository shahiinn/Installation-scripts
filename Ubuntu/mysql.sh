#!/bin/bash

function ubuntu_mysql_install()
{
  mysql --version 2> /dev/null
	if [ $? == '0' ]
    then
        echo "Mysql already installed. Checking if bigbrain user exists..."
    else
		echo "Setting up MySql-server"
		sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
		sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
		sudo apt-get -y install mysql-server
	fi
}

ubuntu_mysql_install