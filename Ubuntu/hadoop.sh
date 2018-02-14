#!/bin/bash

function hadoop_install(){
    apt-get update
    apt-get -y install --force-yes --no-install-recommends openssh-server
    wget https://archive.apache.org/dist/hadoop/core/hadoop-2.6.0/hadoop-2.6.0.tar.gz
    tar -xzf hadoop-2.6.0.tar.gz -C /data
    rm -rf hadoop-2.6.0.tar.gz
    ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N '' -P ""
    touch ~/.ssh/authorized_keys
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    echo 'Host * \n\
              StrictHostKeyChecking no \n\
              UserKnownHostsFile=/dev/null' > ~/.ssh/config
    mkdir -p /data/hdfs/namenode
    mkdir -p /data/hdfs/datanode
    mkdir -p /data/hdfs/tmp
    rm -rf /var/lib/apt/lists/*
    #Adding environment varibles
    echo -e 'export HADOOP_HOME=/data/hadoop-2.6.0 \n export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin \n export HADOOP_COMMON_HOME=$HADOOP_HOME \n export HADOOP_HDFS_HOME=$HADOOP_HOME \n export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native \n export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/native" \n export CLASSPATH=$CLASSPATH:/usr/local/hadoop/lib/*:. \n export HADOOP_OPTS="$HADOOP_OPTS -Djava.security.egd=file:/data/hadoop-2.6.0/temp/tmp"' > ~/.bashrc
    source ~/.bashrc
    /data/hadoop-2.6.0/bin/hdfs namenode -format
}

hadoop_install