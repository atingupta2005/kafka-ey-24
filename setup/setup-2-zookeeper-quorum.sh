#!/bin/bash
# create data dictionary for zookeeper

sudo service zookeeper stop
sudo service kafka stop
/usr/local/kafka/bin/zookeeper-server-stop.sh -daemon /usr/local/kafka/config/zookeeper.properties
sudo rm -rf /data
ls /data/zookeeper
sudo rm -rf /usr/local/kafka/logs/zookeeper.out
sudo mkdir -p /data/zookeeper
sudo chown -R atingupta2005:atingupta2005 /data/
# declare the server's identity
echo "1" > /data/zookeeper/myid
cat /data/zookeeper/myid
# edit the zookeeper settings
cat /usr/local/kafka/config/zookeeper.properties
sudo rm /usr/local/kafka/config/zookeeper.properties
cp zookeeper.properties /usr/local/kafka/config/zookeeper.properties
# restart the zookeeper service
sudo service zookeeper stop
sudo service zookeeper status
sleep 30
sudo service zookeeper start
sudo service zookeeper status
# observe the logs - need to do this on every machine
tail -f /usr/local/kafka/logs/zookeeper.out
nc -vz localhost 2181
nc -vz localhost 2888
nc -vz localhost 3888
echo "ruok" | nc localhost 2181 ; echo
echo "stat" | nc localhost 2181 ; echo
/usr/local/kafka/bin/zookeeper-shell.sh localhost:2181

ls /
