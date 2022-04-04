# requires pip3

package { 'python3-pip':
  ensure => present,
}

# Ensure additional packages for functionality present

$pip_pkgs = ['powerline-status', 'powerline-gitstatus']

package { $pip_pkgs:
  ensure   => present,
  provider => pip3,
  require  => Package['python3-pip'],
}
