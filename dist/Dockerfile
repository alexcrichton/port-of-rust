FROM centos:5

# curl == now we can download things
# bzip2 == now we can download bz2 things
# wget == gcc download_prerequisites script dep
# gcc == now we can build gcc
# make == now we can build gcc
# glibc-devel == libs for gcc to compile against
# perl == run openssl configure script + runtime dep of git
# autoconf, gettext == deps of git
# zlib-devel == needed by basically everyone
# bzip2-devel == bzip support in python, needed for unzipping snapshots.
# file == needed by the rust build
# setarch == needed to build 32-bit openssl
# xz == needed to extract LLVM sources
# ncurses-devel == needed by gdb
# texinfo == needed by gdb `make install`
RUN yum install -y curl bzip2 wget gcc make glibc-devel perl autoconf \
                   gettext zlib-devel bzip2-devel file setarch xz \
                   ncurses-devel texinfo

ENV PATH=/rustroot/bin:$PATH
ENV LD_LIBRARY_PATH=/rustroot/lib64:/rustroot/lib

# binutils < 2.22 has a bug where the 32-bit executables it generates
# immediately segfault in Rust, so we need to install our own binutils.
#
# See https://github.com/rust-lang/rust/issues/20440 for more info
WORKDIR /build
RUN curl https://ftp.gnu.org/gnu/binutils/binutils-2.25.1.tar.bz2 | tar xjf -
WORKDIR /build/binutils-build
RUN ../binutils-2.25.1/configure --prefix=/rustroot
RUN make -j10
RUN make install

# Install gcc 4.7 which has C++11 support which is required by LLVM
#
# After we're done building we erase the binutils/gcc installs from CentOS to
# ensure that we always use the ones that we just built.
WORKDIR /build
RUN curl https://ftp.gnu.org/gnu/gcc/gcc-4.7.4/gcc-4.7.4.tar.bz2 | tar xjf -
WORKDIR /build/gcc-4.7.4
RUN ./contrib/download_prerequisites
WORKDIR /build/gcc-4.7.4-build
RUN ../gcc-4.7.4/configure --prefix=/rustroot --enable-languages=c,c++
RUN make -j10
RUN make install
RUN yum erase -y gcc wget binutils

# We need a build of openssl which supports SNI to download artifacts from
# static.rust-lang.org. This'll be used to link into libcurl below (and used
# later as well), so build a copy of OpenSSL with dynamic libraries into our
# generic root.
WORKDIR /build
RUN curl http://openssl.org/source/openssl-1.0.2d.tar.gz | tar xzf -
RUN cp -r openssl-1.0.2d openssl-static-64
RUN cp -r openssl-1.0.2d openssl-static-32
WORKDIR /build/openssl-1.0.2d
RUN ./config --prefix=/rustroot shared -fPIC
RUN make -j10
RUN make install

# Cargo is going to want to link to OpenSSL statically, so build OpenSSL
# statically for 32/64 bit
WORKDIR /build/openssl-static-64
RUN ./config --prefix=/rustroot/cargo64 -fPIC
RUN make -j10
RUN make install
WORKDIR /build/openssl-static-32
RUN setarch i386 ./config --prefix=/rustroot/cargo32 -m32
RUN make -j10
RUN make install
RUN yum erase -y setarch

# The `curl` binary on CenOS doesn't support SNI which is needed for fetching
# some https urls we have, so install a new version of libcurl + curl which is
# using the openssl we just built previously.
#
# Note that we also disable a bunch of optional features of curl that we don't
# really need.
WORKDIR /build
RUN curl http://curl.haxx.se/download/curl-7.44.0.tar.bz2 | tar xjf -
RUN yum erase -y curl
WORKDIR /build/curl-build
# make sure we can run everything that we produce
RUN ../curl-7.44.0/configure --prefix=/rustroot \
      --disable-sspi --disable-gopher --disable-smtp --disable-smb \
      --disable-imap --disable-pop3 --disable-tftp --disable-telnet \
      --disable-manual --disable-dict --disable-rtsp --disable-ldaps \
      --disable-ldap
