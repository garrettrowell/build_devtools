#!/bin/bash

## Root User Setup
CONF_DIR=/root/.config/powerline
mkdir -p $CONF_DIR/colorschemes
mkdir -p $CONF_DIR/colorschemes/vim
mkdir -p $CONF_DIR/colorschemes/shell
mkdir -p $CONF_DIR/themes/shell
mkdir -p $CONF_DIR/themes/vim

cp /vagrant/files/powerline/colorschemes/devtools.json $CONF_DIR/colorschemes/devtools.json
cp /vagrant/files/powerline/colorschemes/vim/devtools.json $CONF_DIR/colorschemes/vim/devtools.json
cp /vagrant/files/powerline/colorschemes/shell/devtools.json $CONF_DIR/colorschemes/shell/devtools.json
cp /vagrant/files/powerline/themes/vim/devtools.json $CONF_DIR/themes/vim/devtools.json
cp /vagrant/files/powerline/themes/shell/devtools.json $CONF_DIR/themes/shell/devtools.json
cp /vagrant/files/powerline/config.json $CONF_DIR/config.json

# Vagrant User Setup
CONF_DIR=/home/vagrant/.config/powerline
mkdir -p $CONF_DIR/colorschemes
mkdir -p $CONF_DIR/colorschemes/vim
mkdir -p $CONF_DIR/colorschemes/shell
mkdir -p $CONF_DIR/themes/shell
mkdir -p $CONF_DIR/themes/vim

cp /vagrant/files/powerline/colorschemes/devtools.json $CONF_DIR/colorschemes/devtools.json
cp /vagrant/files/powerline/colorschemes/vim/devtools.json $CONF_DIR/colorschemes/vim/devtools.json
cp /vagrant/files/powerline/colorschemes/shell/devtools.json $CONF_DIR/colorschemes/shell/devtools.json
cp /vagrant/files/powerline/themes/vim/devtools.json $CONF_DIR/themes/vim/devtools.json
cp /vagrant/files/powerline/themes/shell/devtools.json $CONF_DIR/themes/shell/devtools.json
cp /vagrant/files/powerline/config.json $CONF_DIR/config.json
