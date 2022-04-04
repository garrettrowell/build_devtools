# Ensure Build Dependencies are met

$build_deps = "${facts['os']['name']}${facts['os']['release']['major']}" ? {
  'CentOS7'     => [
    'curl-devel',
    'expat-devel',
    'gettext-devel',
    'openssl-devel',
    'zlib-devel',
    'perl-CPAN',
    'perl-devel',
    'autoconf',
  ],
  'Ubuntu20.04' => [
    'libz-dev',
    'libssl-dev',
    'libcurl4-gnutls-dev',
    'libexpat1-dev',
    'gettext',
    'cmake',
    'gcc',
  ],
  default       => undef,
}

package { $build_deps:
  ensure => present,
  tag    => ['git_build_dep'],
  before => Vcsrepo['git src'],
}

# location of src files
$src_path = '/tmp/git'

vcsrepo { 'git src':
  ensure   => present,
  provider => git,
  path     => $src_path,
  source   => 'https://github.com/git/git.git',
}

# Only build + install if src_path updates
exec {
  default:
    cwd         => $src_path,
    refreshonly => true,
    subscribe   => Vcsrepo['git src'],
    path        => ['/usr/bin', '/usr/sbin', '/bin'],
  ;
  'git make configure':
    command => 'make configure',
  ;
  'git configure':
    command => "${src_path}/configure",
    require => Exec['git make configure'],
  ;
  'git make all':
    command => 'make all',
    require => Exec['git configure'],
  ;
  'git make install':
    command => 'make install',
    require => Exec['git make all'],
  ;
}
