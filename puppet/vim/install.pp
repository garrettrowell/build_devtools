$compile_for = 'vagrant'
$src_path = "/tmp/${compile_for}_vim"

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
# NOTE: rbenv manages ruby versions, we also build our own git
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
    'libperl-dev',
    'lua5.2',
    'liblua5.2-0',
    'liblua5.2-dev',
    'ctags',
  ],
  default       => undef,
}

package { $add_deps:
  ensure => present,
  tag    => ['vim_add_dep'],
  before => Vcsrepo['vim src'],
}

# Clone source
vcsrepo { 'vim src':
  ensure   => present,
  provider => git,
  path     => $src_path,
  source   => 'https://github.com/vim/vim.git',
  user     => $compile_for,
}

$configure_params = [
  '--with-features=huge',
  '--enable-multibyte',
  '--enable-rubyinterp',
  '--enable-perlinterp',
  '--enable-luainterp',
  '--enable-python3interp',
  '--with-python3-command=python3',
  "--prefix=/home/${compile_for}/.local"
].join(' ')

# Only compile + install if src_path updates
exec {
  default:
    cwd         => $src_path,
    refreshonly => true,
    subscribe   => Vcsrepo['vim src'],
    path        => ["/home/${compile_for}/.rbenv/shims", "/home/${compile_for}/.rbenv/bin", '/usr/bin', '/usr/sbin', '/bin', '/usr/local/bin'],
    user        => $compile_for,
    logoutput   => true,
  ;
  'vim configure':
    command => "${src_path}/configure ${configure_params}",
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
