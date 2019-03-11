#!/bin/bash

echo -e "--install ANSIBLE\n"
sudo yum -y install ansible python


ssh-keygen -t rsa -b 1024 -f /home/vagrant/.ssh/id_rsa
#Create new inventory 
mkdir -p ansible01/ 
#sudo chmod 500 /home/vagrant/ansible01/ 
cat <<EOF | sudo tee -a ~/ansible01/inventory.ini
  [db]
  db ansible_ssh_host=192.168.56.160 ansible_user=vagrant
  [web]
  web_k ansible_ssh_host=192.168.56.170 ansible_user=vagrant
  web_s ansible_ssh_host=192.168.56.180 ansible_user=vagrant
EOF  
 
#Create a new ansible configuration file 
sudo cat <<EOF | sudo tee -a ~/ansible01/ansible.cfg
[defaults]
host_key_checking = false
inventory = /home/vagrant/ansible01/inventory.ini
EOF 

#Create Ansible Playbook 
ssh-keyscan 192.168.56.160 >> ~/.ssh/known_hosts
ssh-keyscan 192.168.56.170 >> ~/.ssh/known_hosts
ssh-keyscan 192.168.56.180 >> ~/.ssh/known_hosts
#ssh-keyscan 192.168.56.150 >> ~/.ssh/known_hosts

#for i in $(cat list-hosts.txt)
#do
#ssh-keyscan $i >> ~/.ssh/known_hosts
#done

cat <<EOF | sudo tee -a /etc/ansible/deploy-ssh.yml
---
- hosts: all
   vars:
     - provision_password: '$6$w9S3t7x1kRtmG0u$6nVU9KZsC12Q8DYI4FtgKPy.e/cq/jseB/.DViTO1SpUnoCy.dxcOf8hyfitGq5V0yhgXccxzlqm2o.I3SlDJ0'
  gather_facts: no
   remote_user: root
 
   tasks:
 
   #- name: Add a new user named provision
    #user:
          #name=provision
          #password={{ provision_password }}
 
   #- name: Add provision user to the sudoers
     #copy:
          #dest: "/etc/sudoers.d/provision"
          #content: "provision  ALL=(ALL)  NOPASSWD: ALL"
 
   - name: Deploy SSH Key
     authorized_key: user=vagrant
                     key="{{ lookup('file', '/home/vagrant/.ssh/id_rsa.pub') }}"
                     state=present
 
   - name: Disable Password Authentication
     lineinfile:
           dest=/etc/ssh/sshd_config
           regexp='^PasswordAuthentication'
           line="PasswordAuthentication no"
           state=present
           backup=yes
     notify:
       - restart ssh
 
   - name: Disable Root Login
     lineinfile:
           dest=/etc/ssh/sshd_config
           regexp='^PermitRootLogin'
           line="PermitRootLogin no"
           state=present
           backup=yes
     notify:
       - restart ssh
 
   handlers:
   - name: restart ssh
EOF

cat <<EOF | sudo tee -a /etc/ansible/mariadb.yml
---
- hosts: 192.168.56.160
  become: yes
  become_method: su
  tasks:
  - name: install mariadb-server
    yum: pkg=mariadb state=latest
  - name: Copying the demo file
    template: src=/etc/ansible/index.html dest=/var/www/html
              owner=mariadb group=mariadb mode=0644
  - name: Enable mariadb on System Boot
    service: name=mariadb enabled=yes
    notify:
    - start mariadb
    - setup firewalld
    - reload firewalld
    handlers:
    - name: start mariadb
      service: name=mariadb state=started
    - name: setup firewalld
      firewalld:
        service: http
        permanent: true
        state: enabled
    - name: reload firewalld
      service: name=firewalld state=restarted 

EOF




 #ssh-copy-id username@remote_host






#sudo chmod 500 /home/vagrant/db/virtualbox/private_key 
#sudo chmod 500 /home/vagrant/web_k/virtualbox/private_key
#sudo chmod 500 /home/vagrant/web_s/virtualbox/private_key
#sudo chmod 500 /home/vagrant/.ssh/known_hosts
 

