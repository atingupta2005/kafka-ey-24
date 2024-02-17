# documentation for the command 
/usr/local/kafka/kafka-consumer-groups.sh 

# list consumer groups
/usr/local/kafka/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --list
 
# describe one specific group
/usr/local/kafka/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group my-second-application

# describe another group
/usr/local/kafka/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group my-first-application

# start a consumer
/usr/local/kafka/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic first_topic --group my-first-application

# describe the group now
/usr/local/kafka/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group my-first-application

# describe a console consumer group (change the end number)
/usr/local/kafka/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group console-consumer-10592

# start a console consumer
/usr/local/kafka/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic first_topic --group my-first-application

# describe the group again
/usr/local/kafka/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --describe --group my-first-application