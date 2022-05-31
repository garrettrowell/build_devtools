#!/bin/bash

puppet_version=$(puppet --version)
gem install puppet -v $puppet_version
gem install voxpupuli-puppet-lint-plugins
