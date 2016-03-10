FROM ubuntu:15.10

RUN apt-get -y update
RUN apt-get -y install curl file gcc gcc-4.8-aarch64-linux-gnu

RUN ln -nsf /usr/bin/aarch64-linux-gnu-gcc-4.8 \
            /usr/bin/aarch64-linux-gnu-gcc

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh aarch64-unknown-linux-gnu
COPY aarch64-unknown-linux-gnu/cargo-config /.cargo/config
