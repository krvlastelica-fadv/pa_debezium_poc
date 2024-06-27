ARG DEBEZIUM_VERSION
FROM quay.io/debezium/kafka:${DEBEZIUM_VERSION}

# These should point to the driver version to be used
COPY kafka-mirror/mirror-eventhub.config /kafka/config/
COPY kafka-mirror/source-mirror.config /kafka/config/
COPY kafka-mirror/tools-log4j.properties /kafka/config/

WORKDIR /kafka

#RUN bin/kafka-mirror-maker.sh --bootstrap-server localhost:9092 --consumer.config config/source-kafka.config --num.streams 1 --producer.config config/mirror-eventhub.config --whitelist=".*" 
#RUN bin/kafka-mirror-maker.sh --bootstrap-server localhost:9092 --producer.config source-mirror.config --num.streams 1 --consumer.config mirror-eventhub.config --whitelist=".*" 

USER kafka
