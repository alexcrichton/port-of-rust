FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install curl file gcc gcc-mips-linux-gnu

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh mips-unknown-linux-gnu
COPY mips-unknown-linux-gnu/cargo-config /.cargo/config
