FROM tronprotocol/tron-gradle

ENV LANG="en_US.utf8"

RUN yum install -y epel-release && yum install -y net-tools python36-pip python36-devel gcc \
    && pip3 install --upgrade pip && pip install troncli \
    && mkdir /tron && cd /tron \
    && tron-cli init && tron-cli config

RUN cd / && git clone https://github.com/tronprotocol/wallet-cli.git \
    && cd wallet-cli && ./gradlew build \
    && echo -e '#!/bin/bash\ncd /wallet-cli\n./gradlew run' > /usr/local/sbin/wallet-cli \
    && chmod +x /usr/local/sbin/wallet-cli

WORKDIR /tron

EXPOSE 18888 8090 8091 50051 50061

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
