FROM openjdk:8-jre-alpine
WORKDIR /home/alpine
RUN apk update && apk add wget
RUN wget -O amq.tar.gz http://apachemirror.wuchna.com/activemq/activemq-artemis/2.16.0/apache-artemis-2.16.0-bin.tar.gz && tar -xvf amq.tar.gz
EXPOSE 8161 61616 5672 61613 1833 61610 9876 5445 10000 9404
RUN apache-artemis-2.16.0/bin/artemis create veloe-broker \
    --user admin \
    --password admin \
    --role amq \
    --require-login \
    #--allow-anonymous \
    --clustered \ 
    --host '${ipv4addr:localhost}' \
    --cluster-user veloe-cluster \
    --cluster-password admin \
    --relax-jolokia
COPY bootstrap.xml veloe-broker/etc     
#COPY jolokia-access.xml veloe-broker/etc
COPY broker.xml veloe-broker/etc
COPY test-jgroups-file_ping.xml veloe-broker/etc
COPY start.sh .
RUN sed -i "s/INFO/TRACE/" veloe-broker/etc/logging.properties
RUN chmod +x start.sh
CMD ["./start.sh"]