#########
### DWIM
#########
def da_config(host, &_block)
  Vagrant.configure("2") do |vagrant|
    vagrant.vm.define host[:name].to_s, autostart: host[:autostart] || true do |this|
      # Attributes setup
      this.vm.box          = host[:box]
      this.vm.hostname     = host[:name]
      this.vm.boot_timeout = host[:timeout]

      # Network setup
      this.vm.network "private_network", ip: host[:ip], virtualbox__intnet: true
      this.vm.network "private_network", auto_config: false, virtualbox__intnet: true

      # Provider setup
      this.vm.provider "virtualbox" do |vb|
        vb.name = host[:name]
        vb.memory = host[:memory] || 512
        vb.cpus = host[:cpus] || 1
        # rubocop:disable Layout/ExtraSpacing
        vb.customize ["modifyvm", :id, "--vram",              host[:vram]]
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", host[:maxcpu]]
        vb.customize ["modifyvm", :id, "--audio",                  "none"]
        vb.customize ["modifyvm", :id, "--usb",                     "off"]
        vb.customize ["modifyvm", :id, "--usbehci",                 "off"]
        vb.customize ["modifyvm", :id, "--mouse",                   "ps2"]
        vb.customize ["modifyvm", :id, "--keyboard",                "ps2"]
        vb.customize ["modifyvm", :id, "--boot1",                  "disk"]
        vb.customize ["modifyvm", :id, "--boot2",                   "dvd"]
        vb.customize ["modifyvm", :id, "--boot3",                  "none"]
        vb.customize ["modifyvm", :id, "--boot4",                  "none"]
        vb.customize ["modifyvm", :id, "--description",       host[:desc]]
        # rubocop:enable Layout/ExtraSpacing
      end
    end
  end
end
