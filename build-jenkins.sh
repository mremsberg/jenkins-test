#!/bin/bash

# install tools
  yum install -y mlocate java-1.8.0-openjdk.x86_64 wget.x86_64

# format and mount the volume - not using this now, stashing for later use
#  mkfs.ext4 /dev/xvdb
#  mount /dev/xvdb /data/1/apps
# add to /etc/fstab
#  /dev/xvdb /data/1/apps ext4 defaults 0 2

# download and extract tomcat - we don't need this, but may come in handy in the future
#  wget http://mirror.reverse.net/pub/apache/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz
#  tar -xvf apache-tomcat-7.0.73.tar.gz -C /data/1/apps
# create a tomcat symlink
#  cd /data/1/apps
#  ln -s apache-tomcat-* tomcat

# open port 8080 - add line before the reject lines
  iptables -I INPUT 4 -m state --state NEW -p tcp --dport 8080 -j ACCEPT
  /sbin/service iptables save
  /sbin/service iptables restart

# add the jenkins yum repo
  wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# install and start jenkins
  yum install -y jenkins
  chkconfig jenkins on
  service jenkins start

# update the mlocate manifest
  sudo updatedb
