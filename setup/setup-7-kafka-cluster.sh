#!/bin/bash

# Make sure you have done the steps from 5 on all machines
# we repeat the steps from 6

# Add file limits configs - allow to open 100,000 file descriptors
echo "* hard nofile 100000
* soft nofile 100000" | sudo tee --append /etc/security/limits.conf
sudo reboot
sudo service zookeeper start
ls /data
sudo mkdir /data/kafka
sudo chown -R atingupta2005:atingupta2005 /data/kafka

cd /usr/local/kafka

cat /usr/local/kafka/config/server.properties
# edit the config
rm /usr/local/kafka/config/server.properties
# MAKE SURE TO USE ANOTHER BROKER ID
sudo nano /usr/local/kafka/config/server.properties
# launch kafka - make sure things look okay
/usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties

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
# look at the logs
tail -f /usr/local/kafka/logs/server.log
# make sure to fix the __consumer_offsets topic
/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server kafka1:9200 --partitions=1 --topic __consumer_offsets --alter

# read the topic on broker 1 by connecting to broker 2!
/usr/local/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka1:9092 --topic first_topic --from-beginning


# DO THE SAME FOR BROKER 3

# After, you should see three brokers here
/usr/local/kafka/bin/zookeeper-shell.sh localhost:2181
ls /kafka/brokers/ids

# you can also check the zoonavigator UI
  # Connection string: zookeeper1:2181,zookeeper2:2181,zookeeper3:2181