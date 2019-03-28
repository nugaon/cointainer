FROM debian:stable-slim

RUN apt-get update -y \
  && apt-get install -y curl gnupg gosu sudo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG LITECOIN_VERSION=0.16.3
ENV LITECOIN_DATA=/home/ubuntu/.litecoin
ENV PATH=/opt/litecoin-${LITECOIN_VERSION}/bin:$PATH

RUN curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz
RUN tar -xzf *.tar.gz
RUN rm *.tar.gz
RUN sudo install -m 0755 -o root -g root -t /usr/local/bin litecoin-${LITECOIN_VERSION}/bin/*

COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 9332 9333 19332 19333
#Mainnet
#JSON-RPC/REST: 9332
#P2P: 9333
#Testnet
#JSON-RPC: 19332
#P2P: 19333
#Regtest
#JSON-RPC/REST: 19332
#P2P: 19444


ENTRYPOINT ["/entrypoint.sh"]

CMD ["litecoind"]