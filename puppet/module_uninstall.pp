$modules = [
  'puppetlabs-stdlib',
  'puppetlabs-vcsrepo',
]

$modules.each |String $module| {
  exec { "uninstall ${module}":
    command   => "puppet module uninstall ${module}",
    path      => $facts['path'],
    logoutput => true,
  }
}
