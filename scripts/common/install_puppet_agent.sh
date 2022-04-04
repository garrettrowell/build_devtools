#!/bin/bash

case $1 in
    'cent7')
        # grab the repo
        rpm -Uvh https://yum.puppet.com/puppet7-release-el-7.noarch.rpm
        # install agent
        yum install -y puppet-agent
        ;;
    'ubu2004')
        # grab the repo
        wget https://apt.puppet.com/puppet7-release-focal.deb
        dpkg -i puppet7-release-focal.deb
        apt-get update
        # install agent
        apt-get install -y puppet-agent
        ;;
    *)
        echo -n 'Unsupported OS'
        exit 1
        ;;
esac
