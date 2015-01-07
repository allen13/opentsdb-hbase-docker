FROM phusion/baseimage:0.9.15

# Install build requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    apt-get install -y curl openjdk-6-jdk gnuplot && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#Install HBase
ENV HBASE_VERSION 0.94.26

RUN mkdir -p /opt/downloads && cd /opt/downloads && curl -SsfLO "http://www.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION.tar.gz"
RUN cd /opt && tar xvfz /opt/downloads/hbase-$HBASE_VERSION.tar.gz
RUN mv /opt/hbase-$HBASE_VERSION /opt/hbase
RUN mkdir -p /data/hbase /opt/hbase/logs
ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64
ENV HBASE_HOME /opt/hbase
ENV HBASE_SERVER /opt/hbase/bin/hbase
COPY config/hbase-site.xml /opt/hbase/conf/hbase-site.xml
COPY config/zoo.cfg /opt/hbase/conf/zoo.cfg

#Install OpenTsdb
RUN cd /opt/downloads && curl -SsfLO "https://github.com/OpenTSDB/opentsdb/releases/download/v2.1.0RC1/opentsdb-2.1.0RC1_all.deb"
RUN dpkg -i /opt/downloads/opentsdb-2.1.0RC1_all.deb
RUN rm /opt/downloads/opentsdb-2.1.0RC1_all.deb

#Make opentsdb auto-create metrics
RUN echo "tsd.core.auto_create_metrics = true" >> /etc/opentsdb/opentsdb.conf

EXPOSE 4242

ADD service/. /etc/service/

CMD ["/sbin/my_init"]
