Vagrant.configure("2") do |config|

  # Super Awesome Alienware Laptop can't run 64-bit VMs
  config.vm.box = "raring32"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box"
  config.ssh.forward_agent = true

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  
  config.vm.provision :shell, inline: <<SCRIPT
    apt-get install -y ruby-dev sqlite3 libsqlite3-dev
    REALLY_GEM_UPDATE_SYSTEM=1 gem update --system
    gem install bundler --no-rdoc --no-ri
    cd /vagrant && sudo -u vagrant bundle install
SCRIPT
  
end
