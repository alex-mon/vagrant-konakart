# Vagrant-KonaKart

Vagrant file to provision KonaKart on ubuntu64.

## Pre Requisites

 * [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
 * [Vagrant](https://www.vagrantup.com/downloads)
 * [Konakart Linux Installer](https://www.konakart.com/downloads/community_edition/) (Optional)

## Install process

By default, *KonaKart Comunity Edition* **Version 9.2.0.0** is downloaded and installed automatically, but you can manually override that, by downloading the installer manually and placing it in the `shared_files` folder, with the file renamed to `KonaKartInstaller` instead of whatever filename it had.

To create the machine:
1. From the command line, move into this repository directory `cd vagrant-konakart`
2. Run `vagrant up`
3. After some minutes, if everything went well, KonaKart will be up and running.

By default, the Virtual machine does **NOT** run in "headless" mode. That can easily be changed by removing from `VagrantFile` the following line:  
```ruby
vb.gui = true # Show the VM UI when starting it.
```

## Data of interest

* The User and Password of the ubuntu machine is `vagrant`
* The mysql User and Password is `konakart`
* Mysql can be accessed from outside of the VM, it's mapped to the defaut **3306** port
* Konakart web can also be accessed from the host machine `http://localhost:8780`
