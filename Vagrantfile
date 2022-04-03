Vagrant.configure('2') do |config|
  # Box config
  config.vm.box = 'bento/centos-7'

  # Networking
  #config.vm.network "private_network", type: "dhcp"

  # Install puppet-agent
  config.vm.provision "shell", path: "scripts/install_puppet_agent.sh"

  # Build and install vim from source
  config.vm.provision "shell", path: "scripts/install_vim_src_deps.sh"
  config.vm.provision "shell", path: "scripts/install_vim_src_build.sh"

  # Build and install git from source
  config.vm.provision "shell", path: "scripts/install_git_src_deps.sh"
  config.vm.provision "shell", path: "scripts/install_git_src_build.sh"

  # Powerline goodness
  config.vm.provision "shell", path: "scripts/install_powerline.sh"
  config.vm.provision "shell", path: "scripts/install_powerline_fonts.sh"
  config.vm.provision "shell", path: "scripts/setup_vim.sh"
  config.vm.provision "shell", path: "scripts/setup_powerline_bash.sh"
  config.vm.provision "shell", path: "scripts/config_powerline.sh"

end
