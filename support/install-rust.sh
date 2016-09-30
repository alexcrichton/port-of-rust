curl https://static.rust-lang.org/rustup.sh | \
  sh -s -- \
  --with-target=$1 \
  --yes \
  --disable-sudo \
  --channel=stable
