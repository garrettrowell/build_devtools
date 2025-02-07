# location of src files
$src_path = '/tmp/vim'

vcsrepo { 'vim src':
  ensure   => present,
  provider => git,
  path     => $src_path,
  source   => 'https://github.com/vim/vim.git',
  user     => 'vagrant',
}

$rbenv_init = 'eval "$(/home/vagrant/.rbenv/bin/rbenv init - bash)"'

# Only build + install if src_path updates
exec {
  default:
    cwd         => $src_path,
    refreshonly => true,
    subscribe   => Vcsrepo['vim src'],
    path        => ['/home/vagrant/.rbenv/bin', '/usr/bin', '/usr/sbin', '/bin', '/usr/local/bin'],
    user        => 'vagrant',
    provider    => 'shell',
    logoutput   => true,
  ;
  'vim configure':
    command => "${rbenv_init} && ${src_path}/configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-perlinterp --enable-luainterp --enable-python3interp --with-python3-command=python3",
  ;
  'vim make':
    command => 'make',
    require => Exec['vim configure'],
  ;
  'vim make install':
    command => 'sudo make install',
    require => Exec['vim make'],
  ;
}
