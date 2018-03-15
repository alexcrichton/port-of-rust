FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  g++ \
  make \
  curl \
  ca-certificates \
  bzip2 \
  xz-utils \
  wget \
  pkg-config

COPY build-toolchain.sh /tmp/
RUN /tmp/build-toolchain.sh

FROM ubuntu:16.04
COPY --from=0 /usr/local /usr/local
ENV CC_x86_64_unknown_freebsd=x86_64-unknown-freebsd11-gcc \
    CXX_x86_64_unknown_freebsd=x86_64-unknown-freebsd11-g++ \
    AR_x86_64_unknown_freebsd=x86_64-unknown-freebsd11-ar \
