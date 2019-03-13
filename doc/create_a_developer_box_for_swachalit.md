# Create a developer box for Swachalit

## Vagrantfile
Vagrant file is available in doc folder copy the file in a folder.
clone the repository in the same folder and you are good to go.

    mkdir swachalit-devmachine
    git clone https://makash@bitbucket.org/null0x00/null-automation-framework
    cp ./null-automation-framework/doc/Vagrantfile ./

Configure Database yml Config value 

    echo "development:\n\tadapter: mysql2\n\tencoding: utf8\n\treconnect: false\n\tdatabase: dev\n\tpool: 5\n\tusername: root\n\tpassword: root\n\tsocket:  /var/run/mysqld/mysqld.sock" > ./null-automation-framework/config/database.yml

Start machine

    vagrant up

After machine is booted and all configured to start server following steps

    vagrant ssh
    cd /vagrant/null-automation-framework/
    bundle exec rake db:migrate
    rails s


OR 

Follow instructions below

## Using vagrant
- Add what is vagrant here
    
### Vagarant Commands

    vagrant init trusty/64
    
    vagrant up
    
    vagrant ssh
    
    
### Remove rpcbind if running

    apt-get remove rpcbind
    

#### Installing pre req
    sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

### Install the pre-req software
- This will change to auto provisioning later

#### Install Ruby Version Manager
Installing rvm using the steps given at [https://gorails.com/setup/ubuntu/14.04](https://gorails.com/setup/ubuntu/14.04)

    sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
    
Install the keys required for rvm to be installed

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    
#### Steps to install Ruby 2.1.5

    curl -L https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc
    rvm install 2.1.5
    rvm use 2.1.5 --default
    ruby -v 
    
The last step is to tell Rubygems not to install the documentation for each package locally
    
    echo "gem: --no-ri --no-rdoc" > ~/.gemrc     
    
#### Install MySQL Server

    sudo apt-get install mysql-server mysql-client libmysqlclient-dev
    
#### Install Redis (latest stable version)

    sudo add-apt-repository ppa:chris-lea/redis-server
    sudo apt-get update
    sudo apt-get install redis-server
    
#### Install git

    sudo apt-get install git 
    
        
#### Install swachalit

    git clone https://makash@bitbucket.org/null0x00/null-automation-framework .
    cd null-automation-framework
    gem install bundler
    bundle install

#### Run Swachalit
refer README_for_sysadmin.md

