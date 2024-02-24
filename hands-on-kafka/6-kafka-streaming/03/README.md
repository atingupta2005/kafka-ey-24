# Running Locally
```sh
docker-compose up -d
```

## dummy translation / sentiment analysis
First, if you want to see this running without setting up a service account for the translation and sentiment analysis service, you can run the following command:

```sh
./gradlew run --info
```

# Producing Test Data
We have a couple of test records saved to the `data/test.json` file, which is mounted in the `kafka` container for convenience. Feel free to modify the data in this file as you see fit. Then, run the following command to produce the test data to the source topic (`tweets`).

```sh
docker-compose exec kafka bash

kafka-console-producer \
  --bootstrap-server kafka:9092 \
  --topic tweets < test.json
```

Then, in another tab, run the following command to consume data from the sink topic (`crypto-sentiment`).
```sh
docker-compose exec schema-registry bash

$ kafka-avro-console-consumer \
 --bootstrap-server kafka:9092 \
 --topic crypto-sentiment \
 --from-beginning
 ```
 
 You should see records similar to the following appear in the sink topic.
 ```json
 {"created_at":1577933872630,"entity":"bitcoin","text":"Bitcoin has a lot of promise. I'm not too sure about #ethereum","sentiment_score":0.3444212495322003,"sentiment_magnitude":0.9464683988787772,"salience":0.9316858469669134}
{"created_at":1577933872630,"entity":"ethereum","text":"Bitcoin has a lot of promise. I'm not too sure about #ethereum","sentiment_score":0.1301464314096875,"sentiment_magnitude":0.8274198304784903,"salience":0.9112319163372604}
```

## Cleanup
```
docker-compose down
```