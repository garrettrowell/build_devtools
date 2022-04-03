Vagrant.configure('2') do |config|
  # Networking
  config.vm.network "public_network"

  config.vm.define "cent7" do |cent7|
    # Box config
    cent7.vm.box = 'bento/centos-7'

    # Install puppet-agent
    cent7.vm.provision "shell", path: "scripts/cent7/install_puppet_agent.sh"

    # Build and install vim from source
    cent7.vm.provision "shell", path: "scripts/cent7/install_vim_src_deps.sh"
    config.vm.provision "shell", path: "scripts/cent7/install_vim_src_build.sh"

    # Build and install git from source
    cent7.vm.provision "shell", path: "scripts/cent7/install_git_src_deps.sh"
    cent7.vm.provision "shell", path: "scripts/install_git_src_build.sh"

    # Powerline goodness
    cent7.vm.provision "shell", path: "scripts/cent7/install_powerline.sh"
    cent7.vm.provision "shell", path: "scripts/install_powerline_fonts.sh"
    cent7.vm.provision "shell", path: "scripts/setup_vim.sh"
    cent7.vm.provision "shell", path: "scripts/setup_powerline_bash.sh"
    cent7.vm.provision "shell", path: "scripts/config_powerline.sh"
  end

  config.vm.define "ubu2004" do |ubu2004|
    # Box config
    ubu2004.vm.box = "bento/ubuntu-20.04"

    # Install puppet-agent
    ubu2004.vm.provision "shell", preserve_order: true, path: "scripts/ubu2004/install_puppet_agent.sh"

    # Build and install vim from source
    ubu2004.vm.provision "shell", preserve_order: true, path: "scripts/ubu2004/install_vim_src_deps.sh"
    ubu2004.vm.provision "shell", preserve_order: true, path: "scripts/ubu2004/install_vim_src_build.sh"

    # Build and install git from source
    ubu2004.vm.provision "shell", preserve_order: true, path: "scripts/ubu2004/install_git_src_deps.sh"
    ubu2004.vm.provision "shell", preserve_order: true, path: "scripts/install_git_src_build.sh"

    # Powerline goodness
    ubu2004.vm.provision "shell", preserve_order: true, path: "scripts/ubu2004/install_powerline.sh"
    ubu2004.vm.provision "shell", preserve_order: true, path: "scripts/install_powerline_fonts.sh"
    ubu2004.vm.provision "shell", preserve_order: true, path: "scripts/setup_vim.sh"
    ubu2004.vm.provision "shell", preserve_order: true, path: "scripts/setup_powerline_bash.sh"
    ubu2004.vm.provision "shell", preserve_order: true, path: "scripts/config_powerline.sh"

  end

end
