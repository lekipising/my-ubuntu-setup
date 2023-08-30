#!/bin/bash

# This script is used to setup a new ubuntu machine.

# update system
sudo apt update
sudo apt install -y software-properties-common

# upgrade system
sudo apt upgrade -y && sudo apt dist-upgrade -y

# install programs/tools - common
sudo apt install git wget gimp gparted maven gnome-tweaks gnome-shell-extensions neofetch nettools default-jre vlc -y

# install docker - steps
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

sudo groupadd docker

sudo usermod -aG docker $USER

# LAMP stack steps
sudo apt install apache2 -y
sudo ufw allow in "Apache"

sudo apt install mysql-server -y

sudo apt install php libapache2-mod-php php-mysql -y

# install snaps
sudo snap install slack --classic
sudo snap install mysql-workbench-community
sudo snap install heroku --classic

# allow workbench to access password service
sudo snap connect mysql-workbench-community:password-manager-service :password-manager-service

# install nodejs - 18 LTS
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# create git config
git config --global user.name $1
git config --global user.email $2

# install google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y

# install vscode
wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install ./vscode.deb -y

# node packages - global
sudo npm i -g npm-check-updates
sudo npm install -g pnpm

# clean up
sudo apt autoremove -y

# reboot system in 5 seconds - countdown
echo "Rebooting in 5 seconds..."
sleep 1
echo "Rebooting in 4 seconds..."
sleep 1
echo "Rebooting in 3 seconds..."
sleep 1
echo "Rebooting in 2 seconds..."
sleep 1
echo "Rebooting in 1 seconds..."
sleep 1
sudo reboot
