FROM ubuntu:15.10

WORKDIR /build

RUN apt-get -y update
RUN apt-get -y install curl file

ENV PATH=$PATH:/android/ndk-arm/bin
ENV ANDROID_EMULATOR_FORCE_32BIT=true

RUN mkdir /android

WORKDIR /android
COPY support/android-install-ndk.sh /android/
RUN sh android-install-ndk.sh \
      --platform=android-18 \
      --toolchain=arm-linux-androideabi-4.8 \
      --install-dir=/android/ndk-arm \
      --ndk-dir=/android/android-ndk-r10e \
      --arch=arm

COPY support/install-rust.sh /android/
RUN sh install-rust.sh arm-linux-androideabi
COPY arm-linux-androideabi/cargo-config /.cargo/config

WORKDIR /
