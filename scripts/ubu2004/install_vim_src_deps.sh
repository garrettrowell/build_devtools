#!/bin/bash

# Remove old vim installs
sudo apt-get remove -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox gvim

# install vim-gtk deps
sudo apt-get build-dep vim-gtk

# install some more deps
sudo apt-get -y install build-essential libncurses5-dev libgtk-3-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python3-dev ruby-dev libperl-dev lua5.2 liblua5.2-0 liblua5.2-dev ctags git

## for build environment
#yum install -y gcc make ncurses ncurses-devel
#
## for vim functions
#yum install -y ctags git tcl-devel ruby ruby-devel lua lua-devel luajit luajit-devel python python-devel perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed python3 python3-devel
#
## remove existing system vim if present. vim-minimal is required by sudo so leave that alone
#yum remove -y vim-enhanced vim-common vim-filesystem
