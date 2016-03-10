FROM ubuntu:15.10

RUN apt-get -y update
RUN apt-get -y install curl file gcc

ENV PATH=$PATH:/android/ndk-arm/bin

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
