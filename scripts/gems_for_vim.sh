#!/bin/bash

puppet_version=$(puppet --version)
gem install puppet -v $puppet_version
gem install puppet-lint
