Vagrant.configure('2') do |config|
  # Networking
  config.vm.network 'public_network'

  puppet_platform = ENV['PUPPET_PLATFORM'] || '8'

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

    cent7.vm.provision 'shell', preserve_order: true, path: 'scripts/setup_vim.sh'
    cent7.vm.provision 'shell', preserve_order: true, path: 'scripts/vim_plugins_nonprivileged.sh', privileged: false
    cent7.vm.provision 'shell', preserve_order: true, path: 'scripts/setup_powerline_bash.sh'
    cent7.vm.provision 'shell', preserve_order: true, path: 'scripts/config_powerline.sh'

    # Rbenv for vagrant user
    cent7.vm.provision 'shell', preserve_order: true, path: 'scripts/install_rbenv.sh', privileged: false
    cent7.vm.provision 'shell', preserve_order: true, path: 'scripts/gems_for_vim.sh', privileged: false
  end

  config.vm.define 'ubu2004' do |ubu2004|
    # Box config
    ubu2004.vm.box = 'bento/ubuntu-20.04'
    ubu2004.vm.hostname = 'ubu2004-devtools'

    ubu2004.vm.provision 'Puppet Agent', preserve_order: true, type: 'shell', privileged: false, inline: <<-SHELL
      wget https://apt.puppet.com/puppet#{puppet_platform}-release-focal.deb
      sudo dpkg -i puppet#{puppet_platform}-release-focal.deb
      sudo apt-get update
      sudo apt-get install puppet-agent
    SHELL
#    # Install puppet-agent
#    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/common/install_puppet_agent.sh', args: 'ubu2004'
    ubu2004.vm.provision 'shell', preserve_order: true, privileged: false, path: 'scripts/common/puppet_bootstrap.sh'
#
#    # Rbenv for vagrant user
#    ubu2004.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/rbenv.pp'
#    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/install_rbenv.sh', privileged: false
#    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/gems_for_vim.sh', privileged: false

    # Build and install git from source
    ubu2004.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/git.pp'

    ubu2004.vm.provision 'Rbenv setup', preserve_order: true, type: 'shell', privileged: false, inline: <<-SHELL
      git clone https://github.com/rbenv/rbenv.git ~/.rbenv
      echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
    SHELL

    ubu2004.vm.provision 'Install rbenv/ruby-build deps', type: 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/rbenv.pp'

    ubu2004.vm.provision 'Build ruby', preserve_order: true, type: 'shell', privileged: false, reset: true, inline: <<-SHELL
      eval "$(~/.rbenv/bin/rbenv init - bash)"
      git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
      puppet_ruby=$(/opt/puppetlabs/puppet/bin/ruby --version | cut -d ' ' -f 2 | sed 's/p.*$//')
      rbenv install $puppet_ruby
      rbenv global $puppet_ruby
      gem install bundler
    SHELL

    ubu2004.vm.provision 'Install dev Gems', preserve_order: true, type: 'shell', privileged: false, reset: true, inline: <<-SHELL
      eval "$(~/.rbenv/bin/rbenv init - bash)"
      puppet_version=$(puppet --version)
      gem install puppet -v $puppet_version
      gem install voxpupuli-puppet-lint-plugins
    SHELL

    # Build and install vim from source
    ubu2004.vm.provision 'compile vim', preserve_order: true, type: 'shell', privileged: false, inline: 'puppet apply /vagrant/puppet/vim/install.pp'

    # Powerline goodness
    ubu2004.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/powerline/install.pp'
    ubu2004.vm.provision 'shell', preserve_order: true, inline: 'puppet apply /vagrant/puppet/powerline/fonts.pp'

    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/setup_vim.sh'
    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/vim_plugins_nonprivileged.sh', privileged: false
    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/setup_powerline_bash.sh'
    ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/config_powerline.sh'

   # # Rbenv for vagrant user
   # ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/install_rbenv.sh', privileged: false
   # ubu2004.vm.provision 'shell', preserve_order: true, path: 'scripts/gems_for_vim.sh', privileged: false
  end
end
