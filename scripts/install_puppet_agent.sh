#!/bin/bash

# grab the repo
rpm -Uvh https://yum.puppet.com/puppet7-release-el-7.noarch.rpm

# install agent
yum install -y puppet-agent
