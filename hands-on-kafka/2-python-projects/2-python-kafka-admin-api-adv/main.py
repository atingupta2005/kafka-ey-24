
import logging
import os

from dotenv import load_dotenv
from fastapi import FastAPI

from kafka import KafkaAdminClient
from kafka.admin import NewTopic, ConfigResource, ConfigResourceType
from kafka.errors import TopicAlreadyExistsError


logger = logging.getLogger()

load_dotenv(verbose=True)

app = FastAPI()


@app.on_event('startup')
async def startup_event():
  client = KafkaAdminClient(bootstrap_servers=os.environ['BOOTSTRAP_SERVERS'])

  topics = [
    NewTopic(name=os.environ['TOPICS_PEOPLE_BASIC_NAME'],
                  num_partitions=int(os.environ['TOPICS_PEOPLE_BASIC_PARTITIONS']),
                  replication_factor=int(os.environ['TOPICS_PEOPLE_BASIC_REPLICAS'])),
    NewTopic(name=f"{os.environ['TOPICS_PEOPLE_BASIC_NAME']}-short",
                  num_partitions=int(os.environ['TOPICS_PEOPLE_BASIC_PARTITIONS']),
                  replication_factor=int(os.environ['TOPICS_PEOPLE_BASIC_REPLICAS']),
                  topic_configs={
                    'retention.ms': '360000'
                  }),
  ]

  for topic in topics:
    try:
      client.create_topics([topic])
    except TopicAlreadyExistsError as e:
      logger.warning("Topic already exists")

  cfg_resource_update = ConfigResource(
    ConfigResourceType.TOPIC,
    os.environ['TOPICS_PEOPLE_BASIC_NAME'],
    configs={'retention.ms': '360000'}
  )
  client.alter_configs([cfg_resource_update])

  client.close()


@app.get('/hello-world')
async def hello_world():
  return {"message": "Hello World!"}


#pip install -r requirements.txt
#uvicorn main:app --reload --host 0.0.0.0 --port 8587