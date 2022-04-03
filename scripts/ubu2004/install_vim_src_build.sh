#!/bin/bash
cd /tmp
git clone https://github.com/vim/vim.git
cd vim/
./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-perlinterp --enable-luainterp --enable-python3interp --with-python3-command=python3 # --enable-pythoninterp
make
make install
cd /tmp
rm -rf vim
