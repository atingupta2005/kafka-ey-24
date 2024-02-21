sudo mkdir /data/kafka
sudo chown -R atingupta2005:atingupta2005 /data/kafka

cat /usr/local/kafka/config/server.properties
rm /usr/local/kafka/config/server.properties
rm -rf server-*.properties*
wget https://raw.githubusercontent.com/atingupta2005/kafka-ey-24/main/setup-kafka/setup-kafka-zk-cluster/server-2.properties


cp server-2.properties /usr/local/kafka/config/server.properties

cat /usr/local/kafka/config/server.properties

/usr/local/kafka/bin/kafka-server-start.sh  -daemon /usr/local/kafka/config/server.properties

sleep 10

nc -vz kafka1 9092
nc -vz kafka2 9092
nc -vz kafka3 9092

tail -n 100 /usr/local/kafka/logs/server.log

