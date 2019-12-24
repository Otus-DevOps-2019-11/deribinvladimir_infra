#! /bin/bash
# update apt and install mongodb 4.2.2
# based on https://docs.mongodb.com/v4.2/tutorial/install-mongodb-on-ubuntu/

# import the MongoDB public GPG Key from https://www.mongodb.org/static/pgp/server-4.2.asc
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -

# Install gnupg and its required libraries
sudo apt-get install gnupg

# retry importing the key
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -

# Create the /etc/apt/sources.list.d/mongodb-org-4.2.list file for Ubuntu 16.04 (Xenial)
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

# reload the local package database
sudo apt-get update

# install mongi db 4.2.2 because we tested it to work
sudo apt-get install -y mongodb-org=4.2.2 mongodb-org-server=4.2.2 mongodb-org-shell=4.2.2 mongodb-org-mongos=4.2.2 mongodb-org-tools=4.2.2

# start mogo db
# you can also use 'sudo systemctl start mongod'
sudo service mongod start

# add to autostart
sudo systemctl enable mongod

# check status of mongod
sudo systemctl status mongod
