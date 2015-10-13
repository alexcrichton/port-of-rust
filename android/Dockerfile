# This is a Dockerfile for building the image that is used to build Android
# binaries and run tests within. This will install the NDK, SDK, and set up an
# emulator to run tests in.

FROM ubuntu:latest

WORKDIR /build

# Setup PATH to allow running android tools.
ENV PATH=$PATH:/android/ndk-arm/bin
ENV PATH=$PATH:/android/ndk-aarch64/bin
ENV PATH=$PATH:/android/sdk/tools
ENV PATH=$PATH:/android/sdk/platform-tools
ENV PATH=$PATH:/rust/bin
ENV LD_LIBRARY_PATH=/rust/lib

# Install necessary packages:
RUN dpkg --add-architecture i386
RUN apt-get -y update
RUN apt-get -y install expect curl libncurses5:i386 libstdc++6:i386 zlib1g:i386 \
                       openjdk-6-jre gcc-multilib

# Prep the Android NDK
#
# See https://github.com/servo/servo/wiki/Building-for-Android
RUN curl -O http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin
RUN chmod +x android-ndk-r10e-linux-x86_64.bin
RUN ./android-ndk-r10e-linux-x86_64.bin
RUN bash android-ndk-r10e/build/tools/make-standalone-toolchain.sh \
        --platform=android-18 \
        --toolchain=arm-linux-androideabi-4.8 \
        --install-dir=/android/ndk-arm \
        --ndk-dir=/build/android-ndk-r10e \
        --arch=arm
RUN bash android-ndk-r10e/build/tools/make-standalone-toolchain.sh \
        --platform=android-21 \
        --toolchain=aarch64-linux-android-4.9 \
        --install-dir=/android/ndk-aarch64 \
        --ndk-dir=/build/android-ndk-r10e \
        --arch=arm64

# Prep the SDK and emulator
#
# Note that the update process requires that we accept a bunch of licenses, and
# we can't just pipe `yes` into it for some reason, so we take the same strategy
# located in https://github.com/appunite/docker by just wrapping it in a script
# which apparently magically accepts the licenses.
RUN curl -O http://dl.google.com/android/android-sdk_r24.3.4-linux.tgz
RUN tar xf android-sdk_r24.3.4-linux.tgz
COPY android-accept-licenses.sh /build/android-accept-licenses.sh
RUN mv android-sdk-linux /android/sdk
RUN ["./android-accept-licenses.sh", \
     "android - update sdk -a --no-ui --filter platform-tools,android-18,sys-img-armeabi-v7a-android-18"]
RUN echo "no" | android create avd \
                --name test \
                --target android-18 \
                --abi armeabi-v7a

RUN rm -rf /build
WORKDIR /home/rustbuild
