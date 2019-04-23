FROM debian:stable-slim

RUN apt-get update -y \
  && apt-get install -y curl gnupg gosu sudo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG LITECOIN_VERSION=0.16.3
ENV LITECOIN_DATA=/home/cointainer/.litecoin
ENV PATH=/usr/local/bin:$PATH

RUN curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz
RUN tar -xzf *.tar.gz
RUN rm *.tar.gz
RUN sudo install -m 0755 -o root -g root -t /usr/local/bin litecoin-${LITECOIN_VERSION}/bin/*

COPY  docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN groupadd -g 999 cointainer && \
    useradd -r -u 999 -g cointainer cointainer

RUN mkdir -p ${LITECOIN_DATA}
RUN chown cointainer ${LITECOIN_DATA}
USER cointainer

EXPOSE 9332 9333 19332 19333

ENTRYPOINT ["/entrypoint.sh"]

CMD ["litecoind"]