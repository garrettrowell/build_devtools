#!/bin/bash

# for build environment
yum install -y gcc make ncurses ncurses-devel

# for vim functions
yum install -y ctags git tcl-devel ruby ruby-devel lua lua-devel luajit luajit-devel python python-devel perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed python3 python3-devel

# remove existing system vim if present. vim-minimal is required by sudo so leave that alone
yum remove -y vim-enhanced vim-common vim-filesystem
