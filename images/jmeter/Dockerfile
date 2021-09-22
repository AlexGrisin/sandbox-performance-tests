FROM openjdk:8-jre

ENV JMETER_VERSION 5.3
ENV JMETER_PLUGINS_MANAGER_VERSION 1.4
ENV CMDRUNNER_VERSION 2.2
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN $JMETER_HOME/bin
ENV IP 127.0.0.1
ENV RMI_PORT 1099
ENV PATH $PATH:$JMETER_BIN
ENV JAVA_MEM 512m
WORKDIR $JMETER_HOME
EXPOSE $RMI_PORT

USER root

RUN apt-get update && apt-get -s upgrade && apt-get install openssl curl -f -y && \
    wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.zip -P /tmp && \
    unzip -oq /tmp/apache-jmeter-${JMETER_VERSION}.zip -d /opt && \
    wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/${JMETER_PLUGINS_MANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar -P ${JMETER_HOME}/lib/ext && \
    wget  https://repo1.maven.org/maven2/kg/apc/cmdrunner/${CMDRUNNER_VERSION}/cmdrunner-${CMDRUNNER_VERSION}.jar -P ${JMETER_HOME}/lib && \
    wget https://repo1.maven.org/maven2/org/apache/ivy/ivy/2.4.0/ivy-2.4.0.jar -P $JMETER_HOME/lib && \
    rm -rf /var/cache/apk/* /tmp/*.zip && \
    java -cp ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller && \
    sh ${JMETER_HOME}/bin/PluginsManagerCMD.sh install jpgc-casutg,jpgc-dummy,jpgc-ffw,jpgc-fifo,jpgc-functions,jpgc-json,jpgc-perfmon,jpgc-prmctl,jpgc-tst,bzm-random-csv

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]