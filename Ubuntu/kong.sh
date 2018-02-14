#!/bin/bash

function kong_install(){
	#Download kong installation file
	wget https://bintray.com/kong/kong-community-edition-deb/download_file?file_path=dists/kong-community-edition-0.11.1.trusty.all.deb
	mv download_file?file_path=dists%2Fkong-community-edition-0.11.1.trusty.all.deb kong-community-edition-0.11.1.trusty.all.deb

	#Install dependencies
	sudo apt-get update
	sudo apt-get install openssl libpcre3 procps perl

	#Install kong
	sudo dpkg -i kong-community-edition-0.11.1.trusty.all.deb


	#install postgresql
	#minimum 9.4+ required for kong
	#make a file in source.list.d
	touch postgresql.list


	#add repo in ablove list
	echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' >> postgresql.list
	sudo mv postgresql.list /etc/apt/sources.list.d
	rm postgresql.list
	
	#import repo key
	sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
	#update repo
	sudo apt-get update

	#install postgresql
	sudo apt-get -y install postgresql-9.6
	#start postgresql
	sudo service postgresql start

	#Create a user and database in psql
	sudo -u postgres bash -c "psql -c \"CREATE USER kong WITH PASSWORD 'kong';\""
	sudo -u postgres bash -c "psql -c \"create database kong owner kong;\""

	sudo sed -i -e 's/peer/md5/g' /etc/postgresql/9.6/main/pg_hba.conf

	sudo service postgresql reload

	#Kong configuration
	touch kong.conf

	echo "prefix = /usr/local/kong/" >>  kong.conf
	echo "log_level = debug"  >>  kong.conf
	echo "database = postgres"  >>  kong.conf
	echo "pg_host = 127.0.0.1"  >>  kong.conf
	echo "pg_port = 5432"  >>  kong.conf
	echo "pg_user = kong" >>  kong.conf
	echo "pg_password = kong"  >>  kong.conf	
	echo "pg_database = kong"  >>  kong.conf
	
	sudo cp kong.conf /etc/kong/kong.conf
	
	#Kong migrations
	kong migrations up [-c /etc/kong/kong.conf]
		
	#Start Kong service
	sudo kong start [-c /etc/kong/kong.conf]
	
	#install npm
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.7/install.sh | bash
	
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	
	. ~/.bashrc
	nvm install node
	npm install -g kong-dashboard
	nohup kong-dashboard start --kong-url http://localhost:8001 --port 16000 &	
	sleep 10

}

kong_install