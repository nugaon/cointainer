FROM ubuntu

ADD entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get install -y curl gpg ca-certificates tar dirmngr

RUN curl -o dogecoin.tar.gz -Lk https://github.com/dogecoin/dogecoin/releases/download/v1.14.0/dogecoin-1.14.0-x86_64-linux-gnu.tar.gz \
    && tar -xvf dogecoin.tar.gz && mv dogecoin-1.14.0 dogecoin && rm dogecoin.tar.gz

ENV PATH=/dogecoin/bin:${PATH}

RUN groupadd -g 1999 cointainer && \
    useradd -m -r -u 1999 -g cointainer cointainer
USER cointainer

EXPOSE 22555 22556 44555 44556

WORKDIR ["/dogecoin-bin/bin"]

CMD ["/entrypoint.sh"]
