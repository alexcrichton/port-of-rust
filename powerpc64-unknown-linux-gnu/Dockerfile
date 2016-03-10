FROM ubuntu:15.10

RUN apt-get update
RUN apt-get install -y curl file gcc gcc-powerpc-linux-gnu

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh powerpc64-unknown-linux-gnu
COPY powerpc64-unknown-linux-gnu/cargo-config /.cargo/config
