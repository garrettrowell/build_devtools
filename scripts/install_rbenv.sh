#!/bin/bash

# install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
rbenv_bin=~/.rbenv/bin/rbenv
$rbenv_bin init

# make changes to bashrc available in current shell
source ~/.bashrc

# install ruby-build for rbenv
mkdir -p "$($rbenv_bin root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$($rbenv_bin root)"/plugins/ruby-build

# find which version of ruby the puppet agent vendors in
puppet_ruby=$(/opt/puppetlabs/puppet/bin/ruby --version | cut -d ' ' -f 2 | sed 's/p.*$//')
# install said version
$rbenv_bin install $puppet_ruby
# make it the default for all shells
$rbenv_bin global $puppet_ruby
