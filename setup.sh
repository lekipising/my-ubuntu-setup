#!/bin/bash

# This script is used to setup a new ubuntu machine.

# update system
sudo apt update

# upgrade system
sudo apt upgrade -y && sudo apt dist-upgrade -y

# install programs/tools - common
sudo apt install -y git curl wget vlc gimp gparted gnome-tweaks gnome-shell-extensions neofetch nettools default-jre maven

# install docker - steps
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo groupadd docker

sudo usermod -aG docker $USER


# LAMP stack steps
sudo apt install apache2
sudo ufw allow in "Apache"

sudo apt install mysql-server

sudo mysql_secure_installation

sudo apt install php libapache2-mod-php php-mysql

# install snaps
sudo snap install code --classic
sudo snap install spotify
sudo snap install postman
sudo snap install slack --classic
sudo snap install mysql-workbench-community

# allow workbench to access password service
sudo snap connect mysql-workbench-community:password-manager-service :password-manager-service

# install nodejs - 18 LTS
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# create git config
git config --global user.name "Liplan Lekipising"
git config --global user.email "mail@me.com"

# install google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

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