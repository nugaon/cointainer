FROM alpine:latest

MAINTAINER Viktor Levente Tóth <toth.viktor.levente@gmail.com>

RUN apk update && apk add --no-cache git pkgconf protobuf protobuf-dev libressl-dev wget cmake alpine-sdk linux-headers

RUN mkdir /ripple && cd /ripple && wget https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.gz && \
	 tar xvzf boost_1_67_0.tar.gz && cd boost_1_67_0 && ./bootstrap.sh && ./b2 -j 4

ENV BOOST_ROOT=/ripple/boost_1_67_0

RUN sed -i 's~!WIFEXITED(still_active) \&\& !WIFSIGNALED(still_active)~!(WIFEXITED(still_active) \&\& WIFSIGNALED(still_active))~' ${BOOST_ROOT}/boost/process/detail/posix/is_running.hpp

RUN cd /ripple && git clone https://github.com/ripple/rippled.git && cd rippled && git checkout master && mkdir my_build

RUN cd /ripple/rippled/my_build && cmake .. && cmake --build .

ENV PATH="/ripple/rippled/my_build:${PATH}"

RUN addgroup -S cointainer && adduser -S cointainer -G cointainer
USER cointainer

RUN mkdir -p ~/ripple/database/node_db && mkdir ~/ripple/logfile && mkdir -p ~/.config/ripple

RUN cp /ripple/rippled/cfg/rippled-example.cfg ~/.config/ripple/rippled.cfg && \
	sed -i 's~^path=/var/lib/rippled/db/rocksdb~path=/home/cointainer/ripple/database/node_db~g' ~/.config/ripple/rippled.cfg && \
	sed -i 's~^/var/lib/rippled/db~/home/cointainer/ripple/database~g' ~/.config/ripple/rippled.cfg && \
	sed -i 's~^/var/log/rippled/debug.log~/ripple/debug~g' ~/.config/ripple/rippled.cfg && \
	cp /ripple/rippled/cfg/validators-example.txt ~/.config/ripple/validators.txt

EXPOSE 80 443 5005 6006 51235

VOLUME /home/cointainer/ripple/

ENTRYPOINT ["/ripple/rippled/my_build/rippled"]
