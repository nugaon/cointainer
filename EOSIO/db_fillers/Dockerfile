FROM ubuntu:18.04 as builder

ARG BUILDTHREADS=10

RUN apt-get update && apt-get install -y wget gnupg \
    && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

RUN echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main" >> /etc/apt/sources.list \
    && echo "deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main" >> /etc/apt/sources.list \
    && echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" >> /etc/apt/sources.list \
    && echo "deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    autoconf2.13                \
    build-essential             \
    bzip2                       \
    cargo                       \
    clang-8                     \
    git                         \
    libgmp-dev                  \
    liblmdb-dev                 \
    libpq-dev                   \
    lld-8                       \
    lldb-8                      \
    ninja-build                 \
    nodejs                      \
    npm                         \
    pkg-config                  \
    postgresql-server-dev-all   \
    python2.7-dev               \
    python3-dev                 \
    rustc                       \
    zlib1g-dev

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-8 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-8 100

WORKDIR /root
RUN wget https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz \
    && tar xf boost_1_69_0.tar.gz
WORKDIR /root/boost_1_69_0
RUN ./bootstrap.sh \
    && ./b2 toolset=clang -j$BUILDTHREADS install

WORKDIR /root
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.5/cmake-3.14.5.tar.gz \
    && tar xf cmake-3.14.5.tar.gz
WORKDIR /root/cmake-3.14.5
RUN ./bootstrap --parallel=$BUILDTHREADS && make -j$BUILDTHREADS && make -j$BUILDTHREADS install

WORKDIR /root
RUN git clone --recursive https://github.com/EOSIO/history-tools.git \
    && mkdir /root/history-tools/build
WORKDIR /root/history-tools/build
RUN cmake -GNinja -DCMAKE_CXX_COMPILER=clang++-8 -DCMAKE_C_COMPILER=clang-8 .. \
    && bash -c "cd ../src && npm install node-fetch" && ninja

FROM ubuntu:18.04 as final

RUN apt-get update && apt-get install -y wget gnupg \
    && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
COPY --from=builder /etc/apt/sources.list /etc/apt/sources.list
COPY entrypoint.sh /entrypoint.sh

RUN mkdir /db_fillers \
    && apt-get update && apt-get install -y      autoconf2.13                \
        bzip2                       \
        cargo                       \
        clang-8                     \
        libgmp-dev                  \
        liblmdb-dev                 \
        libpq-dev                   \
        lld-8                       \
        lldb-8                      \
        nodejs                      \
        npm                         \
        pkg-config                  \
        postgresql-server-dev-all   \
        python2.7-dev               \
        python3-dev                 \
        rustc                       \
        zlib1g-dev
WORKDIR /db_fillers
ENV PATH="$PATH:/db_fillers"
COPY --from=builder /root/history-tools/build/* /db_fillers/

ENTRYPOINT ["/entrypoint.sh"]
