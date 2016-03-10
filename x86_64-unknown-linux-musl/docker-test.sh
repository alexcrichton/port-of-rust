#!/bin/sh

set -ex

cargo new --bin foo
(cd foo && cargo build)
ldd foo/target/x86_64-unknown-linux-musl/debug/foo 2>&1 | grep 'not a dynamic'
