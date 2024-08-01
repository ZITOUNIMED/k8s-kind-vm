Vagrant.configure("2") do |config| 
    config.vm.box = "ubuntu/focal64"
    config.vm.network "public_network", bridge: "Intel(R) Ethernet Connection (2) I219-LM"
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "2544"
        vb.cpus = 2
    end
	
	config.vm.synced_folder "workspace", "/home/vagrant/workspace"
    
end
