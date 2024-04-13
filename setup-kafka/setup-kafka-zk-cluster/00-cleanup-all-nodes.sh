# To clean Kafka from the VMs
#- Note: Below commands need to run on all the nodes

#- Need to run on all the VMs

/usr/local/kafka/bin/kafka-server-stop.sh /usr/local/kafka/config/server.properties
sleep 1
/usr/local/kafka/bin/zookeeper-server-stop.sh /usr/local/kafka/config/zookeeper.properties
sleep 1

sudo rm -rf /data
sudo rm -rf /usr/local/kafka
sudo rm -rf /usr/local/kafka/logs/zookeeper.out

sudo perl -pi -e "s,^10.7.0...*kafka.\n$,," /etc/hosts
sudo perl -pi -e "s,^10.7.0...*zookeeper.\n$,," /etc/hosts
cat /etc/hosts

