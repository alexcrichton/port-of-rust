#!/bin/sh

set -ex

curl https://ftp.gnu.org/gnu/tar/tar-1.28.tar.bz2 | tar xjf -
mkdir tar-build
cd tar-build
CFLAGS=-D_FORTIFY_SOURCE=0 FORCE_UNSAFE_CONFIGURE=1 \
    ../tar-1.28/configure --prefix=/rustroot
make -j10
make install
yum erase -y tar
