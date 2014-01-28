#!/usr/bin/env bash

ENV_NAME=$1

echo "--- Setting up hostname ---"
sudo rm /etc/hostname
sudo echo "$ENV_NAME" >> /etc/hostname
sudo echo "127.0.1.1       $ENV_NAME" >> /etc/hosts
sudo hostname $ENV_NAME
hostname

echo "--- Updating packages list ---"

sudo apt-get update

echo "--- Installing base packages ---"
sudo apt-get install -y curl git-core build-essential openssl libssl-dev python-software-properties python g++ make zip unzip
sudo apt-get install -y vim

sudo apt-get update

echo "--- Setting LC_ALL to en_US.UFT8 ---"
sudo sed -i "s/LC_ALL=\"en_US\"/LC_ALL=\"en_US.UTF8\"/" /etc/default/locale
