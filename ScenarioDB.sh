#!/usr/bin/bash

  sudo yum -y install mariadb-server
  sudo systemctl start mariadb
  sudo systemctl enable mariadb


  #firewall-cmd --add-port=3306/tcp 
  #firewall-cmd --permanent --add-port=3306/tcp
