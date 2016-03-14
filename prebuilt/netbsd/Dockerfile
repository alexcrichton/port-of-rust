FROM ubuntu:15.10

RUN apt-get -y update
RUN apt-get -y install curl file make wget bzip2 g++ xz-utils

COPY support/build-binutils.sh /tmp/
RUN bash /tmp/build-binutils.sh \
    --target=x86_64-unknown-netbsd && \
    rm -rf /tmp/build

COPY support/build-netbsd-base.sh /tmp/
RUN bash /tmp/build-netbsd-base.sh

COPY support/build-gcc.sh /tmp/
RUN bash /tmp/build-gcc.sh \
    --enable-languages=c,c++ \
    --disable-libcilkrts \
    --target=x86_64-unknown-netbsd && \
    rm -rf /tmp/build

