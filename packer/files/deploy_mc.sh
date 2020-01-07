#! /bin/bash

# add universe repocitory to install midnight commander
sudo add-apt-repository universe
sudo apt update

# install mc
sudo apt install mc -y

# remove repo if need
# sudo add-apt-repository --remove universe
