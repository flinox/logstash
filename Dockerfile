FROM debian

ARG LOGSTASH_VERSION=7.15.0

ENV username="logger"
ENV TZ=UTC

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y telnet netcat git jq nano wget

RUN groupadd -r ${username} --gid 1000
RUN useradd -ms /bin/bash -r -g ${username} ${username} --uid 1000

RUN wget https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}-linux-x86_64.tar.gz -P /tmp 
RUN wget https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}-linux-x86_64.tar.gz.sha512 -P /tmp

RUN cd /tmp && shasum -a 512 -c /tmp/logstash-${LOGSTASH_VERSION}-linux-x86_64.tar.gz.sha512 | grep OK

RUN tar -xzvf /tmp/logstash-${LOGSTASH_VERSION}-linux-x86_64.tar.gz -C /opt && rm /tmp/* -r

RUN chown ${username}:${username} -R /opt/logstash-${LOGSTASH_VERSION}

WORKDIR /app/logger
COPY ./config/ /app/logger/

RUN ln -s /opt/logstash-${LOGSTASH_VERSION}/bin/logstash /bin/logstash

# RUN /opt/logstash-${LOGSTASH_VERSION}/bin/logstash-plugin list --verbose

RUN /opt/logstash-${LOGSTASH_VERSION}/bin/logstash-plugin install logstash-integration-kafka

USER ${username}

CMD ["sh", "-c", "/app/logger/run.sh"]
