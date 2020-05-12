# Kafka

What | Description
--- | ---
List topics | `JMX_PORT= kafka-topics.sh --zookeeper kafka-zookeeper:2181 --list`
Create topic | `JMX_PORT= kafka-topics.sh --zookeeper kafka-zookeeper:2181 --create --topic my-topic --partitions 1 --replication-factor 1`
Delete topic | `JMX_PORT= kafka-topics.sh --zookeeper kafka-zookeeper:2181 --delete --topic my-topic`             

Instead of using `--zookeper` you can also use `--bootstrap-server kafka.cluster.local:31090`