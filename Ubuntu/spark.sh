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

function spark_install(){
	apt-get update 
    mkdir /data/libs
    chmod +x /data/libs
    wget https://archive.apache.org/dist/spark/spark-2.1.0/spark-2.1.0-bin-hadoop2.7.tgz
    tar -xzf spark-2.1.0-bin-hadoop2.7.tgz -C /data
    mv /data/spark-2.1.0-bin-hadoop2.7 /data/spark-2.1.0
    rm -rf spark-2.1.0-bin-hadoop2.7.tgz
    rm -rf /var/lib/apt/lists/*
    echo -e "export SPARK_HOME=/data/spark-2.1.0 \n export PYSPARK_PYTHON=python3 \n export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin \n" > ~/.bashrc
    source ~/.bashrc
}

wget_install
spark_install