#!/bin/bash

#sudo yum -y install nano
    
echo -e "-- adjust SSH server\n"
cat <<EOF | sudo tee -a /etc/ssh/sshd_config
  RSAAuthentication yes
  PubkeyAuthentication yes
  
    
EOF

sudo systemctl ssh restart
sudo yum -y install mc


#cat <<EOF | sudo tee -a /home/vagrant/.ssh/authorized_keys
 #AAAAB3NzaC1yc2EAAAADAQABAAAAgQC57PjDAZawf1/rIoVW
 #3cho7mL1qqeBunfdAl3FpvtGogBR/+HGGGddguouQFJGPjjrR
 #/QthXB5RhGrGqFnWLKoEjuIgUVYO+btXu82nlrZzYHLPcqfhEFJn
 #IUi/2G0BMZY3B1aDLv/PxEEXCB90Xu2o7MclIUQV0cqOfgeChmnbw
    
#EOF