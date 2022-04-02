#!/bin/bash

# setup
cd /tmp
git clone https://github.com/git/git.git
cd git
make configure

# configuration
./configure

# build
make all
make install

# cleanup
cd /tmp
rm -rf git
