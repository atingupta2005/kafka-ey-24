# Video game leader board
```sh
rm -rf ~/kafka-ey-24
cd
git clone https://github.com/atingupta2005/kafka-ey-24/
cd ~/kafka-ey-24/hands-on-kafka/6-kafka-streaming/03
docker compose down
docker compose up -d
```

Now, to run the Kafka Streams application, simply run:

```
cd video-game-leaderboard/
chmod a+x ./gradlew
./gradlew run --info
```

# Producing Test Data
Once your application is running, you can produce some test data to see it in action. Since our video game leaderboard application reads from multiple topics (`players`, `products`, and `score-events`), we have saved example records for each topic in the `data/` directory. To produce data into each of these topics, open a new tab in your shell and run the following commands.

```sh
# log into the broker, which is where the kafka console scripts live
cd ~/kafka-ey-24/hands-on-kafka/6-kafka-streaming/03
docker compose exec kafka bash

# produce test data to players topic
kafka-console-producer \
  --bootstrap-server kafka:9092 \
  --topic players \
  --property 'parse.key=true' \
  --property 'key.separator=|' < players.json

# produce test data to products topic
kafka-console-producer \
  --bootstrap-server kafka:9092 \
  --topic products \
  --property 'parse.key=true' \
  --property 'key.separator=|' < products.json

# produce test data to score-events topic
kafka-console-producer \
  --bootstrap-server kafka:9092 \
  --topic score-events < score-events.json
```

# Query the API
This application exposes the video game leaderboard results using Kafka Streams interactive queries feature. The API is listening on port `7000`.

### Get all leaderboard entries, grouped by game (i.e. _productId_)
- Make sure that you are out of the container
```sh
sudo apt install jq -y
curl -s localhost:7000/leaderboard | jq '.'

# example output (truncated)
{
  "1": [
    {
      "playerId": 3,
      "productId": 1,
      "playerName": "Isabelle",
      "gameName": "Super Smash Bros",
      "score": 4000
    },
    ...
  ],
  "6": [
    {
      "playerId": 3,
      "productId": 6,
      "playerName": "Isabelle",
      "gameName": "Mario Kart",
      "score": 9000
    },
    ...
  ]
}
```

### Get the leaderboard for a specific game (i.e. _productId_)
```sh
curl -s localhost:7000/leaderboard/1 | jq '.'

# example output
[
  {
    "playerId": 3,
    "productId": 1,
    "playerName": "Isabelle",
    "gameName": "Super Smash Bros",
    "score": 4000
  },
  {
    "playerId": 2,
    "productId": 1,
    "playerName": "Mitch",
    "gameName": "Super Smash Bros",
    "score": 2000
  },
  {
    "playerId": 1,
    "productId": 1,
    "playerName": "Elyse",
    "gameName": "Super Smash Bros",
    "score": 1000
  }
]
```


## Cleanup
- Make sure that you are out of the container
```
cd ~/kafka-ey-24/hands-on-kafka/6-kafka-streaming/03
docker compose down
```