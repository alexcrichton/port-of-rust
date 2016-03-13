#!/bin/bash

set -ex

VERSION=2.25.1

mkdir -p /tmp/build
cd /tmp/build

curl https://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.bz2 | tar xjf -
mkdir binutils-build
cd binutils-build
../binutils-$VERSION/configure "$@"
make -j10
make install
