FROM alexcrichton/port-prebuilt-freebsd:2016-04-07

ENV CC_x86_64_unknown_freebsd=x86_64-unknown-freebsd10-gcc \
    CXX_x86_64_unknown_freebsd=x86_64-unknown-freebsd10-g++ \
    AR_x86_64_unknown_freebsd=x86_64-unknown-freebsd10-ar

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh x86_64-unknown-freebsd
COPY x86_64-unknown-freebsd/cargo-config /.cargo/config
