$install_for = 'vagrant'
$src_path = "/home/${install_for}/.rbenv"

# Clone source
vcsrepo { 'rbenv src':
  ensure   => present,
  provider => git,
  path     => $src_path,
  source   => 'https://github.com/rbenv/rbenv.git',
  user     => $install_for,
}

$bash_file_name = '.bash_profile'
$bash_file_path = "/home/${install_for}/${bash_file_name}"
file { $bash_file_path:
  ensure => file,
  owner  => $install_for,
  group  => $install_for,
}

file_line { "rbenv init ${bash_file_name}":
  ensure => present,
  path   => $bash_file_path,
  line   => 'eval "$(~/.rbenv/bin/rbenv init - bash)"',
  require => File[$bash_file_path],
}
