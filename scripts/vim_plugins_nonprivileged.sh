#!/bin/bash

OUR_VIM=/usr/local/bin/vim
echo | $OUR_VIM +PluginInstall +qall &>/dev/null

# CommandT setup
eval "$(/home/vagrant/.rbenv/bin/rbenv init - bash)"
cd /home/vagrant/.vim/bundle/command-t/ruby/command-t/ext/command-t
ruby extconf.rb
make
