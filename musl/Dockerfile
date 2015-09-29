FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y curl g++ make cmake xz-utils git

# Support building MUSL nightlies
WORKDIR /build
RUN curl http://www.musl-libc.org/releases/musl-1.1.11.tar.gz | tar xzf -
WORKDIR /build/musl-1.1.11
RUN ./configure --prefix=/musl --disable-shared
RUN make -j10
RUN make install

# To build MUSL we're going to need a libunwind lying around, so acquire that
# here and build it.
WORKDIR /build
RUN curl http://llvm.org/releases/3.7.0/llvm-3.7.0.src.tar.xz | tar xJf -
RUN curl http://llvm.org/releases/3.7.0/libunwind-3.7.0.src.tar.xz | tar xJf -
WORKDIR /build/libunwind-build
RUN cmake ../libunwind-3.7.0.src -DLLVM_PATH=/build/llvm-3.7.0.src \
          -DLIBUNWIND_ENABLE_SHARED=0
RUN make -j10
RUN cp lib/libunwind.a /musl/lib

# Clean up after ourselves, make sure that `cc` is a thing, and then make the
# default working directory a "home-ish" directory
RUN rm -rf /build
WORKDIR /home/rustbuild
ENV PATH=/musl/bin:$PATH
