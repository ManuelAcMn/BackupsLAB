Vagrant.configure("2") do |config|

# $script = <<-'SCRIPT'
# SCRIPT

# $scriptAlways = <<-'SCRIPT'
# SCRIPT

  # config.vm.provision "todas", type: "shell" do |s|
  #    s.inline = $script
  # end

  # config.vm.provision "todas_siempre", type: "shell",
  #       run: "always" do |ts|
  #   ts.inline = $scriptAlways
  # end

  #config.vm.synced_folder "./", "/vagrant_data"

  config.vm.define "target", primary:true do |target|
	target.vm.box = "ubuntu/focal64"
	target.vm.hostname = "target"

	$scriptTarget = <<-'SCRIPT'
	   apt-get update
           apt-get install -y apache2
           debconf-set-selections <<< "postfix postfix/mailname string iespsur.org"
           debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Local only'"
           apt-get install --assume-yes postfix
           cd /vagrant
           crontab ./crontab
	SCRIPT

	target.vm.provision "target_once", type: "shell" do |fo|
	  fo.inline = $scriptTarget
	end

	target.vm.network "private_network", ip: "192.168.120.1",
		virtualbox__intnet: "lan"
  end

  #Para levantar la maquina se requiere vagrant up lan
  config.vm.define "lan", autostart:false do |lan|

        lan.vm.box = "ubuntu/focal64"
	lan.vm.hostname = "lan"

	lan.vm.network "private_network", ip: "192.168.120.2",
		virtualbox__intnet: "lan"
  end

end
