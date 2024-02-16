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

# Add hosts entries (mocking DNS) - put relevant IPs here
echo "10.0.0.4 kafka1
10.0.0.4 zookeeper1
10.0.0.5 kafka2
10.0.0.5 zookeeper2
10.0.0.6 kafka3
10.0.0.6 zookeeper3" | sudo tee --append /etc/hosts

cat /etc/hosts

# download Zookeeper and Kafka. Recommended is latest Kafka (0.10.2.1) and Scala 2.12
wget https://downloads.apache.org/kafka/3.4.0/kafka_2.12-3.4.0.tgz
tar -xvzf kafka_2.12-3.4.0.tgz
rm kafka_2.12-3.4.0.tgz
sudo mv kafka_2.12-3.4.0 /usr/local/kafka
cd /usr/local/kafka
# Zookeeper quickstart
cat config/zookeeper.properties
/usr/local/kafka/bin/zookeeper-server-start.sh /usr/local/kafka/config/zookeeper.properties
# binding to port 2181 -> you're good. Ctrl+C to exit

# Testing Zookeeper install
# Start Zookeeper in the background
/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
/usr/local/kafka/bin/zookeeper-shell.sh localhost:2181
ls /
# demonstrate the use of a 4 letter word
echo "ruok" | nc localhost 2181 ; echo

# Stop zookeeper
/usr/local/kafka/bin/zookeeper-server-stop.sh -daemon /usr/local/kafka/config/zookeeper.properties

# Install Zookeeper boot scripts
sudo rm -rf /etc/init.d/zookeeper
sudo cp zookeeper /etc/init.d/zookeeper
sudo chmod +x /etc/init.d/zookeeper
sudo chown root:root /etc/init.d/zookeeper
# you can safely ignore the warning
sudo update-rc.d zookeeper defaults
# verify it's stopped
nc -vz localhost 2181
# start zookeeper
sudo service zookeeper start
sudo service zookeeper status
# verify it's started
sleep 10
nc -vz localhost 2181
echo "ruok" | nc localhost 2181 ; echo
# check the logs
tail -f /usr/local/kafka/logs/zookeeper.out

# Stop zookeeper
sudo service zookeeper stop
sudo service zookeeper status

# verify it's stopped
nc -vz localhost 2181

# start zookeeper
sudo service zookeeper start

# verify it's started
nc -vz localhost 2181
