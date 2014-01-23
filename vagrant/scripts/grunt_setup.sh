#!/usr/bin/env bash

echo "--- Setting Gruntfile.js ---"

sudo cp -f /vagrant/vagrant/templates/Gruntfile.js /vagrant/

if [ ! -d "/vagrant/public/js" ];
then
    sudo mkdir /vagrant/public/js
    sudo mkdir /vagrant/public/js/build
fi

if [ ! -d "/vagrant/public/css" ];
then
    sudo mkdir /vagrant/public/css
    sudo mkdir /vagrant/public/css/build
    sudo touch /vagrant/public/css/global.scss
fi
