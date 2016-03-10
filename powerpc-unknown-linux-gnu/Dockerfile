FROM ubuntu:15.10

RUN apt-get update
RUN apt-get install -y curl file gcc gcc-powerpc-linux-gnu

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh powerpc-unknown-linux-gnu
COPY powerpc-unknown-linux-gnu/cargo-config /.cargo/config
