FROM alexcrichton/port-prebuilt-rumprun:2017-09-16

RUN apt-get -y update && apt-get -y install curl gcc

ENV CARGO_HOME=/usr/local/cargo \
    RUSTUP_HOME=/usr/local/rustup \
    PATH=/usr/local/cargo/bin:$PATH
COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh x86_64-rumprun-netbsd
COPY x86_64-rumprun-netbsd/cargo-config /.cargo/config
