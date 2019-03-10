# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  
 
  config.vm.define "lb" do |lb|
    lb.vm.box = "centos/7"
    lb.vm.box = "apache"
    lb.vm.network "private_network", ip: "192.168.56.150"
    lb.vm.provision "shell", path: "ScenarioHAP4"
  end

  config.vm.define "db" do |db|
    db.vm.box = "centos/7"
    db.vm.box = "datab"
    db.vm.network "private_network", ip: "192.168.56.160"
    db.vm.provision "shell", path: "Scenario4RM"
  end
 
 
  

  
  
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
    # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
