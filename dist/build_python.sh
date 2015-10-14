#!/bin/sh

set -ex

curl https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz | tar xzf -
mkdir python-build
cd python-build
CFLAGS='-I /rustroot/include' LDFLAGS='-L /rustroot/lib -L /rustroot/lib64' \
    ../Python-2.7.10/configure --prefix=/rustroot
make -j10
make install
yum erase -y bzip2-devel
