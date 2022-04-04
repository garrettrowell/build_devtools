$src_path = '/tmp/fonts'

vcsrepo { 'powerline fonts':
  ensure   => present,
  provider => git,
  path     => $src_path,
  source   => 'https://github.com/powerline/fonts.git',
  depth    => 1,
}

exec {
  default:
    cwd         => $src_path,
    refreshonly => true,
    subscribe   => Vcsrepo['powerline fonts'],
    path        => ['/usr/bin', '/usr/sbin', '/bin'],
  ;
  'powerline fonts install':
    command => "${src_path}/install.sh",
  ;
}
