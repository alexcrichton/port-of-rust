FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y curl file gcc gcc-powerpc-linux-gnu

ENV CARGO_HOME=/usr/local/cargo \
    RUSTUP_HOME=/usr/local/rustup \
    PATH=/usr/local/cargo/bin:$PATH
COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh powerpc-unknown-linux-gnu
COPY powerpc-unknown-linux-gnu/cargo-config /.cargo/config
