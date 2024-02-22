# Install Binaries on all VMS
#- Note: Below commands need to run on all the VMs

sudo apt-get update
sudo apt-get -y install wget ca-certificates zip net-tools vim nano tar netcat tree

# Java Open JDK 11
sudo apt-get -y install openjdk-11-jdk
java -version

# download Zookeeper and Kafka
cd
wget -nc https://downloads.apache.org/kafka/3.6.1/kafka_2.13-3.6.1.tgz
tar -xvzf kafka_2.13-3.6.1.tgz
sudo rm -rf /usr/local/kafka
sudo mv kafka_2.13-3.6.1 /usr/local/kafka
