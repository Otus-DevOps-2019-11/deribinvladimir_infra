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

#create systemd config
sudo touch /etc/systemd/system/puma.service
sudo chmod 664 /etc/systemd/system/puma.service
echo -e "[Unit]\nDescription=Puma HTTP Server\nAfter=network.target\n\n[Service]\nType=simple\nExecStart=/usr/local/bin/puma -d\nRestart=always\n\n[Install]\nWantedBy=multi-user.target\n" | sudo tee /etc/systemd/system/puma.service

# Reread configs
sudo systemctl daemon-reload

# Make autostart on boot
sudo systemctl enable puma.service

# Start app
sudo systemctl start puma.service

# Check status
sudo systemctl status puma.service

# oldway
# start app
# puma -d
# check status
# ps aux | grep puma
