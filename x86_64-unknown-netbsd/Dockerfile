FROM alexcrichton/port-prebuilt-netbsd:2016-04-07

ENV CC_x86_64_unknown_netbsd=x86_64-unknown-netbsd-gcc \
    CXX_x86_64_unknown_netbsd=x86_64-unknown-netbsd-g++ \
    AR_x86_64_unknown_netbsd=x86_64-unknown-netbsd-ar

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh x86_64-unknown-netbsd
COPY x86_64-unknown-netbsd/cargo-config /.cargo/config
