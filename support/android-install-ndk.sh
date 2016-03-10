#!/bin/sh

set -ex

curl -O http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin
chmod +x android-ndk-r10e-linux-x86_64.bin
./android-ndk-r10e-linux-x86_64.bin > /dev/null

bash android-ndk-r10e/build/tools/make-standalone-toolchain.sh "$@"

rm -rf ./android-ndk-r10e-linux-x86_64.bin ./android-ndk-r10e
