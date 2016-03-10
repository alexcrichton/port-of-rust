#!/bin/sh
set -ex

cargo new testlib
(cd testlib && cargo build)
rm testlib/target/$TARGET/debug/libtestlib.rlib

cargo new testbin --bin
cat > testbin/Cargo.toml <<-EOF
[project]
name = "testbin"
version = "0.1.0"
authors = []
build = "build.rs"

[build-dependencies]
gcc = "0.3"
EOF

cat > testbin/build.rs <<-EOF
extern crate gcc;

fn main() {
    gcc::Config::new().file("foo.c").compile("libfoo.a");
}
EOF

cat > testbin/foo.c <<-EOF
#include <stdio.h>
#include <stdlib.h>

void foo() {
}
EOF

cat > testbin/src/main.rs <<-EOF
extern {
    fn foo();
}

fn main() {
    unsafe { foo(); }
}
EOF

(cd testbin && cargo build)
rm testbin/target/$TARGET/debug/testbin
