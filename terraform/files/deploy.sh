#!/bin/bash

# set -e

# Install git
sudo apt update
sudo apt install git -y

# yankee doodle going home
cd ~

# download src
git clone -b monolith https://github.com/express42/reddit.git

# install dependencies
cd reddit && bundle install

#create systemd config
sudo mv /tmp/puma.service /etc/systemd/system/puma.service

# Reread configs
sudo systemctl daemon-reload

# Start app
sudo systemctl start puma.service

# Make autostart on boot
sudo systemctl enable puma.service

# Check status
# sudo systemctl status puma.service

# check status by old way
ps aux | grep puma
