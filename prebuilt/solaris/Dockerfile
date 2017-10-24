FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  g++ \
  make \
  curl \
  ca-certificates \
  bzip2 \
  xz-utils \
  wget \
  pkg-config \
  software-properties-common

RUN apt-key adv --batch --yes --keyserver keyserver.ubuntu.com --recv-keys 74DA7924C5513486
RUN add-apt-repository -y 'deb http://apt.dilos.org/dilos dilos2-testing main'

COPY build-toolchain.sh /tmp/
RUN /tmp/build-toolchain.sh x86_64  amd64   solaris-i386
RUN /tmp/build-toolchain.sh sparcv9 sparcv9 solaris-sparc

FROM ubuntu:16.04
COPY --from=0 /usr/local /usr/local
ENV AR_sparcv9_sun_solaris=sparcv9-sun-solaris2.11-ar \
    CC_sparcv9_sun_solaris=sparcv9-sun-solaris2.11-gcc \
    CXX_sparcv9_sun_solaris=sparcv9-sun-solaris2.11-g++ \
    AR_x86_64_sun_solaris=x86_64-sun-solaris2.11-ar \
    CC_x86_64_sun_solaris=x86_64-sun-solaris2.11-gcc \
    CXX_x86_64_sun_solaris=x86_64-sun-solaris2.11-g++
