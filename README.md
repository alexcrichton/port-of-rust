# Port of Rust

This repo contains a collection of Dockerfiles for a few images that are useful
for developing Rust. Base images are provided which contain all that's needed to
*build* rust and then sibling images are provided which will have a rust
compiler installed and ready to go for a particular target when built.

## Building images

To build the base image, cd into the respective directory and run:

```
docker build -t base-rust .
```

Next, if you want to have an image with a Rust compiler in it as well you can
build it via:

```
docker build -t rust -f Dockerfile-rust .
```

You can then run the docker image via the standard commands:

```
docker run -it rust
```

## Images

* `musl` - comes with MUSL installed as well as the `x86_64-unknown-linux-musl`
  target ready to go.
* `android` - comes with the Android NDK and SDK installed along with an
  emulator pre-built. You can build for the android target as well run tests in
  the emulator.
* `centos` - this is a very old (5.10) CentOS distribution which we use to build
  Linux binaries that are "as compatible as possible" with older systems because
  the libc is so old. Some newer tools have been installed to build modern
  packages, however.
