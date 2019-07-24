FROM ubuntu:18.04

RUN apt-get update && apt-get install -y gnupg && /bin/echo -e "deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu bionic main \ndeb-src http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu bionic main " >> /etc/apt/sources.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C70EF1F0305A1ADB9986DBD8D46F45428842CE5E

RUN apt-get update && apt-get install -y build-essential libssl1.0-dev libdb4.8-dev libdb4.8++-dev libboost-all-dev git libminiupnpc-dev libqrencode-dev

RUN git clone https://github.com/greenshilling/greenshilling.git && cd greenshilling/src \
    && make -f makefile.unix

RUN groupadd -g 999 cointainer \
    && useradd -s /bin/bash -m -u 999 -g cointainer cointainer \
    && mkdir /home/cointainer/.GSL && chown -R cointainer.cointainer /home/cointainer/.GSL

USER cointainer

ENV PATH="$PATH:/greenshilling/src"

EXPOSE 9945 9946

CMD ["GreenShillingd"]
