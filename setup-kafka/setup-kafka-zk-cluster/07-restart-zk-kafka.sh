/usr/local/kafka/bin/kafka-server-stop.sh /usr/local/kafka/config/server.properties

sleep 5

/usr/local/kafka/bin/zookeeper-server-stop.sh /usr/local/kafka/config/zookeeper.properties

sleep 5

tail /usr/local/kafka/logs/zookeeper.out

nc -vz zookeeper1 2181
nc -vz zookeeper2 2181
nc -vz zookeeper3 2181

/usr/local/kafka/bin/zookeeper-server-start.sh  -daemon  /usr/local/kafka/config/zookeeper.properties

sleep 5

/usr/local/kafka/bin/kafka-server-start.sh  -daemon /usr/local/kafka/config/server.properties

sleep 5

tail -n 100 /usr/local/kafka/logs/server.log

nc -vz kafka1 9092
nc -vz kafka2 9092
nc -vz kafka3 9092

/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server kafka1:9092 --list



