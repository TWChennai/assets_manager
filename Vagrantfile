# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'ubuntu/trusty32'
  config.vm.network 'forwarded_port', guest: 3000, host: 3000
  config.vm.network 'forwarded_port', guest: 5432, host: 5432

  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    sudo apt-add-repository -y ppa:brightbox/ruby-ng
    sudo apt-get -y update
    sudo apt-get -y --no-install-recommends install build-essential git libxml2-dev libxslt1-dev zlib1g-dev imagemagick postgresql postgresql-client ruby2.1 ruby2.1-dev libpq-dev nodejs

    sudo rm /etc/postgresql/9.3/main/pg_hba.conf
    echo "local all all trust" | sudo tee -a /etc/postgresql/9.3/main/pg_hba.conf
    echo "host all all 127.0.0.1/32 trust" | sudo tee -a /etc/postgresql/9.3/main/pg_hba.conf
    sudo service postgresql restart

    echo "gem: --no-ri --no-rdoc" | sudo tee -a /etc/gemrc
    sudo gem install bundler -v '1.6.5'

    cd /vagrant
    bundle install --jobs 4
    rake db:create db:migrate
  SCRIPT

end
