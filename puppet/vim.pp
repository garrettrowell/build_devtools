# Ensure Build Dependencies are met

$build_deps = "${facts['os']['name']}${facts['os']['release']['major']}" ? {
  'CentOS7'     => [
    'gcc',
    'make',
    'ncurses',
    'ncurses-devel',
  ],
  'Ubuntu20.04' => [
    'build-essential',
    'libncurses5-dev',
  ],
  default       => undef,
}

package { $build_deps:
  ensure => present,
  tag    => ['vim_build_dep'],
  before => Vcsrepo['vim src'],
}

# Ensure additional packages for functionality present

$add_deps = "${facts['os']['name']}${facts['os']['release']['major']}" ? {
  'CentOS7'     => [
    'ctags',
    'git',
    'tcl-devel',
    'ruby',
    'ruby-devel',
    'lua',
    'lua-devel',
    'python',
    'python-devel',
    'perl',
    'perl-devel',
    'perl-ExtUtils-ParseXS',
    'perl-ExtUtils-CBuilder',
    'perl-ExtUtils-Embed',
    'python3',
    'python3-devel',
  ],
  'Ubuntu20.04' => [
    'libgtk-3-dev',
    'libatk1.0-dev',
    'libcairo2-dev',
    'libx11-dev',
    'libxpm-dev',
    'libxt-dev',
    'python3-dev',
    'ruby-dev',
    'libperl-dev',
    'lua5.2',
    'liblua5.2-0',
    'liblua5.2-dev',
    'ctags',
    'git',
  ],
  default       => undef,
}

package { $add_deps:
  ensure => present,
  tag    => ['vim_add_dep'],
  before => Vcsrepo['vim src'],
}

# Package names to remove

$pkg_remove = "${facts['os']['name']}${facts['os']['release']['major']}" ? {
  'CentOS7'     => [
    'vim-enhanced',
    'vim-common',
    'vim-filesystem',
  ],
  'Ubuntu20.04' => [
    'vim',
    'vim-runtime',
    'gvim',
    'vim-tiny',
    'vim-common',
    'vim-gui-common',
    'vim-nox',
  ],
  default       => undef,
}

package { $pkg_remove:
  ensure => absent,
  tag    => ['vim_pkg_remove'],
  before => Vcsrepo['vim src'],
}

# location of src files
$src_path = '/tmp/vim'

vcsrepo { 'vim src':
  ensure   => present,
  provider => git,
  path     => $src_path,
  source   => 'https://github.com/vim/vim.git',
}

# Only build + install if src_path updates
exec {
  default:
    cwd         => $src_path,
    refreshonly => true,
    subscribe   => Vcsrepo['vim src'],
    path        => ['/usr/bin', '/usr/sbin', '/bin'],
  ;
  'vim configure':
    command => "${src_path}/configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-perlinterp --enable-luainterp --enable-python3interp --with-python3-command=python3",
  ;
  'vim make':
    command => 'make',
    require => Exec['vim configure'],
  ;
  'vim make install':
    command => 'make install',
    require => Exec['vim make'],
  ;
}
