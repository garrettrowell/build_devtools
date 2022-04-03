#!/bin/bash

# grab the repo
wget https://apt.puppet.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt-get update

# install agent
sudo apt-get install -y puppet-agent
