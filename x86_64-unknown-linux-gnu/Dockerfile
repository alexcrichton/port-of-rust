FROM ubuntu:15.10

RUN apt-get -y update
RUN apt-get -y install curl file gcc

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh x86_64-unknown-linux-gnu
COPY x86_64-unknown-linux-gnu/cargo-config /.cargo/config
