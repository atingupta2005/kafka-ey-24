# Setup Kafka
- Open Bash terminal
- Login to Azure Portal
```
az login
az account show
az account set --subscription "efc41223-a057-4308-96c7-f166922b1e0f"
az account show
```

- Create Ubuntu VMs on Azure Portal
```
sh setup-0-ubuntu-vms.sh
```

- Install Zookeeper Single on each VM one by one
```
cd
rm -rf ~/setup-1-zookeeper-vm1.sh
wget https://raw.githubusercontent.com/atingupta2005/kafka-ey-24/main/setup/setup-1-zookeeper-vm1.sh
ls
chmod a+x ~/setup-1-zookeeper-vm1.sh
~/setup-1-zookeeper-vm1.sh
```

- Setup Zookeeper Quorum

- Setup Tools
  - Connection string: zookeeper1:2181,zookeeper2:2181,zookeeper3:2181