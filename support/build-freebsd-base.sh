#!/bin/bash

set -ex

cd /usr/local/x86_64-unknown-freebsd10

mkdir /tmp/freebsd
curl ftp://ftp.freebsd.org/pub/FreeBSD/releases/amd64/10.2-RELEASE/base.txz | \
  tar xJf - -C /tmp/freebsd ./usr/include ./usr/lib ./lib

cp -r /tmp/freebsd/usr/include .
cp /tmp/freebsd/usr/lib/crt1.o lib
cp /tmp/freebsd/usr/lib/crti.o lib
cp /tmp/freebsd/usr/lib/crtn.o lib
cp /tmp/freebsd/usr/lib/libc.a lib
cp /tmp/freebsd/usr/lib/libm.a lib
cp /tmp/freebsd/usr/lib/librt.so.1 lib
cp /tmp/freebsd/usr/lib/libexecinfo.so.1 lib
cp /tmp/freebsd/lib/libc.so.7 lib
cp /tmp/freebsd/lib/libm.so.5 lib
cp /tmp/freebsd/lib/libthr.so.3 lib/libpthread.so

ln -s libc.so.7 lib/libc.so
ln -s libm.so.5 lib/libm.so
ln -s librt.so.1 lib/librt.so
ln -s libexecinfo.so.1 lib/libexecinfo.so
rm -rf /tmp/freebsd
