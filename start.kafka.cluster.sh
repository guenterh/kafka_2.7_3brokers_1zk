#!/usr/bin/env bash

export BASE="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export ZK_RUN=$BASE/zookeeper_3.5.8/bin
export KAFKA_BASE1=$BASE/broker1
export KAFKA_BASE2=$BASE/broker2
export KAFKA_BASE3=$BASE/broker3


cd $ZK_RUN;
echo "start zookeeper"
./zkServer.sh start

echo "sleep 5 seconds to give zookeeper enough time"
sleep 5

cd $KAFKA_BASE1
rm logs/*
echo "start kafka server1 ..."
bin/kafka-server-start.sh -daemon config/server.properties 

cd $KAFKA_BASE2
rm logs/*
echo "start kafka server2 ..."
bin/kafka-server-start.sh -daemon config/server.properties 

cd $KAFKA_BASE3
rm logs/*
echo "start kafka server3 ..."
bin/kafka-server-start.sh -daemon config/server.properties 

echo "sleep 10 seconds so kafka brokers have enough time to start"
sleep 10


echo "create test topic"
$KAFKA_BASE1/bin/kafka-topics.sh --create --zookeeper localhost:14181 --replication-factor 3 --partitions 3 --topic test2

echo "available topics:" 
$KAFKA_BASE1/bin/kafka-topics.sh --list --zookeeper localhost:14181

echo "delete test topic"
$KAFKA_BASE1/bin/kafka-topics.sh --delete --zookeeper localhost:14181  --topic test2
