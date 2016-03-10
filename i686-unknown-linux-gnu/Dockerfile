FROM ubuntu:15.10

RUN apt-get -y update
RUN apt-get -y install curl file gcc-multilib

COPY support/install-rust.sh /tmp
RUN sh /tmp/install-rust.sh i686-unknown-linux-gnu
COPY i686-unknown-linux-gnu/cargo-config /.cargo/config
