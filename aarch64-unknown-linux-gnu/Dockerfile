FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install curl file gcc gcc-aarch64-linux-gnu

ENV CARGO_HOME=/usr/local/cargo \
    RUSTUP_HOME=/usr/local/rustup \
    PATH=/usr/local/cargo/bin:$PATH
COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh aarch64-unknown-linux-gnu
COPY aarch64-unknown-linux-gnu/cargo-config /.cargo/config
