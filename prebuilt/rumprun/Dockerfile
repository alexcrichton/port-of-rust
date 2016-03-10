FROM ubuntu:15.10

RUN apt-get update
RUN apt-get install -y curl file g++ git make

RUN git clone --recursive https://github.com/rumpkernel/rumprun && \
    cd rumprun && \
    git reset --hard 870d868414fe946ee2e24dd6f73d64d27afea4e0 && \
    CC=cc ./build-rr.sh -d /usr/local hw && \
    cd / && \
    rm -rf rumprun
