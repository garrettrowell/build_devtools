$user = 'vagrant'

$bash_file_name = '.profile'
$bash_file_path = "/home/${user}/${bash_file_name}"
file { $bash_file_path:
  ensure => file,
  owner  => $user,
  group  => $user,
}

file_line { "add to path ${bash_file_name}":
  ensure => present,
  path   => $bash_file_path,
  line   => "export PATH=\"/home/${user}/.local/bin:\$PATH\"",
  require => File[$bash_file_path],
}
