#!/bin/sh

set -ex

curl http://openssl.org/source/openssl-1.0.2d.tar.gz | tar xzf -
cp -r openssl-1.0.2d openssl-static-64
cp -r openssl-1.0.2d openssl-static-32
cd openssl-1.0.2d
./config --prefix=/rustroot shared -fPIC
make -j10
make install

# Cargo is going to want to link to OpenSSL statically, so build OpenSSL
# statically for 32/64 bit
cd ../openssl-static-64
./config --prefix=/rustroot/cargo64 -fPIC
make -j10
make install

cd ../openssl-static-32
setarch i386 ./config --prefix=/rustroot/cargo32 -m32
make -j10
make install
yum erase -y setarch
