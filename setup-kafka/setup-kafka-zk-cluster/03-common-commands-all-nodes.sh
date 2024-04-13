# Install Binaries on all VMS
#- Note: Below commands need to run on all the VMs

# Add hosts entries (mocking DNS) - put relevant IPs here
cat /etc/hosts
sudo perl -pi -e "s,^10.7.0...*kafka.\n$,," /etc/hosts
sudo perl -pi -e "s,^10.7.0...*zookeeper.\n$,," /etc/hosts
ip addr
echo "10.7.0.4 kafka1
10.7.0.4 zookeeper1
10.7.0.5 kafka2
10.7.0.5 zookeeper2
10.7.0.6 kafka3
10.7.0.6 zookeeper3" | sudo tee --append /etc/hosts

cat /etc/hosts

sudo rm -rf /data
sudo rm -rf /usr/local/kafka/logs/zookeeper.out
sudo mkdir -p /data/zookeeper
sudo chown -R atingupta2005:atingupta2005 /data/
