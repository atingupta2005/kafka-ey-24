# Test health of the nodes
nc -vz zookeeper1 2181
nc -vz zookeeper2 2181
nc -vz zookeeper3 2181

nc -vz kafka1 9092
nc -vz kafka2 9092
nc -vz kafka3 9092

tail -f /usr/local/kafka/logs/zookeeper.out
# look at the server logs
tail -f -n 100 /usr/local/kafka/logs/server.log


# create a topic
/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server kafka1:19092 --create --topic first_topic --replication-factor 1 --partitions 3
/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server 52.171.55.4:9092 --create --topic first_topic --replication-factor 1 --partitions 3

# produce data to the topic
/usr/local/kafka/bin/kafka-console-producer.sh --broker-list kafka1:19092 --topic first_topic
/usr/local/kafka/bin/kafka-console-producer.sh --broker-list 52.171.55.4:9092 --topic first_topic
hi
hello
# Press CTRL+C to exit

# read that data
/usr/local/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka1:19092 --topic first_topic --from-beginning
/usr/local/kafka/bin/kafka-console-consumer.sh --bootstrap-server 52.171.55.4:9092 --topic first_topic --from-beginning

# Press CTRL+C to exit

# list kafka topics
/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server kafka1:9092 --list
/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server 52.171.55.4:9092 --list

