#!/bin/bash

OUR_VIM=/usr/local/bin/vim
echo | $OUR_VIM +PluginInstall +qall &>/dev/null

