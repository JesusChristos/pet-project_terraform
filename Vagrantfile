# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"  
  config.vm.synced_folder "./", "/opt/"
  config.vm.provider "virtualbox" do |vb|
     vb.cpus = 1
     vb.memory = "1024"
   end

  config.vm.provision "shell", inline: <<-SHELL
    apt-add-repository ppa:ansible/ansible
    apt-get update
    apt-get install -y git ansible mc python-pip
    pip install -r /opt/requirements.txt
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install terraform -y
    terraform -install-autocomplete
  SHELL
end
