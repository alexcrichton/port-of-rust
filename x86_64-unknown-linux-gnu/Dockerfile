FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install curl file gcc

ENV CARGO_HOME=/usr/local/cargo \
    RUSTUP_HOME=/usr/local/rustup \
    PATH=/usr/local/cargo/bin:$PATH
COPY support/install-rust.sh /tmp/
RUN curl https://sh.rustup.rs | sh -s -- -y --default-toolchain=nightly
COPY x86_64-unknown-linux-gnu/cargo-config /.cargo/config
