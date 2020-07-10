# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "peru/ubuntu-18.04-desktop-amd64"
  config.vm.box_version = "20200707.01"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Network-specific configuration
  config.vm.hostname = "konakart-dev"


  # Port forwarding
  config.vm.network "forwarded_port", guest: 8780, host: 8780
  config.vm.network "forwarded_port", guest: 8783, host: 8783
  config.vm.network "forwarded_port", guest: 3306, host: 3306

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./shared_files", "/vagrant_data"

  # Provider-specific configuration
  config.vm.provider "virtualbox" do |vb|
      vb.gui = true # Show the VM UI when starting it.
      vb.memory = 4096
      vb.cpus = 2
  end

  # Software Provisioning
 config.vm.provision :shell, :path => "provision.sh"
end
