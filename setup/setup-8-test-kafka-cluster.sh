#!/bin/bash

# we can create topics with replication-factor 3 now!
/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server zookeeper1:9200,zookeeper2:9200,zookeeper3:9200 --create --topic second_topic --replication-factor 3 --partitions 3

# we can publish data to Kafka using the bootstrap server list!
/usr/local/kafka/bin/kafka-console-producer.sh --broker-list kafka1:9092,kafka2:9092,kafka3:9092 --topic second_topic

# we can read data using any broker too!
/usr/local/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 --topic second_topic --from-beginning

# we can create topics with replication-factor 3 now!
/usr/local/kafka/bin/kafka-topics.sh --zookeeper zookeeper1:2181,zookeeper2:2181,zookeeper3:2181/kafka --create --topic third_topic --replication-factor 3 --partitions 3

# let's list topics
/usr/local/kafka/bin/kafka-topics.sh --zookeeper zookeeper1:2181,zookeeper2:2181,zookeeper3:2181/kafka --list

# publish some data
/usr/local/kafka/bin/kafka-console-producer.sh --broker-list kafka1:9092,kafka2:9092,kafka3:9092 --topic third_topic

# let's delete that topic
/usr/local/kafka/bin/kafka-topics.sh --zookeeper zookeeper1:2181,zookeeper2:2181,zookeeper3:2181/kafka --delete --topic third_topic

# it should be deleted shortly:
/usr/local/kafka/bin/kafka-topics.sh --zookeeper zookeeper1:2181,zookeeper2:2181,zookeeper3:2181/kafka --list
