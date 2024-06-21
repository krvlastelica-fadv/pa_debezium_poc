# PA Debezium POC

Aim of this POC is to setup local enviroment with:
    debezium connector
    zookeeper
    kafka
    oracle
    logMiner
Changes in the OracleXE Debezium.CUSTOMERS table should be push to Kafka topic.

Files in this repository are based on the files and info provided in:
https://github.com/debezium/debezium-examples.git
https://github.com/debezium/oracle-vagrant-box
https://github.com/royalihasan/dockerized-setup-kafka-connect-oracle-debezium-stack/tree/master

## Using Oracle

This assumes Oracle is running on localhost
(or is reachable there, e.g. by means of running it within a VM or Docker container with appropriate port configurations)
and set up with the configuration, users and grants described in the Debezium [Vagrant set-up](https://github.com/debezium/oracle-vagrant-box).

```shell
# Start the topology as defined in https://debezium.io/documentation/reference/stable/tutorial.html
export DEBEZIUM_VERSION=2.5
docker-compose -f docker-compose-oracle_xeinc.yaml up --build

# Insert test data
cat inventory11xe.sql | docker exec -i tutorial-oracle-1 sqlplus debezium/dbz@//localhost:1521/XE
```

The Oracle connector can be used to interact with Oracle either using the Oracle LogMiner API or the Oracle XStreams API.

### LogMiner

The connector by default will use Oracle LogMiner.
Adjust the host name of the database server in the `register-oracle-logminer.json` as per your environment.
Then register the Debezium Oracle connector:

```shell
# Start Oracle connector
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-oracle-logminer.json

# Create a test change record
echo "INSERT INTO customers VALUES (1007, 'John', 'Doe', 'john.doe@example.com');" | docker exec -i tutorial-oracle-1 sqlplus debezium/dbz@//localhost:1521/XE

# Modify other records in the database via Oracle client
docker exec -i tutorial-oracle-1 sqlplus debezium/dbz@//localhost:1521/XE

# Shut down the cluster
docker-compose -f docker-compose-oracle.yaml down
```

To check the Kafka topics and the messages, go to:
http://localhost:8080