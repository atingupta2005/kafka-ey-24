sudo mkdir /data/kafka
sudo chown -R atingupta2005:atingupta2005 /data/kafka

cat /usr/local/kafka/config/server.properties
# edit the config
rm /usr/local/kafka/config/server.properties
# MAKE SURE TO USE ANOTHER BROKER ID
sudo nano /usr/local/kafka/config/server.properties
# launch kafka - make sure things look okay
/usr/local/kafka/bin/kafka-server-start.sh  -daemon /usr/local/kafka/config/server.properties
