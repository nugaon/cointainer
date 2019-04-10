FROM debian:stable-slim

RUN apt-get update -y \
  && apt-get install -y curl gnupg unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && set -ex 
  
ARG BITCOIN_ABC_VERSION=0.19.2
ENV BITCOIN_DATA=/home/cointainer/.bitcoin
ENV PATH=/opt/bitcoin-abc-${BITCOIN_ABC_VERSION}/bin:$PATH

RUN curl -SLO https://download.bitcoinabc.org/${BITCOIN_ABC_VERSION}/linux/bitcoin-abc-${BITCOIN_ABC_VERSION}-x86_64-linux-gnu.tar.gz \
  && tar -xzf *.tar.gz -C /opt \
  && rm *.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh
RUN  chmod +x /entrypoint.sh

RUN groupadd -g 999 cointainer && \
    useradd -r -u 999 -g cointainer cointainer

RUN mkdir -p ${BITCOIN_DATA}
RUN chown cointainer ${BITCOIN_DATA}
USER cointainer


EXPOSE 8332 8333 18332 18333 18444

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bitcoind"]
