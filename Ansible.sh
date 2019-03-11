#!/bin/bash
#sudo yum -y install mc
echo -e "--install ANSIBLE\n"
sudo yum -y install ansible 

 
cat <<EOF | sudo tee -a /etc/ansible/hosts
[web]
webk ansible_host=192.168.56.170 ansible_user=vagrant ansible_ssh_private_key_file=/home/vagrant/.ssh/webk_key
webs ansible_host=192.168.56.180 ansible_user=vagrant ansible_ssh_private_key_file=/home/vagrant/.ssh/webs_key
END;
EOF 


sudo chmod 600 /home/vagrant/.ssh/webk_key
sudo chmod 600 /home/vagrant/.ssh/webs_key
#sudo chmod 600 /home/vagrant/.ssh/known_hosts
 
#nano /etc/ansible/hosts


sudo sed -i -e 's/#host_key_checking = false/host_key_checking = false/g' /etc/ansible/ansible.cfg
sudo sed -i -e 's/#inventory/inventory/g' /etc/ansible/ansible.cfg
#inventory = /etc/ansible/hosts.txt