FROM debian:stable-slim

RUN apt-get update -y \
  && apt-get install -y curl gnupg gosu \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CAPRICOIN_VERSION=1.2.0.0
ENV CAPRICOIN_DATA=/root/.Capricoin
ENV PATH=/:$PATH

RUN curl -L -SLO  https://github.com/Capricoinofficial/Capricoin/releases/download/v${CAPRICOIN_VERSION}/Capricoin-${CAPRICOIN_VERSION}-linux64.tar.gz
RUN tar -xvf *.tar.gz
RUN rm *.tar.gz


COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 22713

CMD ["Capricoind"]
