# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "tkh-vcs01"
  config.vm.network "public_network", ip: "192.168.71.120", :mac => "080027b3b119"
  config.vm.network :forwarded_port, guest: 80, host: 58080
  config.ssh.forward_agent = true
  config.vm.network :private_network, ip: "192.168.33.10"
  #config.vm.synced_folder ".", "/etc/puppet/modules/gitlab"
  #config.vm.provision "shell", path: "install-modules"
  config.vm.provision "shell", path: "import_modules.sh"
  config.vm.synced_folder ".", "/home/vagrant"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"] #http://geekbacon.com/2013/02/26/cannot-set-more-than-1-cpu-in-vagrant/
    vb.customize ["storageattach", :id, "--storagectl", "SATAController", "--port", "1", "--device", "0", "--type", "hdd", "--medium", "../../tkh-mobi-virt-disks/vcs01-data-disk0.vmdk"]
  end

  # Centos 6
  config.vm.define "centos", autostart: false do |centosbox|
    centosbox.vm.box = "centos-6_5-x64-virtualbox_4_3-plain"
    centosbox.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"
  end
  
  # Ubuntu 12.04
  config.vm.define "ubuntu", autostart: false do |ubuntubox|
    ubuntubox.vm.box = "ubuntu-12_04-x64-virtualbox_4_2_10-plain"
    ubuntubox.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
  end

  # Ubuntu 14.04
  config.vm.define "trusty", primary: true do |trustybox|
    trustybox.vm.box = "ubuntu/trusty64"
  end
  
  # Sles 11 SP1
  config.vm.define "sles", autostart: false do |slesbox|
    slesbox.vm.box = "sles-11_sp1-x64-virtualbox_4_2_10-plain"
    slesbox.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/sles-11sp1-x64-vbox4210.box"
  end

  # Debian 7
  config.vm.define "debian", autostart: false do |debianbox|
    debianbox.vm.box = "debian-7_3-x64-virtualbox_4_3-plain"
    debianbox.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-73-x64-virtualbox-puppet.box"
  end

  config.vm.provision "puppet" do |puppet|
    #puppet.options = ["--certname gitlab_server"]
    #logging = ENV['LOGGING']
    #puppet.options << "--#{logging}" if ["verbose","debug"].include?(logging)
    puppet.module_path = ["modules"]
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "site.pp"
  end
end
