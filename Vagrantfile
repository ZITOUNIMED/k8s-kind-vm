Vagrant.configure("2") do |config| 
    config.vm.box = "ubuntu/focal64"
    config.vm.network "public_network", bridge: "Intel(R) Ethernet Connection (2) I219-LM", ip: "192.168.1.40"
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "2544"
        vb.cpus = 2
    end
	
	config.vm.synced_folder "workspace", "/home/vagrant/workspace"
    config.vm.provision "shell", path: "workspace/scripts/setup-docker.sh", args: ["false"]
	config.vm.provision "shell", path: "workspace/scripts/install-kind.sh", args: ["false"]
	config.vm.provision "shell", path: "workspace/scripts/install-kubectl.sh", args: ["false"]
	config.vm.provision "shell", path: "workspace/scripts/install-helm.sh", args: ["false"]
	config.vm.provision "shell", path: "workspace/scripts/create-kind-k8s-cluster.sh", args: ["false"]
	config.vm.provision "shell", path: "workspace/scripts/config-kubectl.sh", args: ["false"]
	config.vm.provision "shell", path: "workspace/scripts/pull-prometheus.sh", args: ["false"]
    config.vm.provision "shell", path: "workspace/scripts/install-application.sh", args: ["false"]
end
