FROM bgermann/port-prebuilt-solaris:2017-11-18

RUN apt-get -y update && apt-get -y install curl gcc

ENV CARGO_HOME=/usr/local/cargo \
    RUSTUP_HOME=/usr/local/rustup \
    PATH=/usr/local/cargo/bin:$PATH

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh x86_64-sun-solaris
COPY x86_64-sun-solaris/cargo-config /.cargo/config
