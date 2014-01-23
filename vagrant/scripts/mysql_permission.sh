#!/usr/bin/env bash

sudo sed -i "s/bind-address.*=.*/bind-address=0.0.0.0/" /etc/mysql/my.cnf
MYSQLGRANT="GRANT ALL ON *.* to root@'%' IDENTIFIED BY 'root'; FLUSH PRIVILEGES;"
sudo mysql -u root -proot mysql -e "${MYSQLGRANT}"
sudo service mysql restart
