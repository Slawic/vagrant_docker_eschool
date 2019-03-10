#!/bin/bash

sudo yum -y install nano
    
echo -e "-- Create  index.html\n"
cat <<EOF | sudo tee -a /etc/ssh/sshd_config
  RSAAuthentication yes
  PubkeyAuthentication yes
  AuthorizedKeysFile      %h/.ssh/authorized_keys
    
EOF