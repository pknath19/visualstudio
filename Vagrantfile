Vagrant.configure("2") do |config|
  config.vm.hostname = "visualstudio-berkshelf"
  config.berkshelf.enabled = true
  
  config.windows.halt_timeout = 20
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"

  config.vm.box_url = 'http://vmit07.hq.daptiv.com/vagrant/boxes/vagrant-windows2008r2.box'
  config.vm.box = 'vagrant-windows2008r2'
  config.vm.guest = :windows
  config.vm.network :forwarded_port, guest: 5985, host: 5985
  
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
  end
  
  config.vm.provider :vmware_fusion do |v, override|
    v.gui = true
    v.vmx["memsize"] = "2048"
    v.vmx["ethernet0.virtualDev"] = "vmxnet3"
    v.vmx["RemoteDisplay.vnc.enabled"] = "false"
    v.vmx["RemoteDisplay.vnc.port"] = "5900"
  end

  config.vm.provider :vmware_workstation do |v, override|
    v.gui = true
    v.vmx["memsize"] = "2048"
    v.vmx["ethernet0.virtualDev"] = "vmxnet3"
    v.vmx["RemoteDisplay.vnc.enabled"] = "false"
    v.vmx["RemoteDisplay.vnc.port"] = "5900"
  end
  
  # Install .NET 4.5 first
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :info
    chef.add_recipe 'dotnetframework'
    chef.add_recipe 'minitest-handler'
  end
  
  # Need to reboot before .NET 4.5 install finishes (requires vagrant-windows >= 1.2.3)
  config.vm.provision :shell, inline: 'Restart-Computer -Force'
  
  # Now we can finally run the VS recipe
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :info
    chef.add_recipe 'visualstudio'
    chef.add_recipe 'minitest-handler'
    chef.attempts = 4
    chef.json = {
      'visualstudio' => {
        'edition' => 'professional',
        'source' => 'http://vmit07.hq.daptiv.com/installs/cookbookresources'
      }
    }
  end
  
end
