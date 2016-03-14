#!/bin/bash

set -ex

cd /usr/local/x86_64-unknown-netbsd

mkdir /tmp/netbsd
curl http://ftp.netbsd.org/pub/NetBSD/NetBSD-6.1.5/amd64/binary/sets/base.tgz | \
  tar xzf - -C /tmp/netbsd ./usr/include ./usr/lib ./lib
curl http://ftp.netbsd.org/pub/NetBSD/NetBSD-6.1.5/amd64/binary/sets/comp.tgz | \
  tar xzf - -C /tmp/netbsd ./usr/include ./usr/lib

cp -r /tmp/netbsd/usr/include .
cp /tmp/netbsd/usr/lib/crt0.o lib
cp /tmp/netbsd/usr/lib/crti.o lib
cp /tmp/netbsd/usr/lib/crtn.o lib
cp /tmp/netbsd/usr/lib/crtbeginS.o lib
cp /tmp/netbsd/usr/lib/crtendS.o lib
cp /tmp/netbsd/usr/lib/crtbegin.o lib
cp /tmp/netbsd/usr/lib/crtend.o lib
cp /tmp/netbsd/usr/lib/gcrt0.o lib
cp /tmp/netbsd/usr/lib/libc.a lib
cp /tmp/netbsd/usr/lib/libc_p.a lib
cp /tmp/netbsd/usr/lib/libc_pic.a lib
cp /tmp/netbsd/lib/libc.so.12.181 lib
cp /tmp/netbsd/usr/lib/libm.a lib
cp /tmp/netbsd/usr/lib/libm_p.a lib
cp /tmp/netbsd/usr/lib/libm_pic.a lib
cp /tmp/netbsd/lib/libm.so.0.10 lib
cp /tmp/netbsd/usr/lib/librt.so.1.0 lib
cp /tmp/netbsd/usr/lib/libpthread.a lib
cp /tmp/netbsd/usr/lib/libpthread_p.a lib
cp /tmp/netbsd/usr/lib/libpthread_pic.a lib
cp /tmp/netbsd/usr/lib/libpthread.so.1.1 lib

ln -s libc.so.12.181 lib/libc.so
ln -s libc.so.12.181 lib/libc.so.12
ln -s libm.so.0.10 lib/libm.so
ln -s libm.so.0.10 lib/libm.so.0
ln -s libpthread.so.1.1 lib/libpthread.so
ln -s libpthread.so.1.1 lib/libpthread.so.1
ln -s librt.so.1.0 lib/librt.so

rm -rf /tmp/netbsd

