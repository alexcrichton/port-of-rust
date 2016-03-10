#!/bin/sh

set -ex

runtest() {
  target=$1
  docker build -t port-of-rust-test -f $target/Dockerfile .
  docker run -e TARGET=$target -e USER=foo -i port-of-rust-test \
    sh -s -- < ./docker-test.sh

  if [ -f $target/docker-test.sh ]; then
    docker run -e TARGET=$target -e USER=foo -i port-of-rust-test \
      sh -s -- < $target/docker-test.sh
  fi
}

if [ -z "$1" ]; then
  for d in */Dockerfile; do
    target=$(dirname $d)
    runtest $target
  done
else
  runtest $1
fi
