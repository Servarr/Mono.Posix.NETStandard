FROM ubuntu:18.04

ARG DEBIAN_FRONTEND="noninteractive"
ENV TZ="Etc/UTC" LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    build-essential \
    cmake \
    pkg-config \
    libtool \
    language-pack-en

RUN mkdir -p /mono/sources /mono/bin /mono/build
