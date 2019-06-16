kafka_zookeeper=localhost:2181
kafka_broker=localhost:9092
kafka_bin=/usr/share/kafka/bin

function kafka_topics() {
    $kafka_bin/kafka-topics.sh --zookeeper $kafka_zookeeper $@
}

function kafka_topics_list() {
    kafka_topics --list
}

function kafka_topics_create() {
    kafka_topics --create --replication-factor 1 --partitions 1 --topic $1
}

function kafka_topics_delete() {
    kafka_topics --delete --topic $1
}

function kafka_console_producer() {
    $kafka_bin/kafka-console-producer.sh --broker-list $kafka_broker --topic $1
}

function kafka_console_consumer() {
    $kafka_bin/kafka-console-consumer.sh --zookeeper $kafka_zookeeper --topic $1 --from-beginning
}
