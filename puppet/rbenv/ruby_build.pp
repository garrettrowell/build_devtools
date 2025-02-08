$install_for = 'vagrant'
$rbenv_root = "/home/${install_for}/.rbenv"
$install_path = "${rbenv_root}/plugins/ruby-build"

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
  tag    => ['ruby-build_dep'],
  before => Vcsrepo['ruby-build src']
}

vcsrepo { 'ruby-build src':
  ensure   => present,
  provider => git,
  path     => $install_path,
  source   => 'https://github.com/rbenv/ruby-build.git',
  user     => $install_for,
}

$puppet_ruby = $facts['ruby']['version']
exec {
  default:
    path        => ["/home/${install_for}/.rbenv/shims", "/home/${install_for}/.rbenv/bin", '/usr/bin', '/usr/sbin', '/bin', '/usr/local/bin'],
    user        => $install_for,
    logoutput   => true,
    environment => ["RBENV_ROOT=${rbenv_root}"],
  ;
  "rbenv install ${puppet_ruby}":
    command => "rbenv install ${puppet_ruby} --skip-existing",
    timeout => 0,
    require => Vcsrepo['ruby-build src'],
  ;
  "rbenv global ${puppet_ruby}":
    subscribe => Exec["rbenv install ${puppet_ruby}"],
  ;
}
