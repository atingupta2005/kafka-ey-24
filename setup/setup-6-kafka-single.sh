#!/bin/bash

# Add file limits configs - allow to open 100,000 file descriptors
echo "* hard nofile 100000
* soft nofile 100000" | sudo tee --append /etc/security/limits.conf

# reboot for the file limit to be taken into account
sudo reboot
sudo service zookeeper start
ls /data
sudo mkdir -p /data/kafka
sudo chown -R atingupta2005:atingupta2005 /data/kafka

# edit kafka configuration
cat /usr/local/kafka/config/server.properties
sudo rm /usr/local/kafka/config/server.properties
sudo nano /usr/local/kafka/config/server.properties

# launch kafka
sudo /usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties

# Install Kafka boot scripts
sudo nano /etc/init.d/kafka
sudo chmod +x /etc/init.d/kafka
sudo chown root:root /etc/init.d/kafka
# you can safely ignore the warning
sudo update-rc.d kafka defaults

# start kafka
sudo service kafka start
sudo service kafka status
# verify it's working
nc -vz localhost 9092
# look at the server logs
tail -f /usr/local/kafka/logs/server.log


# create a topic
/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server kafka1:9092 --create --topic first_topic --replication-factor 1 --partitions 3
# produce data to the topic
/usr/local/kafka/bin/kafka-console-producer.sh --broker-list kafka1:9092 --topic first_topic
hi
hello
(exit)
# read that data
/usr/local/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka1:9092 --topic first_topic --from-beginning
# list kafka topics
/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server kafka1:9092 --list
