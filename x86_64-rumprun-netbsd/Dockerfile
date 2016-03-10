FROM alexcrichton/port-prebuilt-rumprun:2016-03-09

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh x86_64-rumprun-netbsd
COPY x86_64-rumprun-netbsd/cargo-config /.cargo/config
