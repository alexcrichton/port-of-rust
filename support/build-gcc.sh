#!/bin/bash

set -ex

VERSION=5.3.0

mkdir -p /tmp/build
cd /tmp/build

curl https://ftp.gnu.org/gnu/gcc/gcc-$VERSION/gcc-$VERSION.tar.bz2 | tar xjf -

mkdir gcc-build
cd gcc-$VERSION
./contrib/download_prerequisites

cd ../gcc-build
../gcc-$VERSION/configure "$@"
make -j10
make install

