#!/bin/sh
set -e

export JVM_ARGS="-Xms${JAVA_MEM} -Xmx${JAVA_MEM} -XX:MaxMetaspaceSize=512m"
JMETER_LOG="jmeter-server.log" && touch $JMETER_LOG && tail -f $JMETER_LOG &
exec jmeter-server \
    -D "java.rmi.server.hostname=${IP}" \
    -D "client.rmi.localport=${RMI_PORT}" \
    -D "server.rmi.localport=${RMI_PORT}" \
    -D "server.rmi.ssl.disable=true"
