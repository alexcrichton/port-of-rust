FROM ubuntu:16.04

RUN apt-get update -y && apt-get install -y --no-install-recommends \
  curl \
  ca-certificates \
  make \
  wget \
  bzip2 \
  g++ \
  xz-utils \
  zlib1g-dev

COPY build-netbsd-toolchain.sh /tmp/
RUN /tmp/build-netbsd-toolchain.sh

FROM ubuntu:16.04
COPY --from=0 /x-tools/ /x-tools
ENV PATH=$PATH:/x-tools/x86_64-unknown-netbsd/bin \
    AR_x86_64_unknown_netbsd=x86_64--netbsd-ar \
    CC_x86_64_unknown_netbsd=x86_64--netbsd-gcc-sysroot \
    CXX_x86_64_unknown_netbsd=x86_64--netbsd-g++-sysroot
