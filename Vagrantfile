Vagrant.configure('2') do |config|
  # Networking
  config.vm.network 'public_network'

  config.vm.define 'cent7' do |cent7|
    # Box config
    cent7.vm.box = 'bento/centos-7'
    cent7.vm.hostname = 'cent7-devtools'

    # Install puppet-agent
    cent7.vm.provision 'shell', preserve_order: true, path: 'scripts/common/install_puppet_agent.sh', args: 'cent7'
    cent7.vm.provision 'shell', preserve_order: true, path: 'scripts/common/puppet_bootstrap.sh'

    # Build and install vim from source
    cent7.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/vim/install.pp'

    # Build and install git from source
    cent7.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/git.pp'

    # Powerline goodness
    cent7.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/powerline/install.pp'
    cent7.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/powerline/fonts.pp'

    cent7.vm.provision 'shell', preserve_order: true,  path: 'scripts/setup_vim.sh'
    cent7.vm.provision 'shell', preserve_order: true,  path: 'scripts/vim_plugins_nonprivileged.sh', privileged: false
    cent7.vm.provision 'shell', preserve_order: true,  path: 'scripts/setup_powerline_bash.sh'
    cent7.vm.provision 'shell', preserve_order: true,  path: 'scripts/config_powerline.sh'
  end

  config.vm.define 'ubu2004' do |ubu2004|
    # Box config
    ubu2004.vm.box = 'bento/ubuntu-20.04'
    ubu2004.vm.hostname = 'ubu2004-devtools'

    # Install puppet-agent
    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/common/install_puppet_agent.sh', args: 'ubu2004'
    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/common/puppet_bootstrap.sh'

    # Build and install vim from source
    ubu2004.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/vim/install.pp'

    # Build and install git from source
    ubu2004.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/git.pp'

    # Powerline goodness
    ubu2004.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/powerline/install.pp'
    ubu2004.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/powerline/fonts.pp'

    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/setup_vim.sh'
    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/setup_powerline_bash.sh'
    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/config_powerline.sh'
  end
end
