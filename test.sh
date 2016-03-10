set -ex

for d in */Dockerfile; do
  target=$(dirname $d)

  docker build -t port-of-rust-test -f $d .
  docker run -e USER=foo -i port-of-rust-test sh -s -- <<-EOF
cargo new testlib
(cd testlib && cargo build)
rm testlib/target/$target/debug/libtestlib.rlib

cargo new testbin --bin
(cd testbin && cargo build)
rm testbin/target/$target/debug/testbin
EOF
done
