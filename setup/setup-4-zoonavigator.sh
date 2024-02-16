#!/bin/bash

nano zoonavigator-docker-compose.yml
# Make sure port 8001 is opened on the instance security group

# copy the zookeeper/zoonavigator-docker-compose.yml file
# run it
docker-compose -f zoonavigator-docker-compose.yml up -d

# Connection string: zookeeper1:2181,zookeeper2:2181,zookeeper3:2181