RUN make -j10
RUN make install

# Apparently CentOS 5.5 desn't have `git` in yum, but we're gonna need it for
# cloning, so download and build it here.
WORKDIR /build
RUN curl https://www.kernel.org/pub/software/scm/git/git-2.5.3.tar.gz | tar xzf -
WORKDIR /build/git-2.5.3
RUN make configure
RUN ./configure --prefix=/rustroot
RUN make -j10
RUN make install
RUN yum erase -y gettext autoconf

# CentOS 5.5 has Python 2.4 by default, but LLVM needs 2.7+
#
# Gotta do some hackery to tell python about our custom OpenSSL build, but other
# than that fairly normal.
WORKDIR /build
RUN curl https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz | tar xzf -
WORKDIR /build/python-build
RUN CFLAGS='-I /rustroot/include' LDFLAGS='-L /rustroot/lib -L /rustroot/lib64' \
    ../Python-2.7.10/configure --prefix=/rustroot
RUN make -j10
RUN make install
RUN yum erase -y bzip2-devel

# libssh2 (a dependency of Cargo) requires cmake 2.8.11 or higher but CentOS
# only has 2.6.4, so build our own
WORKDIR /build
RUN curl http://www.cmake.org/files/v3.3/cmake-3.3.2.tar.gz | tar xzf -
WORKDIR /build/cmake-build
RUN ../cmake-3.3.2/configure --prefix=/rustroot
RUN make -j10
RUN make install

# tar on CentOS is too old as it doesn't understand the --exclude-vcs option
# that the Rust build system passes it, so install a new version.
#
# The weird _FORTIFY_SOURCE option here is passed as a last-ditch attempt to get
# this to build. Apparently there are some inline functions in
# /usr/include/bits/unistd.h which get emitted if _FORTIFY_SOURCE is bigger than
# 0, and apparently tar wants to set this value higher than 0 by default. We
# move it back to get things building (if it works without it though feel free!)
#
# We also pass FORCE_UNSAFE_CONFIGURE as apparently the configure script
# requires us to do that if we're running as root (which we are). Trust me
# though, "I got this".
WORKDIR /build
RUN curl https://ftp.gnu.org/gnu/tar/tar-1.28.tar.bz2 | tar xjf -
WORKDIR /build/tar-build
RUN CFLAGS=-D_FORTIFY_SOURCE=0 FORCE_UNSAFE_CONFIGURE=1 \
    ../tar-1.28/configure --prefix=/rustroot
RUN make -j10
RUN make install
RUN yum erase -y tar

# Support building MUSL nightlies
WORKDIR /build
RUN curl http://www.musl-libc.org/releases/musl-1.1.11.tar.gz | tar xzf -
WORKDIR /build/musl-1.1.11
RUN ./configure --prefix=/rustroot/musl --disable-shared
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
RUN cp lib/libunwind.a /rustroot/musl/lib

# The Rust test suite requires a relatively new version of gdb, much newer than
# CentOS has to offer by default
WORKDIR /build
RUN curl https://ftp.gnu.org/gnu/gdb/gdb-7.9.1.tar.gz | tar xzf -
WORKDIR /build/gdb-build
RUN ../gdb-7.9.1/configure --prefix=/rustroot
RUN make -j10
RUN make install
RUN yum erase -y texinfo ncurses-devel

# Clean up after ourselves, make sure that `cc` is a thing, and then make the
# default working directory a "home-ish" directory
RUN rm -rf /build
RUN ln -s /rustroot/bin/gcc /rustroot/bin/cc
WORKDIR /home/rustbuild
CMD /bin/bash

# prepare for a rust installation being mounted/installed at /rust
ENV PATH=/rust/bin:$PATH
ENV LD_LIBRARY_PATH=/rust/lib:$LD_LIBRARY_PATH
