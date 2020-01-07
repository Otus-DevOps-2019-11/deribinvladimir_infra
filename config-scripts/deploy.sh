#! /bin/bash

# Install git
sudo apt update
sudo apt install git -y

# yankee doodle going home
cd ~

# download src
git clone -b monolith https://github.com/express42/reddit.git

# install dependencies
cd reddit && bundle install

# start app
puma -d

# check status
ps aux | grep puma
