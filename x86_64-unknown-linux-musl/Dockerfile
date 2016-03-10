FROM ubuntu:15.10

RUN apt-get -y update
RUN apt-get -y install curl file gcc musl-tools

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh x86_64-unknown-linux-musl
COPY x86_64-unknown-linux-musl/cargo-config /.cargo/config
