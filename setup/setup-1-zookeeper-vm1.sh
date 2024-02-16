#!/bin/bash
# Packages
sudo apt-get update
sudo apt-get -y install wget ca-certificates zip net-tools vim nano tar netcat

# Java Open JDK 8
sudo apt-get -y install openjdk-11-jdk
java -version

# Disable RAM Swap - can set to 0 on certain Linux distro
sudo sysctl vm.swappiness=1
echo 'vm.swappiness=1' | sudo tee --append /etc/sysctl.conf
cat /etc/sysctl.conf

# Add hosts entries (mocking DNS) - put relevant IPs here
echo "10.0.0.4 kafka1
10.0.0.4 zookeeper1
10.0.0.5 kafka2
10.0.0.5 zookeeper2
10.0.0.6 kafka3
10.0.0.6 zookeeper3" | sudo tee --append /etc/hosts

cat /etc/hosts

# download Zookeeper and Kafka. Recommended is latest Kafka (0.10.2.1) and Scala 2.12
wget https://archive.apache.org/dist/kafka/3.4.0/kafka_2.12-3.4.0.tgz
tar -xvzf kafka_2.12-3.4.0.tgz
rm kafka_2.12-3.4.0.tgz
sudo rm -rf /usr/local/kafka
sudo mv kafka_2.12-3.4.0 /usr/local/kafka
cd /usr/local/kafka

/usr/local/kafka/bin/zookeeper-server-stop.sh /usr/local/kafka/config/zookeeper.properties
sudo rm -rf /data
ls /data/zookeeper
sudo rm -rf /usr/local/kafka/logs/zookeeper.out
sudo mkdir -p /data/zookeeper
sudo chown -R atingupta2005:atingupta2005 /data/
# declare the server's identity
echo "1" > /data/zookeeper/myid
cat /data/zookeeper/myid
# edit the zookeeper settings
cat /usr/local/kafka/config/zookeeper.properties
sudo rm -rf /usr/local/kafka/config/zookeeper.properties
wget https://raw.githubusercontent.com/atingupta2005/kafka-ey-24/main/setup/zookeeper.properties
cp zookeeper.properties /usr/local/kafka/config/zookeeper.properties

cat /usr/local/kafka/config/zookeeper.properties
/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
tail /usr/local/kafka/logs/zookeeper.out
nc -vz localhost 2181