# Ensure Build Dependencies are met

$build_deps = "${facts['os']['name']}${facts['os']['release']['major']}" ? {
  'CentOS7'     => [
    'autoconf',
    'gcc',
    'patch',
    'bzip2',
    'openssl-devel',
    'libffi-devel',
    'readline-devel',
    'zlib-devel',
    'gdbm-devel',
    'ncurses-devel',
    'tar'
  ],
  'Ubuntu20.04' => [
    'autoconf',
    'patch',
    'build-essential',
    'rustc',
    'libssl-dev',
    'libyaml-dev',
    'libreadline6-dev',
    'zlib1g-dev',
    'libgmp-dev',
    'libncurses5-dev',
    'libffi-dev',
    'libgdbm6',
    'libgdbm-dev',
    'libdb-dev',
    'uuid-dev'
  ],
  default       => undef,
}

package { $build_deps:
  ensure => present,
  #  tag    => ['git_build_dep'],
  #  before => Vcsrepo['git src'],
}
