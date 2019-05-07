# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_IMAGE = "centos/7"
RAM = "512"
AM_RAM = "2024"
AM_CPU = "2"
NETWORK_WEB = "192.168.56.10"
NETWORK_DBASE = "192.168.56.1"
NETWORK = "192.168.56.5"


Vagrant.configure("2") do |config|

    # config.vm.define "dbase" do |dbase|
    #   dbase.vm.box = BOX_IMAGE
    #   dbase.vm.hostname = "web"
    #   dbase.vm.network :private_network, ip: NETWORK_DBASE
    #   dbase.vm.provider "virtualbox" do |vb|
    #     vb.memory = RAM
    #   end
    #   dbase.vm.provision "shell", path: "prov-mysql.sh", :args => ["#{dbname}","#{dbuser}","#{dbpass}"]
    # end

    config.vm.define "docker" do |docker|
      docker.vm.box = BOX_IMAGE
      docker.vm.hostname = "docker"
      docker.vm.network :private_network, ip: NETWORK
      docker.vm.provider "virtualbox" do |vb|
        vb.memory = AM_RAM
        vb.cpus = AM_CPU
      end
      #docker.vm.provision "file", source: ".vagrant/machines/web/virtualbox/private_key", destination: "~/.ssh/#{NETWORK_WEB}.pem"
      docker.vm.provision "shell", path: "start.sh"
               
      docker.vm.provision "file", source: "vars.yml", destination: "~"  
      docker.vm.provision "file", source: "maven.yml", destination: "~"     
      docker.vm.provision "file", source: "jenkins.yml", destination: "~"      
      docker.vm.provision "file", source: "jenkins_plugins.yml", destination: "~" 
      docker.vm.provision "file", source: "main.yml", destination: "~"             
        
    end
end