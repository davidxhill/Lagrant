# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

###########################
# Database configuratiion #
###########################

# What DB server we should install?
DATABASE_TYPE = 'mysql'
DATABASE_ROOT_PASSWORD = 'root'

# Should we create a database for this app?
DATABASE_CREATE = true
DATABASE_NAME = 'lagrant'

# Set permissions to allow standard connections through SequelPro and Artisan Migration
EDIT_PERMISSIONS = true

# Should we bring the bower.js?
CREATE_BOWER = true

# Should we bring in Grunt file?
CREATE_GRUNT = true

# What is the name of environment of this VM?
LOCAL_ENV_NAME = 'dev'

# Should we set vim preferences?
SET_VIM_PREFERENCES = true

#########################
# Vagrant configuration #
#########################

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "precise64"

    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    config.vm.network "private_network", ip: "33.33.33.33"

    config.vm.network :forwarded_port, guest: 80, host: 8080

    config.vm.network :forwarded_port, guest: 3306, host: 3306

    config.vm.network :forwarded_port, guest: 35729, host: 35729

    config.vm.synced_folder "./", "/vagrant", id: "vagrant-root", :owner => "vagrant", :group => "www-data"

    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    #####################
    # Laravel mountings #
    #####################

    #laravel-specific mounts - storage
    config.vm.synced_folder "./app/storage", "/vagrant/app/storage", id: "vagrant-storage",
        :owner => "vagrant",
        :group => "www-data",
        :mount_options => ["dmode=775","fmode=664"]

    #laravel-specific mounts - public
    config.vm.synced_folder "./public", "/vagrant/public", id: "vagrant-public",
        :owner => "vagrant",
        :group => "www-data",
        :mount_options => ["dmode=775","fmode=664"]

    config.vm.provision :shell do |shell|
        shell.path = "vagrant/provision.sh"
        shell.args = LOCAL_ENV_NAME + " "  + (EDIT_PERMISSIONS  ? "true" : " _null") + " " + (CREATE_GRUNT ? "true" : " _null") + " " + (CREATE_BOWER ? "true" : " _null") +  " " + (SET_VIM_PREFERENCES ? "true" : " _null") + " " + DATABASE_TYPE + " " + DATABASE_ROOT_PASSWORD + ( DATABASE_CREATE ? (" " + DATABASE_NAME) : " _null" )
    end

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    # config.ssh.forward_agent = true

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"
end
