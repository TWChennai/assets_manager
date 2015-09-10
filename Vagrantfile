# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # TODO: Running an older version of ubuntu
  config.vm.box = 'ubuntu/trusty32'

  config.ssh.forward_x11 = true

  # Forward rails
  config.vm.network 'forwarded_port', guest: 3000, host: 3000
  config.vm.network 'forwarded_port', guest: 5432, host: 5432

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  else
    puts 'Run `vagrant plugin install vagrant-cachier` to reduce caffeine intake when provisioning'
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # TODO: Running older version of postgres - the default version that comes with the above version of ubuntu
  # Provision as root
  config.vm.provision :shell, privileged: true, inline: <<-SCRIPT
    echo "Installing necessary packages..."
    add-apt-repository -y ppa:brightbox/ruby-ng
    apt-get -y update
    apt-get -y install \
      build-essential git libxml2-dev libxslt1-dev \
      zlib1g-dev ruby2.2 ruby2.2-dev ruby-switch nodejs curl wget memcached \
      postgresql postgresql-contrib postgresql-client libpq-dev

    echo "Setting up postgres authentication..."
    echo 'host all all 0.0.0.0/0 trust' > /etc/postgresql/9.3/main/pg_hba.conf
    echo 'host all all 127.0.0.1/32 trust' >> /etc/postgresql/9.3/main/pg_hba.conf
    echo 'host all all ::1/0 trust' >> /etc/postgresql/9.3/main/pg_hba.conf
    echo 'local all all trust' >> /etc/postgresql/9.3/main/pg_hba.conf
    service postgresql restart

    echo "Setting up ruby..."
    echo 'gem: --no-ri --no-rdoc' > /etc/gemrc
    gem install bundler
    chown vagrant:vagrant -R /var/lib/gems
    chown vagrant:vagrant -R /usr/local/bin
  SCRIPT

  config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"

  # Provision as vagrant user
  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    echo "Installing gems..."
    cd /vagrant
    bundle install -j4
    rake db:create db:migrate db:seed
  SCRIPT
end
