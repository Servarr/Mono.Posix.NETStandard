FROM alpine:3.12

ENV TZ="Etc/UTC" LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

RUN apk add --update --no-cache \
    alpine-sdk \
    automake \
    autoconf \
    cmake \
    libtool

RUN mkdir -p /mono/sources /mono/bin /mono/build
