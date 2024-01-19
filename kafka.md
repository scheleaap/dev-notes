# Kafka

What | Description
--- | ---
List topics | `JMX_PORT= kafka-topics.sh --zookeeper kafka-zookeeper:2181 --list`
Create topic | `JMX_PORT= kafka-topics.sh --zookeeper kafka-zookeeper:2181 --create --topic my-topic --partitions 1 --replication-factor 1`
Delete topic | `JMX_PORT= kafka-topics.sh --zookeeper kafka-zookeeper:2181 --delete --topic my-topic`             

Instead of using `--zookeeper` you can also use `--bootstrap-server kafka.cluster.local:31090`

Run a producer:
```
./kafka-console-producer.sh --bootstrap-server localhost:9092 --producer.config ~/tmp/kafka-client.properties --topic my-topic
```

Run a consumer:
```
./kafka-console-producer.sh --bootstrap-server localhost:9092 --producer.config /tmp/client.properties --topic my-topic
```

Contents of `client.properties`:
```
security.protocol=SASL_SSL
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
        username="user" \
        password="pass";
```
