FROM ubuntu:15.10

RUN apt-get -y update
RUN apt-get -y install curl file gcc gcc-mingw-w64-x86-64

COPY support/install-rust.sh /tmp
RUN sh /tmp/install-rust.sh x86_64-pc-windows-gnu
COPY x86_64-pc-windows-gnu/cargo-config /.cargo/config
