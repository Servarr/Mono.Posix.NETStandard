#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

./autogen.sh \
    --build=x86_64-linux-gnu \
    --host=arm-linux-gnueabihf

CFLAGS='-mfpu=vfpv3-d16'
CXXFLAGS='-mfpu=vfpv3-d16'

cd "$SCRIPT_DIR/mono/eglib"
make

cd "$SCRIPT_DIR/support"
make

cp .libs/libMonoPosixHelper.so /mono/bin
arm-linux-gnueabihf-strip --strip-all /mono/bin/libMonoPosixHelper.so
