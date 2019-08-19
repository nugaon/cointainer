FROM ubuntu

ADD entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get install -y wget curl software-properties-common net-tools \
	&& add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" \
	&& apt-get update && apt-get install -y libicu55 \
	&& wget https://github.com/EOSIO/eos/releases/download/v1.8.1/eosio_1.8.1-1-ubuntu-18.04_amd64.deb \
	&& apt-get install -y ./eosio_1.8.1-1-ubuntu-18.04_amd64.deb

RUN groupadd -g 1999 cointainer \
    && useradd -m -r -u 1999 -g cointainer cointainer \
    && mkdir -p /home/cointainer/.eosio/data \
    && mkdir /home/cointainer/.eosio/config
USER cointainer

EXPOSE 9876 8888 8889

ENTRYPOINT ["/entrypoint.sh"]
