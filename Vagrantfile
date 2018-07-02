Vagrant.configure("2") do |config|
	config.vm.box = "alpine/alpine64"
	config.vm.network "public_network", ip: "10.84.172.99", auto_config: true
	config.vm.synced_folder ".", "/vagrant", disabled: true
	config.vm.provider "virtualbox" do |vb|
	  vb.name = 'Alpine1'
	  vb.cpus = 1
	  vb.memory = 1024
	  #vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	  # Display the VirtualBox GUI when booting the machine
	  # vb.gui = true
	end
	config.vm.provision "shell", inline: <<-SHELL
		echo "cgroup  /sys/fs/cgroup  cgroup  defaults  0   0" >> /etc/fstab
		mount /sys/fs/cgroup
		echo http://dl-3.alpinelinux.org/alpine/v3.7/main >> /etc/apk/repositories
		echo http://dl-3.alpinelinux.org/alpine/v3.7/community >> /etc/apk/repositories
		apk update
		apk add docker
		rc-update add docker boot
		service docker start
	SHELL
end
