FROM java:8
MAINTAINER Alberto Grespan <alberto.grespan@full360.com>

ENV VOLTDB_VERSION 6.4
ENV VOLTDB_DIR /usr/local/opt/voltdb

COPY voltdb-com-${VOLTDB_VERSION}/ $VOLTDB_DIR/$VOLTDB_VERSION/
# Add Voltdb binaries to the path
ENV PATH $PATH:$VOLTDB_DIR/$VOLTDB_VERSION/bin

# Our default VoltDB work dir
WORKDIR /usr/local/var/voltdb

# Exposed ports:
# Client Port 21212
# Admin Port 21211
# Web Interface Port (httpd) 8080
# Internal Server Port 3021
# Log Port 4560
# JMX Port 9090
# Replication Port 5555
# Zookeeper port 7181
# Client Port
EXPOSE 21212 21211 8080 3021 4560 9090 5555 7181

CMD ["voltdb", "create"]
