$modules = {
  'puppetlabs-stdlib'  => '8.1.0',
  'puppetlabs-vcsrepo' => '5.0.0',
}

$modules.each |String $module, String $version| {
  exec { "install ${module} - ${version}":
    command   => "puppet module install --ignore-dependencies --version ${version} ${module}",
    path      => $facts['path'],
    logoutput => true,
  }
}
