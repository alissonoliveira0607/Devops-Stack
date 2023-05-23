# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  #config.vm.network "public_network", ip:"192.168.100.15"
  config.vm.hostname = "Devops-lab"
  config.vm.provider :virtualbox do |v|
    # v.gui = true
    # v.memory = 3072
    v.name = "Devops-lab"  
  config.vm.provision "shell", path: "provisioner/provision.sh"
  end
end
