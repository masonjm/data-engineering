# README

## Basic Install Instructions

This application has been tested with Ruby 1.9.3, but should work on any newer versions.

1. Ensure you have Ruby installed
2. Clone this repository
3. Install gems using `bundle install`
4. Start the Webrick server using `bundle exec rails server`
5. Point your browser to http://localhost:3000

## Vagrant Install Instructions

If you don't have a working Ruby installation, this app is also setup to run with Vagrant.

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](http://docs.vagrantup.com/v2/installation/index.html)
2. Clone this repository
3. Run `vagrant up` to create the vagrant VM
4. Get some coffee or mow the lawn; there's a lot to download
5. Once the VM is started, run `vagrant ssh` to connect to the VM
6. Run `cd /vagrant` and `bundle exec rails server` to start Webrick
7. Point your browser to http://localhost:3000