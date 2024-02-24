# Kafka Sink Setup:
# Download the required jar file -- https://mvnrepository.com/artifact/com.snowflake/snowflake-kafka-connector/1.5.0
cd 
wget https://repo1.maven.org/maven2/com/snowflake/snowflake-kafka-connector/1.5.0/snowflake-kafka-connector-1.5.0.jar

# Put this jar in libs folders
cp snowflake-kafka-connector-1.5.0.jar /usr/local/kafka/libs
ls -al /usr/local/kafka/libs/sn*

# Update the plugin.path in kafka connect-standalone properties.
cat /usr/local/kafka/config/connect-standalone.properties
echo "plugin.path=/usr/local/kafka/libs" >> /usr/local/kafka/config/connect-standalone.properties
cat /usr/local/kafka/config/connect-standalone.properties


# Create Private & Public key-pair:
openssl genrsa -out rsa_key.pem 2048
openssl rsa -in rsa_key.pem -pubout -out rsa_key.pub
#cat rsa_key.pem
#cat rsa_key.pub

grep -v "BEGIN PUBLIC" rsa_key.pub | grep -v "END PUBLIC"|tr -d '\r\n' > rsa_key.pub.txt
grep -v "BEGIN RSA PRIVATE KEY" rsa_key.pem | grep -v "END RSA PRIVATE KEY"|tr -d '\r\n' > rsa_key.pem.txt

cat rsa_key.pub.txt
cat rsa_key.pem.txt


# Configure the public key in Snowflake:
- Refer: snowflake-commands.txt


# Create a SF_connect.properties file with below properties in config folder --
cp SF_connect.properties /usr/local/kafka/config/


Start the Kafka Connector:
---------------------------------------------------------

#/usr/local/kafka/bin/kafka-server-start.sh  -daemon /usr/local/kafka/config/server.properties

/usr/local/kafka/bin/connect-standalone.sh /usr/local/kafka/config/connect-standalone.properties /usr/local/kafka/config/SF_connect.properties


# To unset the Public Key in Snowflake:
alter user atingupta2005 unset rsa_public_key;


Producer Code:
---------------------
from time import sleep
from json import dumps
from kafka import KafkaProducer

topic_name='demo_remote_kafka_connect'
producer = KafkaProducer(bootstrap_servers=['172.177.41.201:9092'],value_serializer=lambda x: dumps(x).encode('utf-8'))

for e in range(10000):
    data = {'number' : e}
    print(data)
    producer.send(topic_name, value=data)
    sleep(0.5)
 
Consumer Code:
--------------------
/usr/local/kafka/bin/kafka-console-consumer.sh --topic demo_remote_kafka_connect --bootstrap-server 172.177.41.201:9092

https://www.youtube.com/watch?v=4wULNXlXVwA
 - For Kafka Connect. Good example

https://www.youtube.com/watch?v=URMwPPWOrVk
https://github.com/Programming-with-Mati/ksql-connect-tutorial
 - KsqlDB but not that much good

Streams:
https://www.youtube.com/watch?v=xZn9B8A_4t0

