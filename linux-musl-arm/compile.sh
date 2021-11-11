#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

./autogen.sh \
    --build=x86_64-linux-musl \
    --host=arm-linux-musleabihf

cd "$SCRIPT_DIR/mono/eglib"
make

cd "$SCRIPT_DIR/support"
make

cp .libs/libMonoPosixHelper.so /mono/bin
strip --strip-all /mono/bin/libMonoPosixHelper.so