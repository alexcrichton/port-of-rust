FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install curl file gcc gcc-4.7-arm-linux-gnueabihf

RUN ln -nsf /usr/bin/arm-linux-gnueabihf-gcc-4.7 \
            /usr/bin/arm-linux-gnueabihf-gcc

ENV CARGO_HOME=/usr/local/cargo \
    RUSTUP_HOME=/usr/local/rustup \
    PATH=/usr/local/cargo/bin:$PATH
COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh arm-unknown-linux-gnueabihf
COPY arm-unknown-linux-gnueabihf/cargo-config /.cargo/config
