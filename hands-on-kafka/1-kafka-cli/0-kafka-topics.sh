/usr/local/kafka/kafka-topics.sh 

/usr/local/kafka/kafka-topics.sh --bootstrap-server localhost:9092 --list 

/usr/local/kafka/kafka-topics.sh --bootstrap-server localhost:9092 --topic first_topic --create

/usr/local/kafka/kafka-topics.sh --bootstrap-server localhost:9092 --topic second_topic --create --partitions 3

/usr/local/kafka/kafka-topics.sh --bootstrap-server localhost:9092 --topic third_topic --create --partitions 3 --replication-factor 2

# Create a topic (working)
/usr/local/kafka/kafka-topics.sh --bootstrap-server localhost:9092 --topic third_topic --create --partitions 3 --replication-factor 1

# List topics
/usr/local/kafka/kafka-topics.sh --bootstrap-server localhost:9092 --list 

# Describe a topic
/usr/local/kafka/kafka-topics.sh --bootstrap-server localhost:9092 --topic first_topic --describe

# Delete a topic 
/usr/local/kafka/kafka-topics.sh --bootstrap-server localhost:9092 --topic first_topic --delete
# (only works if delete.topic.enable=true)
