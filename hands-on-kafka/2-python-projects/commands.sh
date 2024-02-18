rm -rf ~/kafka-ey-24
cd ~
git clone https://github.com/atingupta2005/kafka-ey-24
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects
sudo chmod a+rwx /pyenv
deactivate
source /pyenv/bin/activate
nc -vz localhost 2181
nc -vz localhost 9092
sudo apt install httpie  -y

##----------------------------------------------------------------##
# Create Topic
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/1-python-kafka-admin-api-simple
sudo pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/hello-world
pkill uvicorn
##----------------------------------------------------------------##
# Create Topic with 'retention.ms': '360000'
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/2-python-kafka-admin-api-adv
sudo pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/hello-world
pkill uvicorn
##----------------------------------------------------------------##
# Create message when we call api using POST - /api/people
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/5-peopleservice-basic-producer
sudo pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
http POST :8587/api/people count:=5
pkill uvicorn
##----------------------------------------------------------------##
# Create message when we call api using POST - /api/people with callbacks
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/8-peopleservice-producer-python-adv
pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
http POST :8587/api/people count:=5
tail output.log
##----------------------------------------------------------------##
# Kafka consumer
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/10-peopleconsumeradv
sudo pip install -r requirements.txt

python pyconsumer.py &
http POST :8587/api/people count:=5
pkill uvicorn
##----------------------------------------------------------------##
# Produce message with AVRO serialization
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/15-avro-people-service-producer
pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587
http POST :8587/api/people count:=5
##----------------------------------------------------------------##
# Kafka consumer with AVRO de-serialization
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/16-avro-people-service-consumer
sudo pip install -r requirements.txt

python pyconsumer.py
##----------------------------------------------------------------##
# Kafka producer and consumer with AVRO and schema evolution
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/17-avro-people-service-schema-evolution
sudo pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/api/people
python pyconsumer.py

pkill uvicorn
##----------------------------------------------------------------##
