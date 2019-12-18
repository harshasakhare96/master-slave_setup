#!/bin/bash

PASSWORD=1234
ENCRYPTED_PASSWORD=$(openssl passwd -1 ${PASSWORD})
#sudo useradd ansible
sudo useradd -m -p $ENCRYPTED_PASSWORD ansible

SEARCH="PasswordAuthentication no"
REPLACE="PasswordAuthentication yes"
FILEPATH="/etc/ssh/sshd_config"
sudo sed -i "s;$SEARCH;$REPLACE;" $FILEPATH

# Restart the SSH service for change to take effect.
sudo service sshd restart

# Give the ansible user passwordless sudo
echo 'ansible ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo



SEARCH="PasswordAuthentication no"
REPLACE="PasswordAuthentication yes"
FILEPATH="/etc/ssh/sshd_config"
sudo sed -i "s;$SEARCH;$REPLACE;" $FILEPATH


sudo mkdir  /home/ansible/.ssh
cd /home/ansible/.ssh
chmod 777 .ssh
touch  .ssh/authorized_keys
chmod 700 .ssh/authorized_keys
cat >> /home/ansible/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD8luIO174s+LmLznX+8KVGkBXtLNZorz0nSkHLmHBfVp8ynfDCQ8h772IKaOyG0axSNbUGqtkiMdbZiOikd+qtYp6p46HBTciRuX+6WUGeLPhGiIrmcebE2/VALOrSr5PvEWMDYNsCv96esEiEEcTiwMrAvlDu/h39LmEym0uTe7+Ekv4eV3xniwU7uPp0kjnL1ii1kHPxKdyPlW2pqqv8/Mr+GYkHheO4kqUj7NshMrto3upq3KpwTF93c4k0XY5iVY7qkW5BuJ0UWkh7RCrfz1f5QWBiKG1n38yEUaav17RDJPALthASW/DXrys7xL+HPSSpd8nWRIGWbaTe8OVp ansible@webwerks-Latitude-E7240
EOF

