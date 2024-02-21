sudo apt-get update
sudo apt-get -y install wget ca-certificates zip net-tools vim nano tar netcat tree

# Java Open JDK 11
sudo apt-get -y install openjdk-11-jdk
java -version

# Add hosts entries (mocking DNS) - put relevant IPs here
cat /etc/hosts
ip addr
echo "10.0.0.4 kafka1
10.0.0.4 zookeeper1
10.0.0.5 kafka2
10.0.0.5 zookeeper2
10.0.0.6 kafka3
10.0.0.6 zookeeper3" | sudo tee --append /etc/hosts

cat /etc/hosts

# download Zookeeper and Kafka. Recommended is latest Kafka (0.10.2.1) and Scala 2.12
ls /usr/local/kafka
cd
wget https://downloads.apache.org/kafka/3.6.1/kafka_2.13-3.6.1.tgz
tar -xvzf kafka_2.13-3.6.1.tgz
rm kafka_2.13-3.6.1.tgz
sudo rm -rf /usr/local/kafka
sudo mv kafka_2.13-3.6.1 /usr/local/kafka
cd /usr/local/kafka

tree /data/
sudo rm -rf /data
sudo rm -rf /usr/local/kafka/logs/zookeeper.out
sudo mkdir -p /data/zookeeper
sudo chown -R atingupta2005:atingupta2005 /data/
