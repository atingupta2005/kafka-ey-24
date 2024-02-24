# Kafka Sink Setup:
- Download the required jar file

```
cd 
wget https://repo1.maven.org/maven2/com/snowflake/snowflake-kafka-connector/1.5.0/snowflake-kafka-connector-1.5.0.jar
```


## Put this jar in libs folders
```
cp snowflake-kafka-connector-1.5.0.jar /usr/local/kafka/libs
ls -al /usr/local/kafka/libs/sn*
```

## Update the plugin.path in kafka connect-standalone properties.
```
cat /usr/local/kafka/config/connect-standalone.properties
echo "plugin.path=/usr/local/kafka/libs" >> /usr/local/kafka/config/connect-standalone.properties
cat /usr/local/kafka/config/connect-standalone.properties
```

## Create Private & Public key-pair:
```
openssl genrsa -out rsa_key.pem 2048
openssl rsa -in rsa_key.pem -pubout -out rsa_key.pub
```

```
grep -v "BEGIN PUBLIC" rsa_key.pub | grep -v "END PUBLIC"|tr -d '\r\n' > rsa_key.pub.txt
grep -v "BEGIN RSA PRIVATE KEY" rsa_key.pem | grep -v "END RSA PRIVATE KEY"|tr -d '\r\n' > rsa_key.pem.txt
```

```
cat rsa_key.pub.txt
cat rsa_key.pem.txt
```

## Configure the public key in Snowflake:
- Refer: snowflake-commands.txt


## Create a SF_connect.properties file with below properties in config folder
```
cd
rm SF_connect.properties
wget --no-check-certificate --no-cache --no-cookies https://raw.githubusercontent.com/atingupta2005/kafka-ey-24/main/hands-on-kafka/4-kafka-connect/SF_connect.properties
nano SF_connect.properties
cp SF_connect.properties /usr/local/kafka/config/
cat /usr/local/kafka/config/SF_connect.properties
```

## Start the Kafka Connector:
```
/usr/local/kafka/bin/connect-standalone.sh /usr/local/kafka/config/connect-standalone.properties /usr/local/kafka/config/SF_connect.properties
```

## To unset the Public Key in Snowflake:
```
alter user atingupta2005 unset rsa_public_key;
```

