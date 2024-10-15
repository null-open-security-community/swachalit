# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 8800, host: 8800

  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"

  # config.vm.synced_folder ".", "/vagrant", disabled: false


  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  #   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  #   add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  #   apt-get update
  #   apt-get install -y docker-ce docker-compose
  #   usermod -a -G docker vagrant
      export DEBIAN_FRONTEND=noninteractive
      apt-get update
      apt-get upgrade -y
      apt-get install ruby2.7 gem 
      gem install bundler -v 2.4.21
      apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev default-libmysqlclient-dev libxml2-dev
      cd /vagrant/
      bundle config path vendor/bundle
      bundle install --jobs 4 --retry 3
      RUBYOPT=-W0 bundle exec rake db:create
      RUBYOPT=-W0 bundle exec rake db:migrate
      RUBYOPT=-W0 SECRET_KEY_BASE=Test-Run-123 bundle exec rake test

  SHELL
end
