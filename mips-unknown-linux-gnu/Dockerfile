FROM ubuntu:15.10

RUN apt-get -y update
RUN apt-get -y install curl file gcc
RUN apt-get -y install --no-install-recommends software-properties-common
RUN add-apt-repository ppa:angelsl/mips-cross && apt-get -y update
RUN apt-get -y install gcc-5-mips-linux-gnu libc6-dev-mips-cross

RUN ln -nsf /usr/bin/mips-linux-gnu-gcc-5 \
            /usr/bin/mips-linux-gnu-gcc

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh mips-unknown-linux-gnu
COPY mips-unknown-linux-gnu/cargo-config /.cargo/config
