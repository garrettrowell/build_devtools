# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Vagrant.configure('2') do |config|
  # Networking
  config.vm.network 'public_network'

  # Allow choosing between puppet 7.x and 8.x
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
    ubu2004.vm.box = 'ubuntu/focal64'
    ubu2004.vm.hostname = 'ubu2004-devtools'

    ######################
    #
    # Install puppet-agent
    #
    #####################
    ubu2004.vm.provision 'Puppet Agent Installation',
                         preserve_order: true,
                         type: 'shell',
                         inline: <<-SHELL
                           wget https://apt.puppet.com/puppet#{puppet_platform}-release-focal.deb
                           sudo dpkg -i puppet#{puppet_platform}-release-focal.deb
                           sudo apt-get update
                           sudo apt-get install puppet-agent
                         SHELL

    ##########################
    #
    # Bootstrap Puppet Modules
    #
    ##########################
    ubu2004.vm.provision 'Puppet Module install',
                         preserve_order: true,
                         type: 'shell',
                         inline: 'puppet apply /vagrant/puppet/module_install.pp'

    ########################
    #
    # Vagrant User Bootstrap
    #
    ########################
    ubu2004.vm.provision 'Vagrant user bootstrap',
                         preserve_order: true,
                         type: 'shell',
                         inline: 'puppet apply /vagrant/puppet/user_bootstrap.pp'

    #####################################
    #
    # Compile and install git from source
    #
    #####################################
    ubu2004.vm.provision 'Compile + Install Git',
                         preserve_order: true,
                         type: 'shell',
                         inline: 'puppet apply /vagrant/puppet/git/install.pp'

    ################################
    #
    # Install rbenv for vagrant user
    #
    ################################
    ubu2004.vm.provision 'Install rbenv',
                         preserve_order: true,
                         type: 'shell',
                         inline: 'puppet apply /vagrant/puppet/rbenv/install.pp'

    #####################################################################
    #
    # Vagrant user builds the version of ruby shipped by the puppet agent
    #
    #####################################################################
    ubu2004.vm.provision 'rbenv/ruby-build',
                         type: 'shell',
                         preserve_order: true,
                         inline: 'puppet apply /vagrant/puppet/rbenv/ruby_build.pp'

    ############################################
    #
    # Install Gems useful for puppet development
    #
    ############################################
    ubu2004.vm.provision 'Install Puppet Development Gems',
                         preserve_order: true,
                         type: 'shell',
                         privileged: false,
                         reset: true,
                         inline: <<-SHELL
                           eval "$(~/.rbenv/bin/rbenv init - bash)"
                           puppet_version=$(puppet --version)
                           gem install puppet -v $puppet_version
                           gem install voxpupuli-puppet-lint-plugins
                           gem install bundler
                         SHELL

    #####################################
    #
    # Compile and install Vim from source
    #
    #####################################
    ubu2004.vm.provision 'Compile + Install Vim',
                         preserve_order: true,
                         type: 'shell',
                         inline: 'puppet apply /vagrant/puppet/vim/install.pp'

    ###############################
    #
    # Install + Configure Powerline
    #
    ###############################
    ubu2004.vm.provision 'Install Powerline',
                         preserve_order: true,
                         type: 'shell',
                         inline: 'puppet apply /vagrant/puppet/powerline/install.pp'
    ubu2004.vm.provision 'Install Powerline Fonts',
                         preserve_order: true,
                         type: 'shell',
                         inline: 'puppet apply /vagrant/puppet/powerline/fonts.pp'
    ubu2004.vm.provision 'Setup Powerline Bash',
                         preserve_order: true,
                         type: 'shell',
                         path: 'scripts/setup_powerline_bash.sh'
    ubu2004.vm.provision 'Configure Powerline',
                         preserve_order: true,
                         type: 'shell',
                         path: 'scripts/config_powerline.sh'

    ###############
    #
    # Configure Vim
    #
    ###############
    ubu2004.vm.provision 'Create .vimrc',
                         preserve_order: true,
                         type: 'shell',
                         path: 'scripts/setup_vim.sh'
    ubu2004.vm.provision 'Setup Vim plugins',
                         preserve_order: true,
                         type: 'shell',
                         privileged: false,
                         path: 'scripts/vim_plugins_nonprivileged.sh'

    ##################################
    #
    # Cleanup Bootstrap Puppet Modules
    #
    ##################################
    ubu2004.vm.provision 'Puppet Module uninstall',
                         preserve_order: true,
                         type: 'shell',
                         inline: 'puppet apply /vagrant/puppet/module_uninstall.pp'
  end
end
# rubocop:enable Metrics/BlockLength
