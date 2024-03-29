/usr/local/kafka/bin/kafka-server-stop.sh /usr/local/kafka/config/server.properties
sleep 1
/usr/local/kafka/bin/zookeeper-server-stop.sh /usr/local/kafka/config/zookeeper.properties
sleep 1

sudo rm -rf /usr/local/kafka/logs/zookeeper.out

sudo apt-get -y install openjdk-11-jdk

wget -nc https://downloads.apache.org/kafka/3.6.1/kafka_2.13-3.6.1.tgz
tar -zxvf kafka_2.13-3.6.1.tgz
sudo rm -rf /usr/local/kafka
ls -al
sudo mv kafka_2.13-3.6.1 /usr/local/kafka

ip addr

echo "advertised.listeners=PLAINTEXT://13.75.154.112:9092" >> /usr/local/kafka/config/server.properties

cat /usr/local/kafka/config/server.properties

/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties

sleep 2

nc -vz localhost 2181

/usr/local/kafka/bin/kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties

sleep 2

nc -vz localhost 9092

nc -vz 13.75.154.112 9092


cat /usr/local/kafka/logs/kafkaServer.out | grep 172.210

tail -f /usr/local/kafka/logs/zookeeper.out
# Press CTRL+C to exit

tail -f /usr/local/kafka/logs/kafkaServer.out
# Press CTRL+C to exit

nc -vz localhost 2181
nc -vz localhost 9092

nc -vz 13.75.154.112 2181
nc -vz 13.75.154.112 9092


/usr/local/kafka/bin/kafka-topics.sh --create --topic quickstart-events --bootstrap-server 13.75.154.112:9092

/usr/local/kafka/bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server 13.75.154.112:9092

/usr/local/kafka/bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092

#/usr/local/kafka/bin/kafka-server-stop.sh /usr/local/kafka/config/server.properties

#/usr/local/kafka/bin/zookeeper-server-stop.sh /usr/local/kafka/config/zookeeper.properties
