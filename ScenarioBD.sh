#!/bin/bash
MAINDB="moodle"
USERDB="moodleUS"
PASSWDDB="moodlePAS"
sudo yum -y update

#install DB
sudo yum -y install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql -e "SET GLOBAL character_set_server = 'utf8mb4';"
sudo mysql -e "SET GLOBAL innodb_file_format = 'BARRACUDA';"
sudo mysql -e "SET GLOBAL innodb_large_prefix = 'ON';"
sudo mysql -e "SET GLOBAL innodb_file_per_table = 'ON';"
sudo mysql -e "CREATE DATABASE ${MAINDB};"
sudo mysql -e "CREATE USER '${USERDB}'@'localhost' IDENTIFIED BY '${PASSWDDB}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${USERDB}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"



sudo firewall-cmd --zone=publicweb --add-service=ssh
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

