echo "3" > /data/zookeeper/myid
cat /data/zookeeper/myid

# edit the zookeeper settings
cat /usr/local/kafka/config/zookeeper.properties
sudo rm -rf /usr/local/kafka/config/zookeeper.properties
rm -rf zookeeper.properties*
wget https://raw.githubusercontent.com/atingupta2005/kafka-ey-24/main/setup-kafka/setup-kafka-zk-cluster/zookeeper.properties
ls -al zoo*
cp zookeeper.properties /usr/local/kafka/config/zookeeper.properties

cat /usr/local/kafka/config/zookeeper.properties

/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties

sleep 10

nc -vz zookeeper1 2181
nc -vz zookeeper2 2181
nc -vz zookeeper3 2181

sleep 10

tail /usr/local/kafka/logs/zookeeper.out
