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
# declare the server's identity
echo "1" > /data/zookeeper/myid
echo "2" > /data/zookeeper/myid
echo "3" > /data/zookeeper/myid
cat /data/zookeeper/myid
# edit the zookeeper settings
cat /usr/local/kafka/config/zookeeper.properties
sudo rm -rf /usr/local/kafka/config/zookeeper.properties
rm -rf zookeeper.properties*
wget https://raw.githubusercontent.com/atingupta2005/kafka-ey-24/main/setup/zookeeper.properties
ls -al zoo*
cp zookeeper.properties /usr/local/kafka/config/zookeeper.properties

cat /usr/local/kafka/config/zookeeper.properties
ip addr
ping kafka1 -c 1
ping kafka2 -c 1
ping kafka3 -c 1
/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
tail -f /usr/local/kafka/logs/zookeeper.out
nc -vz localhost 2181

nc -vz zookeeper1 2181
nc -vz zookeeper2 2181
nc -vz zookeeper3 2181




## zookeeper settings
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/data/zookeeper
clientPort=2181
maxClientCnxns=0
admin.enableServer=false
server.1=zookeeper1:2888:3888
server.2=zookeeper2:2888:3888
server.3=zookeeper3:2888:3888