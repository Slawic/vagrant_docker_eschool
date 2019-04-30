#!/bin/bash
sudo yum -y update
sudo yum -y install mc wget
#install docker scenario from /docs.docker.com/install/linux
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum -y install docker-ce docker-ce-cli containerd.io  
sudo systemctl start docker 
sudo systemctl enable docker  
# create the docker group and add your user:
sudo groupadd docker
sudo usermod -aG docker $USER
#how to restart machines?
sudo systemctl restart docker 

#coretto JDK JRE
sudo wget https://d1f2yzg3dx5xke.cloudfront.net/java-1.8.0-amazon-corretto-devel-1.8.0_202.b08-1.amzn2.x86_64.rpm
sudo wget https://d1f2yzg3dx5xke.cloudfront.net/java-1.8.0-amazon-corretto-1.8.0_202.b08-1.amzn2.x86_64.rpm
sudo yum -y localinstall java-1.8.0-amazon-corretto*.rpm

sudo mkdir /opt/maven

    sudo wget https://apache.volia.net/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz
    sudo tar xzvf apache-maven-3.6.0-bin.tar.gz -C /opt/maven
    sudo yum -y install maven
    #setup the environment variables
    #sudo sh -c "echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-0.el7_6.x86_64/jre' >> /etc/profile.d/maven.sh"
    sudo sh -c "echo 'export M2_HOME=/opt/maven/apache-maven-3.6.0' >> /etc/profile.d/maven.sh"
    #sudo sh -c "echo 'export MAVEN_HOME=/opt/maven/apache-maven-3.6.0' >> /etc/profile.d/maven.sh"
    sudo sh -c "echo 'PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh"
    #sudo chmod +x /etc/profile.d/maven.sh
    #load the environment variables by typing
    source /etc/profile.d/maven.sh



#sudo docker build -t vagrant/8 .

#get the Nginx image
#sudo docker pull nginx