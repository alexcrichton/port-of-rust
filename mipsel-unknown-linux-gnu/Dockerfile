FROM ubuntu:15.10

RUN apt-get -y update
RUN apt-get -y install curl file gcc
RUN apt-get -y install --no-install-recommends software-properties-common
RUN add-apt-repository ppa:angelsl/mips-cross && apt-get -y update
RUN apt-get -y install gcc-5-mipsel-linux-gnu libc6-dev-mipsel-cross

RUN ln -nsf /usr/bin/mipsel-linux-gnu-gcc-5 \
            /usr/bin/mipsel-linux-gnu-gcc

COPY support/install-rust.sh /tmp
RUN sh /tmp/install-rust.sh mipsel-unknown-linux-gnu
COPY mipsel-unknown-linux-gnu/cargo-config /.cargo/config
