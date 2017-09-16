FROM ubuntu:16.04

RUN apt-get -y update && apt-get -y install curl gcc file

ENV PATH=$PATH:/android/ndk-arm/bin:/usr/local/cargo/bin \
    CARGO_HOME=/usr/local/cargo \
    RUSTUP_HOME=/usr/local/rustup

COPY support/android-install-ndk.sh /tmp/
RUN sh /tmp/android-install-ndk.sh \
      --platform=android-21 \
      --toolchain=arm-linux-androideabi-clang3.6 \
      --install-dir=/android/ndk-arm \
      --ndk-dir=android-ndk-r10e \
      --arch=arm

COPY support/install-rust.sh /tmp/
RUN sh /tmp/install-rust.sh arm-linux-androideabi
COPY arm-linux-androideabi/cargo-config /.cargo/config
