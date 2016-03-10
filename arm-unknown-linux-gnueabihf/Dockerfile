FROM ubuntu:15.10

RUN apt-get -y update
RUN apt-get -y install curl file gcc gcc-4.7-arm-linux-gnueabihf

RUN ln -nsf /usr/bin/arm-linux-gnueabihf-gcc-4.7 \
            /usr/bin/arm-linux-gnueabihf-gcc

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh arm-unknown-linux-gnueabihf
COPY arm-unknown-linux-gnueabihf/cargo-config /.cargo/config
