FROM ubuntu:19.10

ARG TOOLCHAIN

RUN apt-get -qq update && \
    apt-get -qq upgrade && \
    apt-get -qq install -y \
        binutils \
        python3-pip \
        python3-venv

COPY build-hmt-deb.sh /root/build-hmt-deb.sh
ENTRYPOINT /root/build-hmt-deb.sh
