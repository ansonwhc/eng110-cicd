#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# remove the old file
sudo rm /etc/nginx/sites-available/default

# copy our own to the nginx directory
sudo cp /home/ubuntu/sg_application/app_default /etc/nginx/sites-available/

# install nodejs
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nodejs -y

sudo apt-get update -y
sudo apt-get upgrade -y

# install npm
cd sg_application/app
npm install
# npm start & 
