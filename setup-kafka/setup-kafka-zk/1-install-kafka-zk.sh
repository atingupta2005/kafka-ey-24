wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add - 
sudo add-apt-repository 'deb https://apt.corretto.aws stable main'
sudo apt-get update; sudo apt-get install -y java-11-amazon-corretto-jdk

wget https://downloads.apache.org/kafka/3.6.1/kafka_2.13-3.6.1.tgz
tar -zxvf kafka_2.13-3.6.1.tgz
rm kafka_2.13-3.6.1.tgz
sudo rm -rf /usr/local/kafka
ls -al
sudo mv kafka_2.13-3.6.1 /usr/local/kafka

/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties

/usr/local/kafka/bin/kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties

tail -f /usr/local/kafka/logs/zookeeper.out
tail -f /usr/local/kafka/logs/kafkaServer.out

nc -vz localhost 2181
nc -vz localhost 9092

/usr/local/kafka/bin/kafka-topics.sh --create --topic quickstart-events --bootstrap-server localhost:9092


/usr/local/kafka/bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092

/usr/local/kafka/bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092

#/usr/local/kafka/bin/kafka-server-stop.sh /usr/local/kafka/config/server.properties

#/usr/local/kafka/bin/zookeeper-server-stop.sh /usr/local/kafka/config/zookeeper.properties
