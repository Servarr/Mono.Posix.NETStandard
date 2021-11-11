FROM muslcc/x86_64:arm-linux-musleabihf

ENV TZ="Etc/UTC" LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

RUN apk add --update --no-cache \
    curl \
    automake \
    autoconf \
    cmake \
    make \
    libtool

RUN mkdir -p /mono/sources /mono/bin /mono/build
