FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install curl file gcc gcc-mingw-w64-i686

ENV CARGO_HOME=/usr/local/cargo \
    RUSTUP_HOME=/usr/local/rustup \
    PATH=/usr/local/cargo/bin:$PATH
COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh i686-pc-windows-gnu
RUN curl https://static.rust-lang.org/dist/rust-mingw-nightly-i686-pc-windows-gnu.tar.gz \
      | tar xzvf - -C /tmp
RUN /tmp/rust-mingw-nightly-i686-pc-windows-gnu/install.sh --prefix=`rustc --print sysroot`

COPY i686-pc-windows-gnu/cargo-config /.cargo/config
