#!/usr/bin/env bash


export BASE="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export ZK_RUN=$BASE/zookeeper_3.5.8/bin
export KAFKA_BASE1=$BASE/broker1
export KAFKA_BASE2=$BASE/broker2
export KAFKA_BASE3=$BASE/broker3


echo "stop kafka brokers.."

echo "now server1"
cd $KAFKA_BASE1
bin/kafka-server-stop.sh  



echo "now server2"
cd $KAFKA_BASE2
bin/kafka-server-stop.sh

echo "now server3"
cd $KAFKA_BASE3
bin/kafka-server-stop.sh


 

echo "going to sleep for 5 seconds..."
sleep 5

echo "stop zookeeper"
cd $ZK_RUN
./zkServer.sh stop 



