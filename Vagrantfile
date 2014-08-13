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

  config.vm.provider "virtualbox" do |vbox|
    host = RbConfig::CONFIG['host_os']

    cpus = 1
    mem = 768
    begin
      if host =~ /darwin/
        cpus = `sysctl -n hw.ncpu`.to_i
        mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024
      elsif host =~ /linux/
        cpus = `nproc`.to_i
        mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024
      end

      # Give VM 1/4 system memory & access to half of cpu cores on the host
      cpus = cpus / 2 if cpus > 1
      mem  = mem / 4  if mem > 2048
    rescue
      puts "Unable to detect system memory/CPU, please edit vagrant config or set VAGRANT_SAFE_MODE=true"
    end

    vbox.memory = mem
    vbox.cpus = cpus
  end unless ENV['VAGRANT_SAFE_MODE'] == 'true'

end
