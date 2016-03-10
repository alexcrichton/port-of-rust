# Port of Rust

This repo contains a collection of docker containers intended for compiling Rust
code for various platforms. Each container contains what should be the bare
minimum for compiling Rust code on the target platform, including:

* A Rust compiler
* A Rust standard library for the target platform
* A C compiler/linker for the target platform

The tests for this repository run a smoke "build a cargo project" for each
platform, so at least "Hello, World!" should be guaranteed to work!

### Platform Support

Most of the platforms here are currently untested, which means that your mileage
may vary when using them. Some concerns to keep in mind when cross compiling
are:

* For Linux targets, the glibc version on the machine you run a binary on must
  be at least the glibc version in each docker container. Currently not much
  effort is done to ensure these glibc versions are "old", but patches are
  welcome!
* For most other targets, they're compiled against "some version" of the OS
  being run on, and it may not always be the case that this version is old
  enough for you to run on your target platform. For example the Android
  container has an API level 21 toolchain, where the binaries of the standard
  library currently support API level 18.
* Various codegen options for cross-compiled linux architectures may not always
  work out. Patches to the standard library and this repository are of course
  welcome!

If those are all taken care of, however, then the cross compilation experience
should be relatively smooth!
