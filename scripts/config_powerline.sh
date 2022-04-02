#!/bin/bash

CONF_DIR=/root/.config/powerline
mkdir -p $CONF_DIR/colorschemes
mkdir -p $CONF_DIR/themes/shell
mkdir -p $CONF_DIR/themes/vim

cp /vagrant/files/powerline/colorschemes/default.json $CONF_DIR/colorschemes/default.json
cp /vagrant/files/powerline/themes/vim/default.json $CONF_DIR/themes/vim/default.json
cp /vagrant/files/powerline/themes/shell/default.json $CONF_DIR/themes/shell/default.json
