#!/bin/bash

# install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src

cat <<EOT >> /home/vagrant/.bashrc
# rbenv
export RBENV_ROOT="\$HOME/.rbenv"
export PATH="\$RBENV_ROOT/bin:\$PATH"
if command -v rbenv 1>/dev/null 2>&1; then
    eval "\$(rbenv init -)"
fi
EOT

# make changes to bashrc available in current shell
source ~/.bashrc

# install ruby-build for rbenv
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# find which version of ruby the puppet agent vendors in
puppet_ruby=$(/opt/puppetlabs/puppet/bin/ruby --version | cut -d ' ' -f 2 | sed 's/p.*$//')
# install said version
rbenv install $puppet_ruby
# make it the default for all shells
rbenv global $puppet_ruby
