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

function java_install(){
    java -version 2> /dev/null
    if [ $? != '0' ]; then
        echo "Java isn't installed. Installing..."
        sudo apt-get install -y gunzip
		sudo mkdir -p /usr/lib/jvm/java-8-oracle
		wget --no-cookies --no-check-certificate --header \
	                     "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
	                     "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz"
		gunzip jdk-8u161-linux-x64.tar.gz
		tar -xvf jdk-8u161-linux-x64.tar
		sudo mv jdk1.8.0_161/* /usr/lib/jvm/java-8-oracle
		sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-8-oracle/bin/java 100
		sudo update-alternatives --install /usr/bin/jps jps /usr/lib/jvm/java-8-oracle/bin/jps 100
		echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc
		sudo rm -rf jdk1.8.0_161 jdk-8u161-linux-x64.tar
    else
        echo "Java is already installed. Skipping..."
    fi
}

wget_install
java_install