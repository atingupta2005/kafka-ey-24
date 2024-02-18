rm -rf ~/kafka-ey-24
cd ~
git clone https://github.com/atingupta2005/kafka-ey-24
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects
deactivate
source /pyenv/bin/activate
nc -vz localhost 2181
nc -vz localhost 9092

##----------------------------------------------------------------##
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/1-python-kafka-admin-api-simple
pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/hello-world
pkill uvicorn
##----------------------------------------------------------------##
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/2-python-kafka-admin-api-adv
pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/hello-world
pkill uvicorn
##----------------------------------------------------------------##
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/5-peopleservice-basic-producer
pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/hello-world
pkill uvicorn
##----------------------------------------------------------------##
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/8-peopleservice-producer-python-adv
pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/hello-world
pkill uvicorn
##----------------------------------------------------------------##
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/10-peopleconsumeradv
pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/hello-world
pkill uvicorn
##----------------------------------------------------------------##
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/15-avro-people-service-producer
pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/hello-world
pkill uvicorn
##----------------------------------------------------------------##
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/16-avro-people-service-consumer
pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/hello-world
pkill uvicorn
##----------------------------------------------------------------##
cd ~/kafka-ey-24/hands-on-kafka/2-python-projects/17-avro-people-service-schema-evolution
pip install -r requirements.txt

uvicorn main:app --reload --host 0.0.0.0 --port 8587 > output.log 2>&1 &
curl localhost:8587/hello-world
pkill uvicorn
##----------------------------------------------------------------##
