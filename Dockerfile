FROM java:8
MAINTAINER Alberto Grespan <alberto.grespan@full360.com>

# Export the VOLTDB_VERSION
ENV VOLTDB_VERSION 6.4
# Export the VOLTDB_DIR where voltdb files will live
ENV VOLTDB_DIR /usr/local/opt/voltdb
# Export to the PATH where all voltdb binaries
ENV PATH $PATH:$VOLTDB_DIR/$VOLTDB_VERSION/bin

# Install compilation dependencies
RUN apt-get update && \
     apt-get install --no-install-recommends -y \
       ant \
       build-essential \
       curl \
       ccache \
       cmake

WORKDIR /tmp
# Get the compressed VoltDB version from GitHub
RUN curl -L https://github.com/VoltDB/voltdb/archive/voltdb-${VOLTDB_VERSION}.tar.gz | tar zx

WORKDIR /tmp/voltdb-voltdb-${VOLTDB_VERSION}
# Compile VoltDB without mem check and set the compiler to java 7
RUN ant -Djmemcheck=NO_MEMCHECK -Dbuild.compiler=javac1.7

WORKDIR /${VOLTDB_DIR}/${VOLTDB_VERSION}
# Copy only the required files to our custom VoltDB PATH and purge every
# installed app for compilation afterwards including the downloaded voltdb and
# the apt list files because we want the smallest container possible
RUN for file in LICENSE README.md README.thirdparty bin bundles doc examples lib third_party/python tools version.txt voltdb; do \
      cp -R /tmp/voltdb-voltdb-${VOLTDB_VERSION}/${file} .; done && \
    mkdir -p third_party && \
    mv python third_party && \
    apt-get purge --auto-remove -y \
       ant \
       build-essential \
       curl \
       ccache \
       cmake && \
    apt-get clean && \
    rm -rf /tmp/voltdb-voltdb-${VOLTDB_VERSION} && \
    rm -rf /var/lib/apt/lists/* && \
    truncate -s 0 /var/log/*log

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
EXPOSE 21212 21211 8080 3021 4560 9090 5555 7181

CMD ["voltdb", "create"]
